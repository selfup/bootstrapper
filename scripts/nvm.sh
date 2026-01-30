#!/usr/bin/env bash

#########################################################################################
# THIS SCRIPT POTENTIALLY PERFORMS DESTRUCTIVE ACTIONS! PLEASE AUDIT PRIOR TO RUNNING! ##
# THIS SCRIPT POTENTIALLY PERFORMS DESTRUCTIVE ACTIONS! PLEASE AUDIT PRIOR TO RUNNING! ##
#########################################################################################

set -eo pipefail

source scripts/shell_check.sh

if [[ -d $HOME/.nvm ]]
then
    echo '--- nvm is already installed'
    echo '--- to reinstall, remove $HOME/.nvm and run this script again'
    exit 0
fi

echo '--- installing nvm'
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v${NVM_VERSION}/install.sh | bash

echo '--- checking for NVM_DIR in shell config'
touch $HOME/$shell_config

NVM_DIR_SET=$(cat $HOME/$shell_config | grep -q 'NVM_DIR="$HOME/.nvm"' || echo '404')

if [[ $NVM_DIR_SET -eq '404' ]]
then
    echo '--- adding nvm config to shell'
    echo '' >> $HOME/$shell_config
    echo 'export NVM_DIR="$HOME/.nvm"' >> $HOME/$shell_config
    echo '[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"' >> $HOME/$shell_config
    echo '[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"' >> $HOME/$shell_config
fi

echo '--- nvm installed successfully'
echo '--- please restart your shell or run: source $HOME/$shell_config'
echo '--- then run ./scripts/node.sh to install the latest Node LTS'
