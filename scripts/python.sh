#!/usr/bin/env bash

#########################################################################################
# THIS SCRIPT POTENTIALLY PERFORMS DESTRUCTIVE ACTIONS! PLEASE AUDIT PRIOR TO RUNNING! ##
# THIS SCRIPT POTENTIALLY PERFORMS DESTRUCTIVE ACTIONS! PLEASE AUDIT PRIOR TO RUNNING! ##
#########################################################################################

set -eo pipefail

source scripts/shell_check.sh

if [[ ! -d $HOME/.pyenv ]]
then
    echo '--- pyenv is not installed'
    echo '--- please run ./scripts/pyenv.sh first'
    exit 1
fi

export PYENV_ROOT="$HOME/.pyenv"
[[ -d $PYENV_ROOT/bin ]] && export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init - ${SHELL##*/})"

echo "--- installing python ${PYTHON_VERSION}"
pyenv install -s $PYTHON_VERSION

echo "--- setting python ${PYTHON_VERSION} as global default"
pyenv global $PYTHON_VERSION

echo '--- python installed successfully'
python --version
pip --version
