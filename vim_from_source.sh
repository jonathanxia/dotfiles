#!/bin/bash

#------------------Compiling VIM from source-------------
cd ~
git clone https://github.com/vim/vim.git
cd vim

PREFIXNAME=/usr/local
# Apparently on Ubuntu you can only use python 2 or python 3. Some garbage like that
./configure --with-features=huge \
            --enable-multibyte \
            --enable-rubyinterp=yes \
            --enable-pythoninterp=yes \
            --with-python-config-dir=/usr/lib/python2.7/config \ # CHANGE TO THE RIGHT THING!
            --enable-python3interp=yes \
            --with-python3-config-dir=/usr/lib/python3.5/config \ # CHANGE TO THE RIGHT THING!
            --enable-perlinterp=yes \
            --enable-luainterp=yes \
            --enable-gui=gtk2 \
            --enable-cscope \
            --prefix=$PREFIXNAME # CHANGE ME to determine where to go. Absolute paths only
make
make install

#------------------Getting non-root copy of CMake-----------------------

# CHANGE ME! Get the most recent version of cmake and replace the link here!
CMAKENAME=cmake-3.14.1-Linux-x86_64
wget https://github.com/Kitware/CMake/releases/download/v3.14.1/$CMAKENAME.tar.gz
tar xvzf $CMAKENAME.tar.gz
# clean it up
rm -f $CMAKENAME.tar.gz

# Append this to path LOL
export PATH="~/cmake-3.14.1-Linux-x86_64/bin:$PATH"

#----------------Re-running YCM installation---------------------------

cd ~/.vim/bundle/YouCompleteMe
./install.py --clang-completer --java-completer

echo "alias vim=$PREFIXNAME/bin/vim" >> ~/.bashrc
