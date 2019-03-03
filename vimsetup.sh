#!/bin/bash

# Add pathogen (rtp manager, necessary)
mkdir -p ~/.vim/autoload ~/.vim/bundle && \
	curl -LSso ~/.vim/autoload/pathogen.vim https://tpo.pe/pathogen.vim

# Adding Vundle (an rtp manager, also necessary)
git clone https://github.com/VundleVim/Vundle.vim ~/.vim/bundle/Vundle.vim

# Install ctags
# Comment this line out if you already have ctags
sudo apt-get install exuberant-ctags

# Base 16 shells to get the google dark color scheme.
git clone https://github.com/chriskempson/base16-shell.git ~/.config/base16-shell
cd ~/.vim/bundle
git clone https://github.com/chriskempson/base16-vim.git
cd ~
# For google-dark color scheme for your terminal. If you don't want that, you can get rid of this line.
base16_google-dark

# Gets you jedi vim, for python autocompletion and more semantic understanding. Could be slow though
#...for some reason
mkdir ~/.vim/bundle/jedi-vim
cd ~/.vim/bundle/jedi-vim
git submodule update --init
cd ~
