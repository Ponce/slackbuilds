if [ -x /usr/bin/update-desktop-database ]; then
  /usr/bin/update-desktop-database -q usr/share/applications >/dev/null 2>&1
fi

# Adopted from control.tar.gz/postinst.
# Thanks to Eduardo Domínguez.
function getMaxLibCxx(){
    local maxVersion=0
    local path=$1

    if test -f "$path"; then
        versions=$(strings $path | grep LIBCXX)
        for version in $versions
        do
            versionArr=(${version//./ })
            versionArrLen=${#versionArr[@]}
            if [ $versionArrLen == 3 ]
            then
                if [ ${versionArr[2]} -gt ${maxVersion} ]
                then
                    maxVersion=${versionArr[2]}
                fi
            fi
        done
    fi
    echo "$maxVersion"
}

localLib=/usr/lib64/libstdc++.so.6
local_max_version="$(getMaxLibCxx $localLib)"

packageLib=/opt/Webex/lib/libstdc++.so.6
deactivatedPackageLib=/opt/Webex/lib/xlibstdc++.so.6
package_max_version="$(getMaxLibCxx $packageLib)"

if [ ${local_max_version} -ge ${package_max_version} ]
then
    if test -f "$packageLib"; then
        mv -f $packageLib $deactivatedPackageLib
    fi
fi
