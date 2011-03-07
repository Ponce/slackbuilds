config() {
  for infile in $1; do
    NEW="$infile"
    OLD="$(dirname $NEW)/$(basename $NEW .new)"
    if [ ! -r $OLD ]; then
      mv $NEW $OLD
    elif [ "$(cat $OLD | md5sum)" = "$(cat $NEW | md5sum)" ]; then
      rm $NEW
    fi
  done
}
preserve_perms() {
  NEW="$1"
  OLD="$(dirname $NEW)/$(basename $NEW .new)"
  if [ -e $OLD ]; then
    cp -a $OLD ${NEW}.incoming
    cat $NEW > ${NEW}.incoming
    mv ${NEW}.incoming $NEW
  fi
  config $NEW
}

config etc/nxserver/node.conf.new
config etc/logrotate.d/freenx-server.new
preserve_perms etc/rc.d/rc.freenx.new

chroot . <<EOCR 2>/dev/null
export \$(grep ^NX_DIR usr/bin/nxloadconfig)
export \$(grep ^NX_HOME_DIR usr/bin/nxloadconfig)
export \$(grep ^NX_SESS_DIR usr/bin/nxloadconfig)
export \$(grep ^NX_ETC_DIR usr/bin/nxloadconfig)
export \$(grep ^NX_LOGFILE usr/bin/nxloadconfig)
export \$(grep ^SSH_AUTHORIZED_KEYS usr/bin/nxloadconfig)

touch \${NX_ETC_DIR}/passwords \${NX_ETC_DIR}/passwords.orig \${NX_LOGFILE}
chmod 600 \${NX_ETC_DIR}/pass* \${NX_LOGFILE}

if [ ! -e \${NX_ETC_DIR}/users.id_dsa ]; then
  ssh-keygen -f \${NX_ETC_DIR}/users.id_dsa -t dsa -N "" > /dev/null 2>&1
fi

if [ -e \${NX_HOME_DIR}/.ssh/client.id_dsa.key ] && \
   [ -e \${NX_HOME_DIR}/.ssh/server.id_dsa.pub.key ]; then
  # There is a pre-existing NX installation. We use the ~nx/.ssh files.
  echo "Copying existing nx ssh keys to \${NX_ETC_DIR} ."
  cp -af \${NX_HOME_DIR}/.ssh/client.id_dsa.key \
    \${NX_ETC_DIR}/client.id_dsa.key
  cp -af \${NX_HOME_DIR}/.ssh/server.id_dsa.pub.key \
    \${NX_ETC_DIR}/server.id_dsa.pub.key
fi

if [ ! -e \${NX_ETC_DIR}/client.id_dsa.key ] || \
   [ ! -e \${NX_ETC_DIR}/server.id_dsa.pub.key ]; then
  # We are going to create a new SSH key for the FreeNX server.
  # The NX client must import this key into it's configuration to be able to
  # connect to the FreeNX server.
  # If you're security minded, use this key exclusively, and remove the
  # NoMachine key from ${NX_HOME_DIR}/.ssh/authorized_keys.
  echo "Creating a new SSH key for the FreeNX server."
  rm -f \${NX_ETC_DIR}/client.id_dsa.key
  rm -f \${NX_ETC_DIR}/server.id_dsa.pub.key
  ssh-keygen -q -t dsa -N '' -f \${NX_ETC_DIR}/local.id_dsa
  mv \${NX_ETC_DIR}/local.id_dsa \${NX_ETC_DIR}/client.id_dsa.key
  mv \${NX_ETC_DIR}/local.id_dsa.pub \${NX_ETC_DIR}/server.id_dsa.pub.key

  # Put our fresh key files in place.
  cp -f \${NX_ETC_DIR}/client.id_dsa.key \
    \${NX_HOME_DIR}/.ssh/client.id_dsa.key
  cp -f \${NX_ETC_DIR}/server.id_dsa.pub.key \
    \${NX_HOME_DIR}/.ssh/server.id_dsa.pub.key
  chmod 600 \
    \${NX_ETC_DIR}/client.id_dsa.key \
    \${NX_ETC_DIR}/server.id_dsa.pub.key \
    \${NX_HOME_DIR}/.ssh/client.id_dsa.key \
    \${NX_HOME_DIR}/.ssh/server.id_dsa.pub.key
  echo -n "no-port-forwarding,no-X11-forwarding,no-agent-forwarding,command=\"/usr/bin/nxserver\" "\
    > \${NX_HOME_DIR}/.ssh/authorized_keys
  cat \${NX_HOME_DIR}/.ssh/server.id_dsa.pub.key \
    >> \${NX_HOME_DIR}/.ssh/authorized_keys
  chmod 640 \${NX_HOME_DIR}/.ssh/authorized_keys
  echo -n "127.0.0.1 " > \${NX_HOME_DIR}/.ssh/known_hosts
  cat etc/ssh/ssh_host_rsa_key.pub >> \${NX_HOME_DIR}/.ssh/known_hosts

  # Add the Nomachine pubkey to ${NX_HOME_DIR}/.ssh/authorized_keys
  # This way, any NX client can connect to our FreeNX server without
  # having to import our own FreeNX private key.
  # If you want an "out-of-the-box" experience, leave the NoMachine key in
  # ${NX_HOME_DIR}/.ssh/authorized_keys. If you're paranoid, remove
  # this pubkey and accept only clients who have our custom FreeNX key.
  cat <<_EOT_ >> \${NX_HOME_DIR}/.ssh/authorized_keys
no-port-forwarding,no-X11-forwarding,no-agent-forwarding,command="/usr/bin/nxserver" ssh-dss AAAAB3NzaC1kc3MAAACBAJe/0DNBePG9dYLWq7cJ0SqyRf1iiZN/IbzrmBvgPTZnBa5FT/0Lcj39sRYt1paAlhchwUmwwIiSZaON5JnJOZ6jKkjWIuJ9MdTGfdvtY1aLwDMpxUVoGwEaKWOyin02IPWYSkDQb6cceuG9NfPulS9iuytdx0zIzqvGqfvudtufAAAAFQCwosRXR2QA8OSgFWSO6+kGrRJKiwAAAIEAjgvVNAYWSrnFD+cghyJbyx60AAjKtxZ0r/Pn9k94Qt2rvQoMnGgt/zU0v/y4hzg+g3JNEmO1PdHh/wDPVOxlZ6Hb5F4IQnENaAZ9uTZiFGqhBO1c8Wwjiq/MFZy3jZaidarLJvVs8EeT4mZcWxwm7nIVD4lRU2wQ2lj4aTPcepMAAACANlgcCuA4wrC+3Cic9CFkqiwO/Rn1vk8dvGuEQqFJ6f6LVfPfRTfaQU7TGVLk2CzY4dasrwxJ1f6FsT8DHTNGnxELPKRuLstGrFY/PR7KeafeFZDf+fJ3mbX5nxrld3wi5titTnX+8s4IKv29HJguPvOK/SI7cjzA+SqNfD7qEo8= root@nettuno
_EOT_
fi # end "no pre-existing NX ssh keys"

if [ -e var/lib/nxserver/running ]; then
  mv var/lib/nxserver/running/* \${NX_SESS_DIR}/running
  mv var/lib/nxserver/closed/* \${NX_SESS_DIR}/closed
  mv var/lib/nxserver/failed/* \${NX_SESS_DIR}/failed
  rm -rf var/lib/nxserver/running
  rm -rf var/lib/nxserver/closed
  rm -rf var/lib/nxserver/failed
fi

chown -R nx:root var/lib/nxserver
chown -R nx:root \${NX_SESS_DIR}
chown -R nx:root \${NX_ETC_DIR}
chown -R nx:root \${NX_HOME_DIR}
chown nx:root \${NX_LOGFILE}

EOCR

usr/bin/nxsetup --install --setup-nomachine-key --uid 243 --gid 243 --auto

WARNI="\n- - - - -\n\n\
The package installs the default nomachine key to protect the connection.\n\
run \"nxsetup --purge --uninstall ; sh preinstall.sh ; nxsetup --install\"\n\
from the build folder to set some custom keys (for additional security).\n\
\n- - - - -\n"
printf "%b\n" "$WARNI"
