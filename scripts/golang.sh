#!/usr/bin/env bash

###########################################################################
# Deps: grep, curl, tar, uname, $SHELL, $OSTYPE ###########################
# THIS SCRIPT PERFORMS DESTRUCTIVE ACTIONS PLEASE AUDIT PRIOR TO RUNNING ##
# THIS SCRIPT PERFORMS DESTRUCTIVE ACTIONS PLEASE AUDIT PRIOR TO RUNNING ##
###########################################################################

set -eo pipefail

source scripts/shell_check.sh

overwrite="0"

if [[ $1 == "--force" ]]
then
    overwrite="1"
fi

if [[ -d $HOME/go ]]
then
    gv=$(go version)

    echo "--- current installation: $gv"

    if [[ $(echo $gv | grep $GO_DL_VERSION) != "" ]]
    then
        if [[ $overwrite -eq "0" ]]
        then
            echo "--- current go version ${GO_DL_VERSION} already installed and overwrite flag not provided"
            echo "--- please add --force to force an overwrite"
            echo "--- example: ./scripts/golang.sh --force"
            echo "--- exiting"
            exit 0
        fi
    fi

    echo '--- uninstalling previous go version'
    rm -rf $HOME/go || (
        echo "need sudo - please delete $HOME/go with sudo before running script" &&
        echo "PLEASE SAVE YOUR WORK" &&
        echo "If you are not familiar with GOPATH or GOROOT please ABANDON using this script!" &&
        exit
    )
fi

if [[ -d /usr/local/go ]]
then
    echo 'password might be required because go was found in /usr/local/go'
    
    sleep 1
    
    rm -rf /usr/local/go || (
        echo "need sudo - please delete /usr/local/go with sudo before running script" &&
        echo "PLEASE SAVE YOUR WORK" &&
        echo "If you are not familiar with GOPATH or GOROOT please ABANDON using this script!" &&
        exit
    )
fi

go_tarball="go$GO_DL_VERSION.$os_type-amd64.tar.gz"

if [[ $(uname -m) == 'arm64' ]]
then
    go_tarball="go$GO_DL_VERSION.$os_type-arm64.tar.gz"
fi

if [[ ! -f $go_tarball ]]
then
    echo '--- downloading new go version'
    curl https://dl.google.com/go/$go_tarball > $go_tarball
fi

echo '--- unpacking tarball'
tar -C $HOME -xzf $go_tarball

echo '--- checking and creating common paths in GOTPATH'
mkdir -p $HOME/golang/src/github.com
mkdir -p $HOME/golang/src/gitlab.com
mkdir -p $HOME/golang/src/bitbucket.org

echo '--- updating shell metadata'
touch $HOME/$shell_config

echo '--- checking for GOROOT - GOPATH - PATH'
GO_ROOT_SET=$(cat $HOME/$shell_config | grep -q 'GOROOT=$HOME/go' || echo '404')
GO_PATH_SET=$(cat $HOME/$shell_config | grep -q 'GOPATH=$HOME/golang' || echo '404')
PATH_GO_SET=$(cat $HOME/$shell_config | grep -q 'PATH=$PATH:$GOROOT/bin:$GOPATH/bin' || echo '404')

if [[ $GO_ROOT_SET -eq '404' ]]
then
    echo '--- setting GOROOT'
    echo 'export GOROOT=$HOME/go' >> $HOME/$shell_config
fi

if [[ $GO_PATH_SET -eq '404' ]]
then
    echo '--- setting GOPATH'
    echo 'export GOPATH=$HOME/golang' >> $HOME/$shell_config
fi

if [[ $PATH_GO_SET -eq '404' ]]
then
    echo '--- updating PATH'
    echo 'export PATH=$PATH:$GOROOT/bin:$GOPATH/bin' >> $HOME/$shell_config
fi

echo "--- sourcing $shell_config"
source $HOME/$shell_config \
    && echo '--- removing tarball' \
    && rm $go_tarball \
    && echo '--- checking go version' \
    && go version \
    && echo '--- installing go packages' \
    && go install github.com/selfup/scnnr@latest \
    && echo '--- go packages installed successfully' \
    && exit 1 | $SHELL
