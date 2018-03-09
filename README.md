# dotfiles

Jonathan Xia's dotfiles. Setup instructions:

Add the following line to your .bashrc

`alias config='/usr/bin/git --git-dir=$HOME/.cfg/ --work-tree=$HOME'`

Run the following command:

`echo ".cfg" >> .gitignore`

Now clone the repo into a bare repository:

`git clone --bare https://github.com/jonathanxia/dotfiles $HOME/.cfg`

and then you can now run (assuming your bashrc is successfully sourced),

`config checkout`

Note that this might overwrite some of your files, and git will complain if you are
about to do so. You can back them up if you care, delete if you don't.

Run this command to not show untracked files:

`config config --local status.showUntrackedFiles no`

There should be a shell script that will be used to clone all the repositories for the
vim plugins. Run

`./vimsetup.sh`

If you already have the repository, then it'll complain but that's fine since you already
have it. Also, this assumes you have pathogen working, which you should go and get. I'll
maybe add in pathogen to automate that too...

Get pathogen here: https://github.com/tpope/vim-pathogen
