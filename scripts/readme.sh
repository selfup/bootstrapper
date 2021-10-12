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

### :warning: Steps and Warnings :warning:

1. Inspect all scripts before running them
1. Fully understand what the commands are doing

#### Linux/Mac: Go ${GO_DL_VERSION}

\`./scripts/golang.sh\`

#### Windows: Go ${GO_DL_VERSION}

:warning: _this will start downloading the .msi_ :warning:

https://golang.org/doc/install?download=go${GO_DL_VERSION}.windows-amd64.msi

### LICENSE

This project is MIT licensed. Please check the LICENSE file." > README.md
