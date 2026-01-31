#!/usr/bin/env bash

#########################################################################################
# THIS SCRIPT POTENTIALLY PERFORMS DESTRUCTIVE ACTIONS! PLEASE AUDIT PRIOR TO RUNNING! ##
# THIS SCRIPT POTENTIALLY PERFORMS DESTRUCTIVE ACTIONS! PLEASE AUDIT PRIOR TO RUNNING! ##
#########################################################################################

set -eo pipefail

source scripts/shell_check.sh

if ! command -v asdf &> /dev/null
then
    echo '--- asdf is not installed'
    echo '--- please run ./scripts/asdf.sh or install via brew'
    exit 1
fi

install_tool() {
    local tool=$1
    local version=$2

    echo "--- adding plugin: $tool"
    asdf plugin add $tool || true

    echo "--- installing $tool $version"
    asdf install $tool $version

    echo "--- setting $tool $version as global"
    asdf set --home $tool $version
}

# install in order: java first (erlang uses it for docs)
install_tool java "$JAVA_VERSION"
install_tool erlang "$ERLANG_VERSION"
install_tool elixir "$ELIXIR_VERSION"
install_tool zig "$ZIG_VERSION"
install_tool odin "$ODIN_VERSION"

echo '--- all plugins and versions installed successfully'
