if [ ! -d /usr/bin/Resources ]; then
  mkdir -p /usr/bin/Resources
  ln -sf /usr/share/antscope2/QtLanguage.qm /usr/bin/Resources/
  ln -sf /usr/share/antscope2/QtLanguage.ts /usr/bin/Resources/
  ln -sf /usr/share/antscope2/QtLanguage_ja.qm /usr/bin/Resources/
  ln -sf /usr/share/antscope2/QtLanguage_ja.ts /usr/bin/Resources/
  ln -sf /usr/share/antscope2/QtLanguage_ru.qm /usr/bin/Resources/
  ln -sf /usr/share/antscope2/QtLanguage_ru.ts /usr/bin/Resources/
  ln -sf /usr/share/antscope2/QtLanguage_uk.qm /usr/bin/Resources/
  ln -sf /usr/share/antscope2/QtLanguage_uk.ts /usr/bin/Resources/
  ln -sf /usr/share/antscope2/cables.txt /usr/bin/Resources/
  ln -sf /usr/share/antscope2/itu-regions-defaults.txt /usr/bin/Resources/
  ln -sf /usr/share/antscope2/itu-regions.txt /usr/bin/Resources/
fi

if [ -x /usr/bin/update-desktop-database ]; then
  /usr/bin/update-desktop-database -q usr/share/applications >/dev/null 2>&1
fi
