#!/usr/bin/env bash

#########################################################################################
# PLEASE AUDIT PRIOR TO RUNNING! ######################## PLEASE AUDIT PRIOR TO RUNNING!#
# PLEASE AUDIT PRIOR TO RUNNING! ######################## PLEASE AUDIT PRIOR TO RUNNING!#
#########################################################################################

if [[ $PROJECT_DIR != "" ]]; then
    mkdir -p \
    $PROJECT_DIR/models \
    $PROJECT_DIR/textures \
    $PROJECT_DIR/shaders \
    $PROJECT_DIR/sounds \
    $PROJECT_DIR/materials \
    $PROJECT_DIR/scenes \
    $PROJECT_DIR/addons \
    $PROJECT_DIR/scripts \
    $PROJECT_DIR/lib
else
    echo '>> Please provide $PROJECT_DIR to know which dir to write bootstrap dirs in!'
fi
