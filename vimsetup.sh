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

echo "check to see you have cmake installed and vim has python enabled"
cd ~/.vim/bundle/YouCompleteMe
./install.py --clang-completer --java-completer

