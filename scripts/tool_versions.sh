#!/usr/bin/env bash

#########################################################################################
# PLEASE AUDIT PRIOR TO RUNNING! ######################## PLEASE AUDIT PRIOR TO RUNNING!#
# PLEASE AUDIT PRIOR TO RUNNING! ######################## PLEASE AUDIT PRIOR TO RUNNING!#
#########################################################################################

set -eo pipefail

env_file='.bootstrapper.env'

if [[ -f $env_file ]]
then
    source $env_file
else
    echo 'not at root of repo.. ENV file is not found..'
    echo 'aborting'
    exit 1
fi

echo "java ${JAVA_VERSION}
erlang ${ERLANG_VERSION}
elixir ${ELIXIR_VERSION}
zig ${ZIG_VERSION}
odin ${ODIN_VERSION}" > .tool-versions

echo '--- .tool-versions generated'
