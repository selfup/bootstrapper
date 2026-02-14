#!/usr/bin/env bash

#########################################################################################
# THIS SCRIPT POTENTIALLY PERFORMS DESTRUCTIVE ACTIONS! PLEASE AUDIT PRIOR TO RUNNING! ##
# THIS SCRIPT POTENTIALLY PERFORMS DESTRUCTIVE ACTIONS! PLEASE AUDIT PRIOR TO RUNNING! ##
#########################################################################################

set -eo pipefail

if command -v rustup &> /dev/null; then
    echo '--- rust is already installed'
    rustc --version
    echo '--- updating rust to latest stable'
    rustup update stable
    echo '--- skipping to cargo force install'
else
    echo '--- installing rust via rustup'
    curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y
fi

source $HOME/.cargo/env

echo '--- installing cargo packages'

cargo install \
    hexyl \
    ripgrep \
    bottom \
    exa \
    fd-find \
    bat \
    jaq \
    xsv \
    --force

echo '--- cargo packages installed successfully'
