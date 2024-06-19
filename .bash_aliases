alias config='/usr/bin/git --git-dir=$HOME/.cfg/ --work-tree=$HOME'

# some more ls aliases
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'
alias cdef='cd ~/Desktop/Finances'

alias svim='gvim -v -u ~/.vimrcslow'
alias fvim='gvim -v -u ~/.vimrcfast'
alias vim='gvim -v -u ~/.vimrcfast'

alias gca='git add -A; git commit'

alias gpp='g++ -g -Wno-return-type -Wshadow -O0 -std=c++17 -D_GLIBCXX_DEBUG -fsanitize=undefined,address -ftrapv -DDEBUG -I .'
alias gdbq='gdb --quiet a.out'
