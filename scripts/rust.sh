#!/usr/bin/env bash

#########################################################################################
# THIS SCRIPT POTENTIALLY PERFORMS DESTRUCTIVE ACTIONS! PLEASE AUDIT PRIOR TO RUNNING! ##
# THIS SCRIPT POTENTIALLY PERFORMS DESTRUCTIVE ACTIONS! PLEASE AUDIT PRIOR TO RUNNING! ##
#########################################################################################

set -eo pipefail

curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y

source $HOME/.cargo/env
