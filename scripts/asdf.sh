#!/usr/bin/env bash

#########################################################################################
# THIS SCRIPT POTENTIALLY PERFORMS DESTRUCTIVE ACTIONS! PLEASE AUDIT PRIOR TO RUNNING! ##
# THIS SCRIPT POTENTIALLY PERFORMS DESTRUCTIVE ACTIONS! PLEASE AUDIT PRIOR TO RUNNING! ##
#########################################################################################

set -eo pipefail

source scripts/shell_check.sh

if command -v asdf &> /dev/null
then
    echo '--- asdf is already installed'
    echo "--- $(asdf -v)"
    exit 0
fi

echo '--- cloning asdf'
git clone https://github.com/asdf-vm/asdf.git $HOME/.asdf --branch v${ASDF_VERSION}

echo '--- checking for asdf config in shell'
touch $HOME/$shell_config

ASDF_PATH_SET=$(grep -q 'ASDF_DATA_DIR:-$HOME/.asdf' $HOME/$shell_config || echo '404')

if [[ $ASDF_PATH_SET == '404' ]]
then
    echo '--- adding asdf config to shell'
    echo '' >> $HOME/$shell_config
    echo 'export PATH="${ASDF_DATA_DIR:-$HOME/.asdf}/shims:$PATH"' >> $HOME/$shell_config
fi

echo '--- asdf installed successfully'
echo "--- please restart your shell or run: source \$HOME/$shell_config"
echo '--- then run ./scripts/asdf_plugins.sh to install plugins and versions'
