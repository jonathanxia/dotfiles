#!/bin/bash

/usr/bin/git --git-dir=$HOME/.cfg/ --work-tree=$HOME config --local status.showUntrackedFiles no

# Add pathogen (rtp manager, necessary)
mkdir -p ~/.vim/autoload ~/.vim/bundle && \
    curl -LSso ~/.vim/autoload/pathogen.vim https://tpo.pe/pathogen.vim

# Adding Vundle (an rtp manager, also necessary)
git clone https://github.com/VundleVim/Vundle.vim ~/.vim/bundle/Vundle.vim

# Install ctags
# Comment this line out if you already have ctags
echo "Make sure you have exuberant-ctags installed on your machine!"
# sudo apt-get install exuberant-ctags

# Base 16 shells to get the google dark color scheme.
git clone https://github.com/chriskempson/base16-shell.git ~/.config/base16-shell
echo "# Base16 Shell" >> ~/.bashrc
echo "BASE16_SHELL=\"\$HOME/.config/base16-shell/\"" >> ~/.bashrc
echo "[ -n \"\$PS1\" ] && [ -s \"\$BASE16_SHELL/profile_helper.sh\" ] && eval \"\$(\"\$BASE16_SHELL/profile_helper.sh\")\"" >> ~/.bashrc

vim +PluginInstall +qall

echo "check to see you have cmake installed and vim has python enabled"
cd ~/.vim/bundle/YouCompleteMe
./install.py --clang-completer --java-completer

echo "Running color test"
cd ~/.config/base16-shell
./colortest
echo "Last few lines should not be blue!"
cd ~

git config --global alias.lg "log --graph --pretty=format:'%C(yellow)%d%Creset %C(cyan)%h%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset' --abbrev-commit --date=short --all"
