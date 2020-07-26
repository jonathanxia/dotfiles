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
parser.add_argument("--vim-dir", default=p.join(HOME_DIR, "vim81"), help="Directory in which to install VIM")
parser.add_argument("--vim-version", default="v8.1.0000", help="Version of VIM you want")
parser.add_argument("--no-ycm", action='store_true', help='If passed, do not recompile YCM (if you did so already or something)')
args = parser.parse_args()


def call(args):
    '''Calls the command line with args'''
    try:
        # We expand the variable names in the arguments right now
        args = p.expandvars(args)
        args = shlex.split(args)
        args = [p.expanduser(arg) for arg in args]
        subprocess.check_call(args, stdout=sys.stdout, stdin=sys.stdin, stderr=sys.stderr)
    except subprocess.CalledProcessError as error:
        print("FAILED:", args)
        sys.exit(1)

call("/usr/bin/git --git-dir=$HOME/.cfg/ --work-tree=$HOME config --local status.showUntrackedFiles no")

# Adding Vundle (an rtp manager, also necessary)
if not p.exists(p.expanduser("~/.vim/bundle/Vundle.vim")):
    print("Obtaining Vundle...")
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
    with open(p.expanduser("~/.bashrc"), 'a') as f:
        f.write(base16_comment + "\n")
        f.write(r'''BASE16_SHELL="$HOME/.config/base16-shell/"''' + "\n")
        f.write(r'''[ -n "$PS1" ] && [ -s "$BASE16_SHELL/profile_helper.sh" ] && eval "$("$BASE16_SHELL/profile_helper.sh")"''' + "\n")

call("vim +PluginInstall +qall -u ~/.vimrcslow")

print("Running color test")
os.chdir(p.expanduser("~/.config/base16-shell"))
call("./colortest")
print("Last few lines should not be blue!")
os.chdir(p.expanduser("~"))

call(r'''git config --global alias.lg "log --graph --pretty=format:'%C(yellow)%d%Creset %C(cyan)%h%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset' --abbrev-commit --date=short --all"''')

# Get the tmux plugin manager
if not p.exists(p.expanduser("~/.tmux")):
    call("git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm")


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
    if not p.exists("vim"):
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
                       "--with-x",
                       "--prefix=%s" % args.vim_dir]

    os.environ["LDFLAGS"] = p.expandvars("-L$HOME/usr/local/lib")
    call("./configure " + " ".join(configure_flags))
    call("make")
    call("make install")

    with open(p.expanduser("~/.bashrc"), 'a') as f:
        f.write("alias vim=%s/bin/vim" % args.vim_dir + "\n")
    os.chdir(HOME_DIR)

#------------------Getting non-root copy of CMake-----------------------
if not args.no_ycm:
    # CHANGE ME! Get the most recent version of cmake and replace the link here!
    CMAKENAME="cmake-3.18.0-Linux-x86_64"
    call("wget https://github.com/Kitware/CMake/releases/download/v3.18.0/%s.tar.gz" % CMAKENAME)
    call("tar xvzf %s.tar.gz" % CMAKENAME)
    # clean it up
    call("rm -f %s.tar.gz" % CMAKENAME)

    #-----------------Reinstall YCM-------------------
    os.chdir(p.expanduser("~/.vim/bundle/YouCompleteMe"))
    os.environ["PATH"] = p.expandvars("$HOME/%s/bin" % CMAKENAME) + os.pathsep + os.environ["PATH"]
    call(r'''./install.py --clang-completer --java-completer''')
    os.chdir(HOME_DIR)

    #-----------------Remove CMake------------------
    call("rm -rf %s" % CMAKENAME)
