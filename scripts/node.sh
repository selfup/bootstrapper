#!/usr/bin/env bash

#########################################################################################
# THIS SCRIPT POTENTIALLY PERFORMS DESTRUCTIVE ACTIONS! PLEASE AUDIT PRIOR TO RUNNING! ##
# THIS SCRIPT POTENTIALLY PERFORMS DESTRUCTIVE ACTIONS! PLEASE AUDIT PRIOR TO RUNNING! ##
#########################################################################################

set -eo pipefail

if [[ ! -d $HOME/.nvm ]]
then
    echo '--- nvm is not installed'
    echo '--- please run ./scripts/nvm.sh first'
    exit 1
fi

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"

echo '--- installing latest Node LTS'
nvm install --lts

echo '--- setting latest LTS as default'
nvm alias default 'lts/*'

echo '--- Node LTS installed successfully'
node --version

echo '--- updating npm'
npm i -g npm && npm --version
