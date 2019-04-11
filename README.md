# dotfiles

Jonathan Xia's dotfiles. I use tmux and vim for pretty much everything,
and one of the nice advantages is that you can plop down (pretty much)
anywhere, copy over the files, and have the exact same look/feel/functionality!

I version control my dotfiles so that one can clone this git repo if they
go somewhere else.

## Setup instructions

Add the following line to your `.bashrc`

`alias config='/usr/bin/git --git-dir=$HOME/.cfg/ --work-tree=$HOME'`

and then source your `.bashrc`. Note that if you are running over
an ssh connection, you'd edit the `.bash_profile`.

Now clone the repo into a bare repository:

`git clone --bare https://github.com/jonathanxia/dotfiles $HOME/.cfg`

and then you can now run (assuming your bashrc is successfully sourced),

`config checkout`

Note that this might overwrite some of your files, and git will complain if you are
about to do so. You can back them up if you care, delete if you don't.

Then run

`./vimsetup.sh`

This script will install all the good stuff, like vim plugins. I use
base16 colors to normalize the colorschemes.
Getting this base16 thing to work requires you to have a 256 color terminal. You can probably configure
this in your terminal settings. You can run

`~/.config/base16-shell/colortest`

to see if you got it to work. The last few lines should *not* be blue.

You may also need to go here: https://github.com/powerline/fonts for the fonts to make powerline work.
If you see a bunch of question marks on your powerline status bar on the bottom, that means you don't
have the proper fonts. You'll have to install those...somehow!

## YCM

You may run into issues about YCM demanding that you have a very new version of
VIM, or maybe it yelled at you about not having CMake installed. The
solution to this is to install Vim from source. Take a look at
`vim_from_source.sh`. Do NOT blindly run this script, take a look at it
first. Replace all the paths with the correct things.

There are comments that will remind you where to change things. You can
comment out portions that you don't need (e.g., you already have CMake
installed, so don't install it). Be sure to find the correct
config directory for Python.

The last part will then rerun the YCM installation.

Note that you may be missing Python headers. You'll have to install
them via `apt-get install python3-dev` or `apt-get install python-dev`.
