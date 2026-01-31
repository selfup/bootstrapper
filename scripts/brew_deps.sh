#!/usr/bin/env bash

#########################################################################################
# PLEASE AUDIT PRIOR TO RUNNING! ######################## PLEASE AUDIT PRIOR TO RUNNING!#
# PLEASE AUDIT PRIOR TO RUNNING! ######################## PLEASE AUDIT PRIOR TO RUNNING!#
#########################################################################################

set -eo pipefail

if [[ "$OSTYPE" != "darwin"* ]]
then
    echo '--- this script is only for macOS'
    echo '--- aborting'
    exit 1
fi

if ! command -v brew &> /dev/null
then
    echo '--- homebrew is not installed'
    echo '--- please install homebrew first'
    echo '--- go to https://brew.sh for install instructions'
    echo '--- then re-run this script'
    exit 1
fi

echo '--- installing brew dependencies'

brew install \
    pyenv \
    asdf \
    imagemagick \
    ffmpeg \
    odin \
    zig \
    elixir \
    gleam \
    sqlite \
    htop \
    wget \
    curl

echo '--- brew dependencies installed successfully'
