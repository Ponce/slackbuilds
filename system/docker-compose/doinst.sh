# Install docker-compose to docker-cli global plugin directory
PLUGIN_DIR="/usr/libexec/docker/cli-plugins"

if [ ! -d "$PLUGIN_DIR" ]; then
    mkdir -p $PLUGIN_DIR
fi

ln -sf /usr/bin/docker-compose $PLUGIN_DIR/docker-compose
