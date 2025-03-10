#!/usr/bin/env bash

#########################################################################################
# PLEASE AUDIT PRIOR TO RUNNING! ######################## PLEASE AUDIT PRIOR TO RUNNING!#
# PLEASE AUDIT PRIOR TO RUNNING! ######################## PLEASE AUDIT PRIOR TO RUNNING!#
#########################################################################################

set -eo pipefail

env_file='.bootstraper.env'

if [[ -f $env_file ]]
then
    source $env_file
else
    echo 'not at root of repo.. ENV file is not found..'
    echo 'aborting'
    exit 1
fi

echo "# Bootstrapper

Install/Configure/Boilerplate/Bricklay/Bootstrap things on stuff!

Currently supports:

* Installing Go (golang) on x86_64/arm64 Linux/Mac.
* Installing Rust on Linux/Mac
* Bootstrapping a Godot project
- Running Godot in headless mode to exec a script
- Adding a convenient tmux config with better pane oriented pane control commands

### :warning: Steps and Warnings :warning:

1. If you are not me, you should probably not use this.
1. It can be destructive!
1. I repeat, this was written for me
1. Inspect all scripts before running them
1. Fully understand what the commands are doing

## Examples..

#### Linux/Mac: Go ${GO_DL_VERSION}

Deps: grep, curl, tar, uname, \$SHELL, \$OSTYPE

\`./scripts/golang.sh\`

Force an overwrite of current version installed in the path this script installs in:

\`./scripts/golang.sh --force\`

If the flag is not provided then this scripts will exit 0

Example use:

\`\`\`console
bootstrapper (master) $ ./scripts/golang.sh
--- shell config file is: .bashrc ---
--- OS is: linux ---
--- current installation: go version go1.24.1 linux/amd64 ---
--- current go version 1.24.1 already installed and overwrite flag not provided ---
--- exiting ---
\`\`\`

#### Windows: Go ${GO_DL_VERSION}

:warning: _this will start downloading the .msi_ :warning:

https://go.dev/doc/install?download=go${GO_DL_VERSION}.windows-amd64.msi

### LICENSE

This project is MIT licensed. Please check the LICENSE file." > README.md
