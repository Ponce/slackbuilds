# Remove vscode-inisiders package that was installed via vscode-insiders-updater:
INSTALLED_VERSION=$(ls -v /var/log/packages/vscode-insiders-* 2>/dev/null | cut -d- -f3 | grep '^.[0-9]\+$' | sort -r | head -1)
if [ -n "$INSTALLED_VERSION" ]; then
    echo "Found previously installed Visual Studio Code Insiders package version $INSTALLED_VERSION..."
    echo "please run: /sbin/removepkg vscode-insiders-$INSTALLED_VERSION-*"
fi
