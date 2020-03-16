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

This comes with a Python script to help set up VIM. There are a few options
available, so you can do `python setupvim.py --help` to see what options
are available.

By default, just run

`python setupvim.py`

This script will install all the good stuff, like vim plugins. I use
base16 colors to normalize the colorschemes.
Getting this base16 thing to work requires you to have a 256 color terminal. You can probably configure
this in your terminal settings. You can run

`~/.config/base16-shell/colortest`

to see if you got it to work. The last few lines should *not* be blue.

You may also need to go here: https://github.com/powerline/fonts for the fonts to make powerline work.
If you see a bunch of question marks on your powerline status bar on the bottom, that means you don't
have the proper fonts. You'll have to install those...somehow! On Windows, you can
download the file and click install fonts. Then in your terminal, change it to
that font. On Linux, you should follow their instructions.

For tmux ressurect, make sure you launch tmux and hit <prefix> shift I. This
will install the tmux plugin manager.

## YCM

You may run into issues about YCM demanding that you have a very new version of
VIM, or maybe it yelled at you about not having CMake installed. The
solution to this is to install Vim from source. If this is the case,
then you should take a look at the `setupvim.py` script.
You may need to replace the configuration with the proper
config directories, and you will need to add in Python3 support if you want
it. Then, you would run `python setupvim.py --vim-src`

Note that you may be missing Python headers. You'll have to install
them via `apt-get install python3-dev` or `apt-get install python-dev`.

All the dependencies you need are:

```
sudo apt install libncurses5-dev libgnome2-dev libgnomeui-dev \
libgtk2.0-dev libatk1.0-dev libbonoboui2-dev \
libcairo2-dev libx11-dev libxpm-dev libxt-dev python-dev \
python3-dev ruby-dev lua5.1 liblua5.1-dev libperl-dev git
```
