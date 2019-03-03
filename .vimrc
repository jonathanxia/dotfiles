set nocompatible
filetype off
syntax on

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim

call vundle#begin()
" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')

" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'
Plugin 'tpope/vim-fugitive'
Plugin 'davidhalter/jedi-vim'
Plugin 'scrooloose/nerdcommenter'
Bundle 'jistr/vim-nerdtree-tabs'
Plugin 'vim-airline/vim-airline-themes'
" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required
" To ignore plugin indent changes, instead use:
"filetype plugin on
"
" Put your non-Plugin stuff after this line

set exrc
set secure

"indentation rules
set tabstop=4
set softtabstop=4
set shiftwidth=4
set expandtab

set tags=tags; "This way we get the tags file recursively

set splitbelow "This way the preview window will appear below
set previewheight=10 "The preview height will be 4 when we open a preview window

"highlights the 72nd column
set colorcolumn=72
highlight ColorColumn ctermbg=darkgrey

"set numbering on the side
set number

"This allows vim to search for included header files
let &path.="src/include,/usr/include/AL,"
set includeexpr=substitute(v:fname,'\\.','/','g')

"Always display the status line
set laststatus=2

execute pathogen#infect()

let g:airline_section_y='BN: %{bufnr("%")}' "The buffer number in status bar
let g:airline_powerline_fonts=1 "enables powerline fonts to make it look nicer
let g:airline_theme='dark'

map <C-n> :NERDTreeTabsToggle<CR>
map <C-l> :w<CR> :!latexmk -pdf<CR><CR>
imap <C-l> <ESC> :w<CR> :!latexmk -pdf<CR><CR>
nmap <F8> :TagbarToggle<CR>
nmap <F7> :res +2<CR>
nmap <F6> :res -2<CR>
map <C-\> :tab split<CR>:exec("tag ".expand("<cword>"))<CR>
nmap <F9> :Gstatus<CR>
nmap <F10> :Gcommit%<CR>

set completeopt-=preview "Not have preview window jump out every time
let base16colorspace=256
colorscheme base16-google-dark


au BufNewFile,BufRead *.ldg,*.ledger setf ledger | comp ledger
nmap <F11> :LedgerAlign<CR>
vmap <F11> :LedgerAlign<CR>
