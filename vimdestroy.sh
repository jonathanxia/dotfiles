#!/bin/bash

rm -fv ~/.vim/autoload/pathogen.vim
echo "Removing Plugin gunk"
rm -rfv ~/.vim/bundle/*

rm -rfv ~/.config/base16-shell
rm -fv .vimrc
rm -fv .ycm_extra_conf.py
rm -fv .tmux.conf
rm -fv .gitignore
rm -rfv .cfg
rm -fv vimsetup.sh
rm -fv vimdestroy.sh
rm -fv .vimtags
rm -fv .vimrc_background
rm -fv .viminfo
