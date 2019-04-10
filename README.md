# dotfiles

Jonathan Xia's dotfiles. Setup instructions:

Add the following line to your .bashrc

`alias config='/usr/bin/git --git-dir=$HOME/.cfg/ --work-tree=$HOME'`

Now clone the repo into a bare repository:

`git clone --bare https://github.com/jonathanxia/dotfiles $HOME/.cfg`

and then you can now run (assuming your bashrc is successfully sourced),

`config checkout`

Note that this might overwrite some of your files, and git will complain if you are
about to do so. You can back them up if you care, delete if you don't.

Run

`./vimsetup.sh`

Getting this base16 thing to work requires you to have a 256 color terminal. You can probably configure
this in your terminal settings. You can run

`~/.config/base16-shell/colortest`

to see if you got it to work. The last few lines should *not* be blue.

You may also need to go here: https://github.com/powerline/fonts for the fonts to make powerline work.
If you see a bunch of question marks on your powerline status bar on the bottom, that means you don't
have the proper fonts. You'll have to install those...somehow!
