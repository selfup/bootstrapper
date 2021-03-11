#!/usr/bin/env bash

# This script is only for Linux or MacOS and amd64 (x86) CPU architectures!
# Please Read the LICENSE and README in the repo: https://github.com/selfup/linux_go.git
# If you are reading this because you forked or cloned the repo you know where to find the files

set -eo pipefail

os_type=''
which_shell=''
env_file='.bootstraper.env'

if [[ -f $env_file ]]
then
    source $env_file
else
    echo 'not at root of repo.. ENV file is not found..'
    echo 'aborting'
    exit 1
fi

if [[ "$OSTYPE" == "linux-gnu"* ]]
then
    os_type='linux'
    which_shell='.bashrc'
elif [[ "$OSTYPE" == "darwin"* ]]
then
    os_type='darwin'
    which_shell='.bash_profile'
else
    echo 'OS not supported..'
    echo "current OS is: $OSTYPE"
    echo 'aborting!'
    exit 1
fi

# check for zsh after OS check
if [[ $SHELL == '/bin/zsh' ]]
then
    which_shell='.zshrc'
fi

if [[ $which_shell == '' ]]
then
    echo 'shell or OS not supported..'
    echo "current shell is: $SHELL"
    echo "aborting!"
    exit 1
fi

echo "--- shell config file is: $which_shell ---"
sleep 1s
echo "--- OS is: $os_type ---"
sleep 1s

if [[ -d $HOME/go ]]
then
    echo '--- uninstalling previous go version ---'
    rm -rf $HOME/go
fi

if [[ -d /usr/local/go ]]
then
    echo 'password might be required because go was found in /usr/local/go'
    
    sleep 1s
    
    rm -rf /usr/local/go || sudo rm -rf /usr/local/go
fi

go_tarball=$GO_DL_VERSION.$os_type-amd64.tar.gz

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
touch $HOME/$which_shell

echo '--- checking for GOROOT - GOPATH - PATH ---'
GO_ROOT_SET=$(cat $HOME/$which_shell | grep -q 'GOROOT=$HOME/go' || echo '404')
GO_PATH_SET=$(cat $HOME/$which_shell | grep -q 'GOPATH=$HOME/golang' || echo '404')
PATH_GO_SET=$(cat $HOME/$which_shell | grep -q 'PATH=$PATH:$GOROOT/bin:$GOPATH/bin' || echo '404')

if [[ $GO_ROOT_SET -eq '404' ]]
then
    echo '--- setting GOROOT ---'
    echo 'export GOROOT=$HOME/go' >> $HOME/$which_shell
fi

if [[ $GO_PATH_SET -eq '404' ]]
then
    echo '--- setting GOPATH ---'
    echo 'export GOPATH=$HOME/golang' >> $HOME/$which_shell
fi

if [[ $PATH_GO_SET -eq '404' ]]
then
    echo '--- updating PATH ---'
    echo 'export PATH=$PATH:$GOROOT/bin:$GOPATH/bin' >> $HOME/$which_shell
fi

echo "--- sourcing $which_shell ---"
source $HOME/$which_shell

echo '--- removing tarball ---'
rm $go_tarball

echo '--- checking go version ---'
go version
