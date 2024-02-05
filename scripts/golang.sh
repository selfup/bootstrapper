#!/usr/bin/env bash

###########################################################################
# THIS SCRIPT PERFORMS DESTRUCTIVE ACTIONS PLEASE AUDIT PRIOR TO RUNNING ##
# THIS SCRIPT PERFORMS DESTRUCTIVE ACTIONS PLEASE AUDIT PRIOR TO RUNNING ##
###########################################################################

set -eo pipefail

os_type=''
shell_config=''
env_file='.bootstraper.env'

if [[ -f $env_file ]]
then
    source $env_file
else
    echo 'not at root of repo.. ENV file is not found..'
    echo 'aborting'
    exit 1
fi

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

echo "--- shell config file is: $shell_config ---"
sleep 1
echo "--- OS is: $os_type ---"
sleep 1

if [[ -d $HOME/go ]]
then
    echo '--- uninstalling previous go version ---'
    rm -rf $HOME/go || (echo "need sudo - please delete $HOME/go with sudo before running script" && exit)
fi

if [[ -d /usr/local/go ]]
then
    echo 'password might be required because go was found in /usr/local/go'
    
    sleep 1
    
    rm -rf /usr/local/go || (echo "need sudo - please delete $HOME/go with sudo before running script" && exit)
fi

go_tarball="go$GO_DL_VERSION.$os_type-amd64.tar.gz"

if [[ $(uname -m) == 'arm64' ]]
then
    go_tarball="go$GO_DL_VERSION.$os_type-arm64.tar.gz"
fi

if [[ ! -f $go_tarball ]]
then
    echo '--- downloading new go version ---'
    curl https://dl.google.com/go/$go_tarball > $go_tarball
fi

echo '--- unpacking tarball ---'
tar -C $HOME -xzf $go_tarball

echo '--- checking and creating common paths in GOTPATH ---'
mkdir -p $HOME/golang/src/github.com
mkdir -p $HOME/golang/src/gitlab.com
mkdir -p $HOME/golang/src/bitbucket.org

echo '--- updating shell metadata ---'
touch $HOME/$shell_config

echo '--- checking for GOROOT - GOPATH - PATH ---'
GO_ROOT_SET=$(cat $HOME/$shell_config | grep -q 'GOROOT=$HOME/go' || echo '404')
GO_PATH_SET=$(cat $HOME/$shell_config | grep -q 'GOPATH=$HOME/golang' || echo '404')
PATH_GO_SET=$(cat $HOME/$shell_config | grep -q 'PATH=$PATH:$GOROOT/bin:$GOPATH/bin' || echo '404')

if [[ $GO_ROOT_SET -eq '404' ]]
then
    echo '--- setting GOROOT ---'
    echo 'export GOROOT=$HOME/go' >> $HOME/$shell_config
fi

if [[ $GO_PATH_SET -eq '404' ]]
then
    echo '--- setting GOPATH ---'
    echo 'export GOPATH=$HOME/golang' >> $HOME/$shell_config
fi

if [[ $PATH_GO_SET -eq '404' ]]
then
    echo '--- updating PATH ---'
    echo 'export PATH=$PATH:$GOROOT/bin:$GOPATH/bin' >> $HOME/$shell_config
fi

echo "--- sourcing $shell_config ---"
source $HOME/$shell_config \
    && echo '--- removing tarball ---' \
    && rm $go_tarball \
    && echo '--- checking go version ---' \
    && go version \
    && exit 1 | $SHELL
