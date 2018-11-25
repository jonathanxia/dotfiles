#!/bin/bash

# Add pathogen (rtp manager, necessary)
mkdir -p ~/.vim/autoload ~/.vim/bundle && \
	curl -LSso ~/.vim/autoload/pathogen.vim https://tpo.pe/pathogen.vim

# Adding Vundle (an rtp manager, also necessary)
git clone https://github.com/VundleVim/Vundle.vim ~/.vim/bundle/Vundle.vim

# Makes the bottom look fancy.
git clone https://github.com/vim-airline/vim-airline ~/.vim/bundle/vim-airline

# Gives you the pane on the left with files
git clone https://github.com/scrooloose/nerdtree ~/.vim/bundle/nerdtree
git clone https://github.com/jistr/vim-nerdtree-tabs ~/.vim/bundle/vim-nerdtree-tabs

# Install ctags
# Comment this line out if you already have ctags
sudo apt-get install exuberant-ctags

# Gives you tags in your vim, with the tag bar on the right, displaying function names
git clone https://github.com/xolox/vim-misc ~/.vim/bundle/vim-misc
git clone https://github.com/xolox/vim-easytags ~/.vim/bundle/vim-easytags
git clone https://github.com/craigemery/vim-autotag ~/.vim/bundle/vim-autotag
git clone https://github.com/majutsushi/tagbar ~/.vim/bundle/tagbar

# Some autocomplete garbage
git clone https://github.com/vim-scripts/AutoComplPop ~/.vim/bundle/AutoComplPop

# ctrl-p, which is a file finder. Press ctrl-P and you can search for files
git clone https://github.com/kien/ctrlp.vim.git ~/.vim/bundle/ctrlp.vim

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
