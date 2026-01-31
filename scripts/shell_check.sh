#!/usr/bin/env bash

# Shared shell/OS detection logic - source this from other scripts

env_file='.bootstrapper.env'

if [[ -f $env_file ]]
then
    source $env_file
else
    echo 'not at root of repo.. ENV file is not found..'
    echo 'aborting'
    exit 1
fi

if ! command -v git &> /dev/null
then
    echo '--- git is not installed'
    echo '--- please install git first'
    echo '--- macOS: xcode-select --install'
    echo '--- linux: sudo apt install git (or your package manager)'
    echo '--- aborting'
    exit 1
fi

os_type=''
shell_config=''

shell_not_supported() {
    echo 'shell not supported..'
    echo "current shell is: $SHELL"
    echo "aborting!"
    exit 1
}

os_not_supported() {
    echo 'OS not supported..'
    echo "current OS is: $OSTYPE"
    echo 'aborting!'
    exit 1
}

rc_finder() {
    if [[ $SHELL == '/bin/bash' ]]
    then
        shell_config="$1"
    elif [[ $SHELL == '/bin/zsh' ]]
    then
        shell_config="$2"
    else
       shell_not_supported
    fi
}

if [[ "$OSTYPE" == "linux-gnu"* ]]
then
    os_type='linux'

    rc_finder '.bashrc' '.zshrc'
elif [[ "$OSTYPE" == "darwin"* ]]
then
    os_type='darwin'

    rc_finder '.bash_profile' '.zshrc'
else
    os_not_supported
fi

echo "--- shell config file is: $shell_config"
sleep 1
echo "--- OS is: $os_type"
sleep 1
