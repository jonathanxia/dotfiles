#!/bin/bash

#------------------Compiling VIM from source-------------
cd ~
git clone https://github.com/vim/vim.git
cd vim

PREFIXNAME=$HOME/vim81    # CHANGE ME!
VIMVERSION=v8.1.0000
git checkout $VIMVERSION
# Apparently on Ubuntu you can only use python 2 or python 3. Some garbage like that
# If you want to use Python 3 you can add --enable-python3interp=yes
# Also you may need to add this or something --with-python3-config-dir=/usr/lib/python3.5/config
# Where the config directory is set to something correct
./configure --with-features=huge \
            --enable-multibyte \
            --enable-rubyinterp=yes \
            --enable-pythoninterp=yes \
            --with-python-config-dir=/usr/lib/python2.7/config-x86_64-linux-gnu \
            --enable-perlinterp=yes \
            --enable-luainterp=yes \
            --enable-gui=gtk2 \
            --enable-cscope \
            --prefix=$PREFIXNAME # CHANGE ME to determine where to go. Absolute paths only
make
make install

echo "alias vim=$PREFIXNAME/bin/vim" >> ~/.bashrc
cd ~

#------------------Getting non-root copy of CMake-----------------------

# CHANGE ME! Get the most recent version of cmake and replace the link here!
CMAKENAME=cmake-3.14.1-Linux-x86_64
wget https://github.com/Kitware/CMake/releases/download/v3.14.1/$CMAKENAME.tar.gz
tar xvzf $CMAKENAME.tar.gz
# clean it up
rm -f $CMAKENAME.tar.gz

#-----------------Reinstall YCM-------------------
export PATH="$HOME/$CMAKENAME/bin:$PATH"
cd ~/.vim/bundle/YouCompleteMe
./install.py --clang-completer --java-completer

#-----------------Remove CMake------------------
rm -rf $CMAKENAME
