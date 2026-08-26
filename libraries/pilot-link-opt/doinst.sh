
# udev rules, but not if there's a rules file there already.

RULES=`compgen -G lib/udev/rules.d/*-libpisock.rules`

if [ "$RULES" ]; then
   echo
   echo =========================================
   echo Not installing udev rules.
   echo Already installed: $RULES
   echo Possibly by stock Slackware pilot-link package.
   echo =========================================
   echo
else
   # Install it.
   # Follow the example  of the stock Slack 15 SlackBuild.
   RULES=/lib/udev/rules.d/80-libpisock.rules
   cp -av opt/pilot-link/share/pilot-link/udev/60-libpisock.rules "$RULES"
   sed -i "s/0664/0660/g" $RULES
fi


