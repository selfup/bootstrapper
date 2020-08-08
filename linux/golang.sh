#!/usr/bin/env bash

# Please Read the LICENSE and README in the repo: https://github.com/selfup/linux_go.git
# If you are reading this because you forked or cloned the repo you know where to find the files

set -e

GO_DL_VERSION='go1.14.7'

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

GO_DL_VERSION=go1.14.4

if [[ ! -f $GO_DL_VERSION.linux-amd64.tar.gz ]]
then
    wget https://dl.google.com/go/$GO_DL_VERSION.linux-amd64.tar.gz
fi

tar -C $HOME -xzf $GO_DL_VERSION.linux-amd64.tar.gz

mkdir -p $HOME/golang/src/github.com
mkdir -p $HOME/golang/src/gitlab.com
mkdir -p $HOME/golang/src/bitbucket.org

touch $HOME/.bashrc

GO_ROOT_SET=$(cat $HOME/.bashrc | grep -q 'GOROOT=$HOME/go' || echo '9042')
GO_PATH_SET=$(cat $HOME/.bashrc | grep -q 'GOPATH=$HOME/golang' || echo '9042')
PATH_GO_SET=$(cat $HOME/.bashrc | grep -q 'PATH=$PATH:$GOROOT/bin:$GOPATH/bin' || echo '9042')

if [[ $GO_ROOT_SET -eq '9042' ]]
then
    echo 'export GOROOT=$HOME/go' >> $HOME/.bashrc
fi

if [[ $GO_PATH_SET -eq '9042' ]]
then
    echo 'export GOPATH=$HOME/golang' >> ~/.bashrc
fi

if [[ $PATH_GO_SET -eq '9042' ]]
then
    echo 'export PATH=$PATH:$GOROOT/bin:$GOPATH/bin' >> ~/.bashrc
fi

source $HOME/.bashrc

rm $GO_DL_VERSION.linux-amd64.tar.gz

go version
