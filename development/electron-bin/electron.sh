#!/bin/sh
# Electron wrapper script — /usr/bin/electron

# --- Load system-wide configuration files ---
for f in /etc/electron/*.conf; do
    [ -f "$f" ] && . "$f"
done

# --- Default Electron binary location ---
ELECTRON_PATH="/usr/share/electron/electron"

# --- Sanity check ---
if [ ! -x "$ELECTRON_PATH" ]; then
    echo "Error: Electron binary not found or not executable at $ELECTRON_PATH" >&2
    exit 1
fi

# --- Merge user flags (if set) ---
if [ -n "$ELECTRON_USER_FLAGS" ]; then
    ELECTRON_FLAGS="$ELECTRON_FLAGS $ELECTRON_USER_FLAGS"
fi

# --- Export environment variables for child processes ---
export ELECTRON_FLAGS
export ELECTRON_OZONE_PLATFORM_HINT="${ELECTRON_OZONE_PLATFORM_HINT}"

# --- Handle Electron run-as-node mode ---
if [ "$ELECTRON_RUN_AS_NODE" = "1" ] && [ "$ELECTRON_STILL_PASS_THE_DEFAULT_FLAGS" != "1" ]; then
    exec "$ELECTRON_PATH" "$@"
fi

# --- Launch Electron normally ---
cd "$(dirname "$ELECTRON_PATH")" || exit 1
exec "$ELECTRON_PATH" $ELECTRON_FLAGS "$@"
