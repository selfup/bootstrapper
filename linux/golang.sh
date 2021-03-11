#!/usr/bin/env bash

# Please Read the LICENSE and README in the repo: https://github.com/selfup/linux_go.git
# If you are reading this because you forked or cloned the repo you know where to find the files

set -eo pipefail

GO_DL_VERSION='go1.16'

if [[ $1 == '' ]]
then
    echo 'no arg ($1) provided - aborting!'
    exit 1
fi

which_shell=''

if [[ $SHELL == '/bin/bash' ]]
then
    if [[ $1 == 'linux' ]]
    then
        which_shell='.bashrc'
    fi

    if [[ $1 == 'mac' ]]
    then
        which_shell='.bash_profile'
    fi
fi

if [[ $SHELL == '/bin/zsh' ]]
then
    which_shell='.zshrc'
fi

if [[ $which_shell == '' ]]
then
    echo 'shell not supported..'
    echo "current shell is: $SHELL"
    echo "aborting!"
    exit 1
fi

if [[ -d $HOME/go ]]
then
    rm -rf $HOME/go
fi

if [[ -d /usr/local/go ]]
then
    echo 'password might be required because go was found in /usr/local/go'
    
    sleep 1s
    
    sudo rm -rf /usr/local/go
fi

if [[ ! -f $GO_DL_VERSION.linux-amd64.tar.gz ]]
then
    curl https://dl.google.com/go/$GO_DL_VERSION.linux-amd64.tar.gz > $GO_DL_VERSION.linux-amd64.tar.gz
fi

tar -C $HOME -xzf $GO_DL_VERSION.linux-amd64.tar.gz

mkdir -p $HOME/golang/src/github.com
mkdir -p $HOME/golang/src/gitlab.com
mkdir -p $HOME/golang/src/bitbucket.org

touch $HOME/$which_shell

GO_ROOT_SET=$(cat $HOME/$which_shell | grep -q 'GOROOT=$HOME/go' || echo '9042')
GO_PATH_SET=$(cat $HOME/$which_shell | grep -q 'GOPATH=$HOME/golang' || echo '9042')
PATH_GO_SET=$(cat $HOME/$which_shell | grep -q 'PATH=$PATH:$GOROOT/bin:$GOPATH/bin' || echo '9042')

if [[ $GO_ROOT_SET -eq '9042' ]]
then
    echo 'export GOROOT=$HOME/go' >> $HOME/$which_shell
fi

if [[ $GO_PATH_SET -eq '9042' ]]
then
    echo 'export GOPATH=$HOME/golang' >> $HOME/$which_shell
fi

if [[ $PATH_GO_SET -eq '9042' ]]
then
    echo 'export PATH=$PATH:$GOROOT/bin:$GOPATH/bin' >> $HOME/$which_shell
fi

source $HOME/$which_shell

rm $GO_DL_VERSION.linux-amd64.tar.gz

go version
