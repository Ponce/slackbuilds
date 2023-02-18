# Update all the shared library links:
if [ -x /sbin/ldconfig ]; then
  echo "Updating shared library links: /sbin/ldconfig"
  /sbin/ldconfig 2>/dev/null
fi
