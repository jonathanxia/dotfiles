alias cd70='cd ~/Desktop/school/cs70/Berkeley-CS70'
alias ledg="distro_ledger.py jonathan.ldg > tmp.ldg; ledger -f tmp.ldg"
alias config='/usr/bin/git --git-dir=$HOME/.cfg/ --work-tree=$HOME'

# some more ls aliases
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'
alias cdee='cd ~/Desktop/school'
alias cdef='cd ~/Desktop/Finances'

alias svim='gvim -v -u ~/.vimrcslow'
alias fvim='gvim -v -u ~/.vimrcfast'
alias vim='gvim -v -u ~/.vimrcfast'

alias gopen='gdec Data.zip; unzip Data.zip'
alias gclose='srm -rvz Data Data.zip'

alias gca='git add -A; git commit'

alias gpp='g++ -g -Wno-return-type -Wshadow -O0 -std=c++17 -D_GLIBCXX_DEBUG -fsanitize=undefined,address -ftrapv -DDEBUG'
alias gdbq='gdb --quiet a.out'
