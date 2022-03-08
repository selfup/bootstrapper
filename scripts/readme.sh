#!/usr/bin/env bash

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

Install things on stuff!

Currently support installing Go (golang) on x86_64 platforms.

### :warning: Steps and Warnings :warning:

1. If you are not me, you should probably not use this.
1. It can be destructive!
1. I repeat, this was written for me
1. No Apple M1/ARM support
1. Inspect all scripts before running them
1. Fully understand what the commands are doing

#### Linux/Mac: Go ${GO_DL_VERSION}

\`./scripts/golang.sh\`

#### Windows: Go ${GO_DL_VERSION}

:warning: _this will start downloading the .msi_ :warning:

https://golang.org/doc/install?download=go${GO_DL_VERSION}.windows-amd64.msi

### LICENSE

This project is MIT licensed. Please check the LICENSE file." > README.md
