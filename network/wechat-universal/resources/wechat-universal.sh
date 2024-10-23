#!/bin/bash
#
# wechat-universal.sh - wrapper for WeChat Universal
# Copyright (C) 2024 Guoxin "7Ji" Pu <pugokushin@gmail.com>
#
# This program is free software; you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation; either version 2 of the License, or
# (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this program; if not, write to the Free Software
# Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301, USA.
#

dbus_call() { # $1: dest, $2: object path, $3: method
    local args=(dbus-send --session --dest="$1" --print-reply "${@:2}")
    echo "D-Bus calling with: ${args[@]}" >&2
    "${args[@]}"
}

# Based on: https://github.com/web1n/wechat-universal-flatpak/blob/91f5d0d246881077812881e800a22f5a02cea438/wechat.sh#L3
notifier_get() {
    local dbus_item
    for dbus_item in $(
        dbus_call org.freedesktop.DBus /org/freedesktop/DBus org.freedesktop.DBus.ListNames |
            sed -n 's/      string "\(org\.kde\.StatusNotifierItem.\+\)"/\1/p'
    )
    do
        if dbus_call "${dbus_item}" \
                /StatusNotifierItem \
                org.freedesktop.DBus.Properties.Get \
                string:org.kde.StatusNotifierItem \
                string:Id |
            grep -q 'string "wechat"'
        then
            echo "${dbus_item}"
            return
        fi
    done
}

try_move_foreground() {
    # Try to find existing WeChat window first and display it, before actually opening a new one
    notifier_item=$(notifier_get)
    if [[ "${notifier_item}" ]]; then
        echo 'WeChat is already running, moving it to foreground'
        # Based on: https://github.com/web1n/wechat-universal-flatpak/blob/91f5d0d246881077812881e800a22f5a02cea438/wechat.sh#L25
        dbus_call "${notifier_item}" \
            /StatusNotifierItem \
            org.kde.StatusNotifierItem.Activate \
            int32:0 \
            int32:0
        return $?
    fi
    return 1
}

try_start() {

    # Data folder setup
    # If user has declared a custom data dir, no need to query xdg for documents dir, but always resolve that to absolute path
    if [[ "${WECHAT_DATA_DIR}" ]]; then
        WECHAT_DATA_DIR=$(readlink -f -- "${WECHAT_DATA_DIR}")
    else
        XDG_DOCUMENTS_DIR="${XDG_DOCUMENTS_DIR:-$(xdg-user-dir DOCUMENTS)}"
        if [[ -z "${XDG_DOCUMENTS_DIR}" ]]; then
            echo 'Error: Failed to get XDG_DOCUMENTS_DIR, refuse to continue'
            exit 1
        fi
        WECHAT_DATA_DIR="${XDG_DOCUMENTS_DIR}/WeChat_Data"
    fi
    echo "Using '${WECHAT_DATA_DIR}' as Wechat Data folder"
    WECHAT_FILES_DIR="${WECHAT_DATA_DIR}/xwechat_files"
    WECHAT_HOME_DIR="${WECHAT_DATA_DIR}/home"

    # Runtime folder setup
    XDG_RUNTIME_DIR="${XDG_RUNTIME_DIR:-$(xdg-user-dir RUNTIME)}"
    if [[ -z "${XDG_RUNTIME_DIR}" ]]; then
        echo 'Error: Failed to get XDG_RUNTIME_DIR, refuse to continue'
        exit 1
    fi
    if [[ -z "${XAUTHORITY}" ]]; then
        echo 'Warning: No XAUTHORITY set, runnning in no-X environment? Generating it'
        export XAUTHORITY=$(mktemp "${XDG_RUNTIME_DIR}"/xauth_XXXXXX)
        echo "Info: Generated XAUTHORITY at '${XAUTHORITY}'"
    fi

    # wechat-universal only supports xcb
    export QT_QPA_PLATFORM=xcb \
        QT_AUTO_SCREEN_SCALE_FACTOR=1 \
        PATH="/sandbox:${PATH}"

    if [[ -z "${IME_WORKAROUND}" || "${IME_WORKAROUND}" == 'auto' ]]; then
        case "${XMODIFIERS}" in 
            *@im=fcitx*)
                IME_WORKAROUND='fcitx'
                ;;
            *@im=ibus*)
                IME_WORKAROUND='ibus'
                ;;
        esac
    fi

    case "${IME_WORKAROUND}" in
        fcitx)
            echo "IME workaround for fcitx applied"
            export QT_IM_MODULE=fcitx \
                GTK_IM_MODULE=fcitx
            ;;
        ibus)
            echo "IME workaround for ibus applied"
            export QT_IM_MODULE=ibus \
                GTK_IM_MODULE=ibus \
                IBUS_USE_PORTAL=1
            ;;
    esac

    BWRAP_DEV_BINDS=()
    for DEV_NODE in /dev/{nvidia{-uvm,ctl,*[0-9]},video*[0-9]}; do
        [[ -e "${DEV_NODE}" ]] && BWRAP_DEV_BINDS+=(--dev-bind "${DEV_NODE}"{,})
    done

    # Custom exposed folders
    # echo "Hint: Custom binds could either be declared in '~/.config/wechat-universal/binds.list', each line a path, absolute or relative to your HOME; or as argument \`--bind [custom bind]\`"
    BWRAP_CUSTOM_BINDS=()
    if [[ -f "${CUSTOM_BINDS_CONFIG}" ]]; then
        mapfile -t CUSTOM_BINDS_PRESISTENT < "${CUSTOM_BINDS_CONFIG}"
    fi
    cd ~ # 7Ji: two chdir.3 should be cheaper than a lot of per-dir calculation
    for CUSTOM_BIND in  "${CUSTOM_BINDS_RUNTIME[@]}" "${CUSTOM_BINDS_PRESISTENT[@]}"; do
        CUSTOM_BIND=$(readlink -f -- "${CUSTOM_BIND}")
        echo "Custom bind: '${CUSTOM_BIND}'"
        BWRAP_CUSTOM_BINDS+=(--bind "${CUSTOM_BIND}"{,})
    done
    cd - > /dev/null

    DBUS_SESSION_BUS_PATH=''
    if [[ "${DBUS_SESSION_BUS_ADDRESS}" ]]; then
        DBUS_SESSION_BUS_PATH=$(echo "${DBUS_SESSION_BUS_ADDRESS}" | sed 's/^unix:\(.\+=.\+\)\?path=\(.\+\)\(,.\+=.\+\|$\)/\2/')
    fi
    if [[ -z "${DBUS_SESSION_BUS_PATH}" ]]; then
        DBUS_SESSION_BUS_PATH="${XDG_RUNTIME_DIR}/bus"
        echo "Failed to extract \$DBUS_SESSION_BUS_ADDRESS from \$DBUS_SESSION_BUS_ADDRESS (${DBUS_SESSION_BUS_ADDRESS}), using fallback ${DBUS_SESSION_BUS_PATH}"
    fi

    mkdir -p "${WECHAT_FILES_DIR}" "${WECHAT_HOME_DIR}"
    ln -snf "${WECHAT_FILES_DIR}" "${WECHAT_HOME_DIR}/xwechat_files"

    BWRAP_ARGS=(
        # Drop privileges
        --unshare-all
        --share-net
        --cap-drop ALL
#        --die-with-parent

        # /
        --ro-bind /bin{,}
        --ro-bind /sbin{,}
        --ro-bind /lib{,}
        --ro-bind /lib64{,}
        # /usr
        --ro-bind /usr{,}

        --bind /bin/true /usr/bin/lsblk

        # /sandbox
        --ro-bind /usr/lib64/flatpak-xdg-utils/xdg-open /sandbox/xdg-open
        --ro-bind /usr/lib64/wechat-universal/bin/dde-file-manager /sandbox/dde-file-manager
        --ro-bind /sbin/ip /sandbox/ip
        # /dev
        --dev /dev
        --dev-bind /dev/dri{,}
        --tmpfs /dev/shm

        # /proc
        --proc /proc

        # /etc
        --ro-bind /etc/machine-id{,}
        --ro-bind /etc/passwd{,}
        --ro-bind /etc/nsswitch.conf{,}
        --ro-bind /etc/resolv.conf{,}
        --ro-bind /etc/localtime{,}
        --ro-bind-try /etc/fonts{,}

        # /sys
        --dir /sys/dev # hack for Intel / AMD graphics, mesa calling virtual nodes needs /sys/dev being 0755
        --ro-bind /sys/dev/char{,}
        --ro-bind /sys/devices{,}

        # /tmp
        --tmpfs /tmp

        # /opt
        --ro-bind /opt/wechat-universal{,}

        # license fixups in various places
        --ro-bind /usr/lib64/wechat-universal/license/ /usr/lib/license
        --ro-bind /usr/lib64/wechat-universal/etc/lsb-release /etc/lsb-release

        # /home
        --bind "${WECHAT_HOME_DIR}" "${HOME}"
        --bind "${WECHAT_FILES_DIR}"{,}
        --bind-try "${HOME}/.pki"{,}
        --ro-bind-try "${HOME}/.fontconfig"{,}
        --ro-bind-try "${HOME}/.fonts"{,}
        --ro-bind-try "${HOME}/.config/fontconfig"{,}
        --ro-bind-try "${HOME}/.local/share/fonts"{,}
        --ro-bind-try "${HOME}/.icons"{,}
        --ro-bind-try "${HOME}/.local/share/icons"{,}

        # /run
        --dev-bind /run/dbus{,}
        --ro-bind-try /run/systemd/userdb{,}
        --ro-bind-try "${XAUTHORITY}"{,}
#        --ro-bind "${DBUS_SESSION_BUS_PATH}"{,}
        --ro-bind "${XDG_RUNTIME_DIR}/pulse"{,}
        --setenv DBUS_SESSION_BUS_PATH "${DBUS_SESSION_BUS_PATH}"
        --setenv LD_PRELOAD "/usr/lib64/wechat-universal/keyBlocker.so:${LD_PRELOAD}"
    )

    exec bwrap "${BWRAP_ARGS[@]}" "${BWRAP_CUSTOM_BINDS[@]}" "${BWRAP_DEV_BINDS[@]}" /opt/wechat-universal/wechat "$@"
    echo "Error: Failed to exec bwrap, rerun this script with 'bash -x $0' to show the full command history"
    return 1
}

bwrap_start() {
    IFS=':' read -r -a CUSTOM_BINDS_RUNTIME <<< "${CUSTOM_BINDS}"
    if [[ -z "${CUSTOM_BINDS_CONFIG}" && ! -v CUSTOM_BINDS_CONFIG ]]; then
        CUSTOM_BINDS_CONFIG=~/.config/wechat-universal/binds.list
    fi
    # Parsing arguments, for any option, argument > environment
    while [[ $# -gt 0 ]]; do
        case "$1" in 
            '--data')
                WECHAT_DATA_DIR="$2"
                shift
                ;;
            '--bind')
                CUSTOM_BINDS_RUNTIME+=("$2")
                shift
                ;;
            '--binds-config')
                CUSTOM_BINDS_CONFIG="$2"
                shift
                ;;
            '--ime')
                IME_WORKAROUND="$2"
                shift
                ;;
            '--help')
                if [[ "${LANG}" == zh_CN* ]]; then
                    echo "$0 (--data [微信数据文件夹]) (--bind [自定义绑定挂载] (--bind ...))) (--ime [输入法]) (--help)"
                    echo 
                    printf '    --%s\t%s\n' \
                        'data [微信数据文件夹]' '微信数据文件夹的路径，绝对路径，或相对于用户HOME的相对路径。 默认：~/文档/Wechat_Data；环境变量: WECHAT_DATA_DIR' \
                        'bind [自定义绑定挂载]' '自定义的绑定挂载，可被声明多次，绝对路径，或相对于用户HOME的相对路径。环境变量: CUSTOM_BINDS （用冒号:分隔，与PATH相似）' \
                        'binds-config [文件]' '以每行一个的方式列明应被绑定挂载的路径的纯文本配置文件，每行定义与--bind一致。默认：~/.config/wechat-universal/binds.list；环境变量：CUSTOM_BINDS_CONFIG' \
                        'ime [输入法名称或特殊值]' '应用输入法对应环境变量修改，可支持：fcitx (不论是否为5), ibus，特殊值：none不应用，auto自动判断。默认: auto；环境变量: IME_WORKAROUND'\
                        'help' ''
                    echo
                    echo "命令行参数比环境变量优先级更高，如果命令行参数与环境变量皆为空，则使用默认值"
                else
                    echo "$0 (--data [wechat data]) (--bind [custom bind] (--bind ...))) (--ime [ime]) (--help)"
                    echo 
                    printf '    --%s\t%s\n' \
                        'data [wechat data]' 'Path to Wechat_Data folder, absolute or relative to user home, default: ~/Documents/Wechat_Data, as environment: WECHAT_DATA_DIR' \
                        'bind [custom bind]' 'Custom bindings, could be specified multiple times, absolute or relative to user home, as environment: CUSTOM_BINDS (colon ":" seperated like PATH)' \
                        'binds-config [file]' 'Path to text file that contains one --bind value per line, default: ~/.config/wechat-universal/binds.list, as environment: CUSTOM_BINDS_CONFIG'\
                        'ime [input method]' 'Apply IME-specific workaround, support: fcitx (also for 5), ibus, default: auto, as environment: IME_WORKAROUND'\
                        'help' ''
                    echo
                    echo "Arguments take priority over environment, if both argument and environment are empty, the default value would be used"
                fi
                return 0
                ;;
        esac
        shift
    done
    if try_move_foreground; then
        return 0
    else
        try_start "$@"
        return $?
    fi
}

bwrap_stop() {
    # Try to find existing WeChat window first and display it, before actually opening a new one
    notifier_item=$(notifier_get)
    [[ -z "${notifier_item}" ]] && return
    echo 'Stopping running WeChat instance'
    # Based on: https://github.com/web1n/wechat-universal-flatpak/blob/91f5d0d246881077812881e800a22f5a02cea438/wechat.sh#L35
    dbus_call "${notifier_item}" \
        /MenuBar \
        com.canonical.dbusmenu.Event \
        int32:1 \
        string:clicked \
        variant:string:'Quit WeChat' \
        uint32:0
}

command="$1"
case "$command" in
  'stop')
    shift
    bwrap_stop "$@"
    ;;
  'start')
    shift
    bwrap_start "$@"
    ;;
  *)
    echo "Unknown command '${command}', allowed: start, stop"
    exit 1
    ;;
esac
exit $?
