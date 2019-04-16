#!/usr/bin/env python
from __future__ import print_function
from __future__ import absolute_import

import argparse
import os.path as p
import os
import sys
import subprocess
import shlex

HOME_DIR = os.getenv("HOME")

parser = argparse.ArgumentParser()
parser.add_argument("--vim-src", action='store_true', help="Compile vim from source. When VIM version is < 8.0")
parser.add_argument("--vim-dir", default=HOME_DIR + "vim81", help="Directory in which to install VIM")
parser.add_argument("--vim-version", default="v8.1.0000", help="Version of VIM you want")
parser.add_argument("--no-ycm", action='store_true', help='If passed, do not recompile YCM (if you did so already or something)')
args = parser.parse_args()


def call(args):
    '''Calls the command line with args'''
    try:
        # They say not to use shell=True, but we are not taking external input here. For now.
        subprocess.check_call(shlex.split(args), stdout=sys.stdout, stdin=sys.stdin, stderr=sys.stderr, shell=True)
    except subprocess.CalledProcessError as error:
        print("uh oh")
        sys.exit(1)

call(shlex.split("/usr/bin/git --git-dir=$HOME/.cfg/ --work-tree=$HOME config --local status.showUntrackedFiles no"))

# Add pathogen (rtp manager, necessary)
call("mkdir -p ~/.vim/autoload ~/.vim/bundle && curl -LSso ~/.vim/autoload/pathogen.vim https://tpo.pe/pathogen.vim")

# Adding Vundle (an rtp manager, also necessary)
if not p.exists(p.expanduser("~/.vim/bundle/Vundle.vim")):
    call("git clone https://github.com/VundleVim/Vundle.vim ~/.vim/bundle/Vundle.vim")

# Install ctags
# Comment this line out if you already have ctags
print("Make sure you have exuberant-ctags installed on your machine!")
# sudo apt-get install exuberant-ctags

# Base 16 shells to get the google dark color scheme.
if not p.exists(p.expanduser("~/.config/base16-shell")):
    call("git clone https://github.com/chriskempson/base16-shell.git ~/.config/base16-shell")

# Check if the Base16 Shell comment is there that is left by this script
has_base_16 = False
base16_comment = "# Base16 Shell"
f = open(p.expanduser("~/.bashrc"), 'r')
for line in f.readlines():
    if line.strip() == base16_comment:
        has_base_16 = True
f.close()

if not has_base_16:
    with f as open(p.expanduser("~/.bashrc"), 'a'):
        f.write(base16_comment)
        f.write(r'''BASE16_SHELL="$HOME/.config/base16-shell/"''')
        f.write(r'''[ -n "$PS1" ] && [ -s "$BASE16_SHELL/profile_helper.sh" ] && eval "$("$BASE16_SHELL/profile_helper.sh")""''')

call("vim +PluginInstall +qall")

print("Running color test")
os.chdir(p.expanduser("~/.config/base16-shell"))
call("./colortest")
print("Last few lines should not be blue!")
os.chdir(p.expanduser("~"))

call(r'''git config --global alias.lg "log --graph --pretty=format:'%C(yellow)%d%Creset %C(cyan)%h%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset' --abbrev-commit --date=short --all"''')


if args.vim_src:
    # Now we get the curses library
    # Check if the curses library is already installed in home directory
    if not p.exists(p.expanduser("~/usr/local")):
        CURSESNAME = "ncurses-6.1"
        call("wget http://ftp.gnu.org/pub/gnu/ncurses/%s.tar.gz" % CURSESNAME)
        call("tar -xzvf %s.tar.gz" % CURSESNAME)
        os.chdir(CURSESNAME)
        call("./configure --prefix=$HOME/usr/local")
        call("make")
        call("make install")
        os.chdir(HOME_DIR)
        # Clean up the downloaded files
        call("rm -f %s.tar.gz" % CURSESNAME)
        call("rm -rf %s" % CURSESNAME)

    #------------------Compiling VIM from source-------------
    call("git clone https://github.com/vim/vim.git")
    os.chdir("vim")

    call("git checkout " + args.vim_version)
    # Apparently on Ubuntu you can only use python 2 or python 3. Some garbage like that
    # If you want to use Python 3 you can add --enable-python3interp=yes
    # Also you may need to add this or something --with-python3-config-dir=/usr/lib/python3.5/config
    # Where the config directory is set to something correct
    configure_flags = ["--with-features=huge",
                       "--enable-multibyte",
                       "--enable-rubyinterp=yes",
                       "--enable-pythoninterp=yes",
                       "--with-python-config-dir=/usr/lib/python2.7/config-x86_64-linux-gnu",
                       "--enable-perlinterp=yes",
                       "--enable-luainterp=yes",
                       "--enable-gui=gtk2",
                       "--enable-cscope",
                       "--prefix=%s" % args.vim_dir]

    call("LDFLAGS=-L$HOME/usr/local/lib ./configure " + " ".join(configure_flags))
    call("make")
    call("make install")

    with f as open(p.expanduser("~/.bashrc")):
        f.write("alias vim=%s/bin/vim" % args.vim_dir)
    os.chdir(HOME_DIR)

#------------------Getting non-root copy of CMake-----------------------
if not args.no_ycm:
    # CHANGE ME! Get the most recent version of cmake and replace the link here!
    CMAKENAME="cmake-3.14.1-Linux-x86_64"
    call("wget https://github.com/Kitware/CMake/releases/download/v3.14.1/%s.tar.gz" % CMAKENAME)
    call("tar xvzf %s.tar.gz" % CMAKENAME)
    # clean it up
    call("rm -f %s.tar.gz" % CMAKENAME)

    #-----------------Reinstall YCM-------------------
    os.chdir(p.expanduser("~/.vim/bundle/YouCompleteMe"))
    call(r'''PATH="$HOME/%s/bin:$PATH" ./install.py --clang-completer --java-completer''' % CMAKENAME)
    os.chdir(HOME_DIR)

    #-----------------Remove CMake------------------
    call("rm -rf %s" % CMAKENAME)
