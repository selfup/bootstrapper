#!/usr/bin/env bash

# Please Read the LICENSE and README in the repo: https://github.com/selfup/bootstrapper.git
# If you are reading this because you forked or cloned the repo you know where to find the files

set -e

FLUTTER_VERSION='1.22.6-stable.zip'

GOOGLE_APIS='https://storage.googleapis.com'
FLUTTER_OS='flutter_macos_'
FLUTTER_MAC_OS_RELEASES="$GOOGLE_APIS/flutter_infra/releases/stable/macos"
FLUTTER_DOWNLOAD_URL="${FLUTTER_MAC_OS_RELEASES}/${FLUTTER_OS}${FLUTTER_VERSION}"

wget $FLUTTER_DOWNLOAD_URL -O ~/Downloads/$FLUTTER_VERSION || exit 1

mkdir -p $HOME/development

cd $HOME/development

unzip ~/Downloads/$FLUTTER_VERSION

cd -

flutter_path='export PATH=$PATH:$HOME/development/flutter/bin'

is_path_set=$(cat $HOME/.bash_profile | grep -q $flutter_path || echo '1')

if [[ is_path_set == '1' ]]
then
  echo $flutter_path >> ~/.bash_profile
fi

source $HOME/.bash_profile

flutter precache

flutter doctor --android-licenses

flutter doctor

which flutter
