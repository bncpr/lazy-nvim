#!/bin/sh

NV_APP_NAME=lazy-nvim
NV_APP_CONFIG=~/.config/$NV_APP_NAME
export NV_APP_NAME NV_APP_CONFIG

rm -rf $NV_APP_CONFIG
ln -srf "$(pwd)" ~/.config/
ln -srf nv.sh ~/.local/bin/nv
