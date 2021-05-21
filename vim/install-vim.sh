#!/bin/bash

WORKDIR=$(pwd)
HOMEDIR="~/"

function install_vim {
    cp -r $WORKDIR/.vim* $HOMEDIR
}

