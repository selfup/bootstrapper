#!/usr/bin/env bash

#########################################################################################
# PLEASE AUDIT PRIOR TO RUNNING! ######################## PLEASE AUDIT PRIOR TO RUNNING!#
# PLEASE AUDIT PRIOR TO RUNNING! ######################## PLEASE AUDIT PRIOR TO RUNNING!#
#########################################################################################

set -eo pipefail

if [[ "$OSTYPE" != "linux-gnu"* ]]
then
    echo '--- this script is only for Linux'
    echo '--- aborting'
    exit 1
fi

if ! command -v apt &> /dev/null
then
    echo '--- apt not found'
    echo '--- this script only supports apt-based distros'
    echo '--- aborting'
    exit 1
fi

packages=(
    build-essential
    curl
    wget
    git
    htop
    sqlite3
    imagemagick
    ffmpeg
)

missing_packages=()

for pkg in "${packages[@]}"
do
    if ! dpkg -s $pkg &> /dev/null
    then
        missing_packages+=($pkg)
    fi
done

if [[ ${#missing_packages[@]} -gt 0 ]]
then
    echo '--- missing packages'
    echo '--- please run:'
    echo "sudo apt install -y ${missing_packages[*]}"
    echo '--- then re-run this script to verify'
    exit 1
fi

echo '--- all apt dependencies are installed'
