#!/usr/bin/env bash

#########################################################################################
# THIS SCRIPT POTENTIALLY PERFORMS DESTRUCTIVE ACTIONS! PLEASE AUDIT PRIOR TO RUNNING! ##
# THIS SCRIPT POTENTIALLY PERFORMS DESTRUCTIVE ACTIONS! PLEASE AUDIT PRIOR TO RUNNING! ##
#########################################################################################

set -eo pipefail

source scripts/shell_check.sh

if [[ -d $HOME/.pyenv ]]
then
    echo '--- pyenv is already installed'
    echo '--- to reinstall, remove $HOME/.pyenv and run this script again'
    exit 0
fi

if [[ "$os_type" == "darwin" ]]
then
    if ! command -v brew &> /dev/null
    then
        echo '--- homebrew is not installed'
        echo '--- please install homebrew first'
        echo '--- go to https://brew.sh for install instructions'
        echo '--- then re-run this script'
        exit 1
    fi

    echo '--- checking for xcode command line tools'
    if ! xcode-select -p &> /dev/null
    then
        echo '--- xcode command line tools not found'
        echo '--- please run:'
        echo 'xcode-select --install'
        echo '--- then re-run this script'
        exit 1
    fi

    echo '--- installing python build dependencies via homebrew'
    brew install openssl readline ncurses
fi

if [[ "$os_type" == "linux" ]]
then
    if command -v apt &> /dev/null
    then
        missing_deps=()

        for pkg in build-essential libssl-dev zlib1g-dev libbz2-dev libreadline-dev libsqlite3-dev libffi-dev
        do
            if ! dpkg -s $pkg &> /dev/null
            then
                missing_deps+=($pkg)
            fi
        done

        if [[ ${#missing_deps[@]} -gt 0 ]]
        then
            echo '--- missing python build dependencies'
            echo '--- please run:'
            echo "sudo apt install -y ${missing_deps[*]}"
            echo '--- then re-run this script'
            exit 1
        fi

        echo '--- all python build dependencies are installed'
    else
        echo '--- apt not found - please install python build deps manually'
        echo '--- see: https://github.com/pyenv/pyenv/wiki'
        echo '--- then re-run this script'
        exit 1
    fi
fi

echo '--- installing pyenv'
curl https://pyenv.run | bash

echo '--- checking for pyenv config in shell'
touch $HOME/$shell_config

PYENV_ROOT_SET=$(grep -q 'PYENV_ROOT="$HOME/.pyenv"' $HOME/$shell_config || echo '404')

if [[ $PYENV_ROOT_SET == '404' ]]
then
    echo '--- adding pyenv config to shell'
    echo '' >> $HOME/$shell_config
    echo 'export PYENV_ROOT="$HOME/.pyenv"' >> $HOME/$shell_config
    echo '[[ -d $PYENV_ROOT/bin ]] && export PATH="$PYENV_ROOT/bin:$PATH"' >> $HOME/$shell_config
    echo "eval \"\$(pyenv init - ${SHELL##*/})\"" >> $HOME/$shell_config
fi

echo '--- pyenv installed successfully'
echo "--- please restart your shell or run: source \$HOME/$shell_config"
echo '--- then run ./scripts/python.sh to install python'
