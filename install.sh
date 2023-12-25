#!/bin/sh

MNV_APP_NAME=lazy-nvim
MNV_APP_CONFIG=~/.config/$MNV_APP_NAME
export MNV_APP_NAME MNV_APP_CONFIG

rm -rf $MNV_APP_CONFIG
ln -srf "$(pwd)" ~/.config/
ln -srf lnv.sh ~/.local/bin/lnv
