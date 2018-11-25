#!/bin/bash

# Add pathogen
mkdir -p ~/.vim/autoload ~/.vim/bundle && \
	curl -LSso ~/.vim/autoload/pathogen.vim https://tpo.pe/pathogen.vim

git clone https://github.com/vim-airline/vim-airline ~/.vim/bundle/vim-airline
git clone https://github.com/jistr/vim-nerdtree-tabs ~/.vim/bundle/vim-nerdtree-tabs
git clone https://github.com/xolox/vim-misc ~/.vim/bundle/vim-misc

# Install ctags
sudo apt-get install exuberant-ctags

git clone https://github.com/xolox/vim-easytags ~/.vim/bundle/vim-easytags
git clone https://github.com/craigemery/vim-autotag ~/.vim/bundle/vim-autotag
git clone https://github.com/scrooloose/nerdtree ~/.vim/bundle/nerdtree
git clone https://github.com/majutsushi/tagbar ~/.vim/bundle/tagbar
git clone https://github.com/vim-scripts/AutoComplPop ~/.vim/bundle/AutoComplPop
git clone https://github.com/VundleVim/Vundle.vim ~/.vim/bundle/Vundle.vim
git clone https://github.com/kien/ctrlp.vim.git ~/.vim/bundle/ctrlp.vim
git clone https://github.com/chriskempson/base16-shell.git ~/.config/base16-shell

mkdir ~/.vim/bundle/jedi-vim
cd ~/.vim/bundle/jedi-vim
git submodule update --init
cd ~
