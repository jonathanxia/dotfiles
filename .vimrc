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
Plugin 'scrooloose/nerdcommenter'
Plugin 'scrooloose/nerdtree'
Plugin 'jistr/vim-nerdtree-tabs'
Plugin 'vim-airline/vim-airline'
Plugin 'vim-airline/vim-airline-themes'
Plugin 'ctrlpvim/ctrlp.vim'
Plugin 'xolox/vim-easytags'
Plugin 'xolox/vim-misc'
Plugin 'craigemery/vim-autotag'
Plugin 'majutsushi/tagbar'
Plugin 'ledger/vim-ledger'
Plugin 'chriskempson/base16-vim.git'
Plugin 'Valloric/YouCompleteMe'
Plugin 'https://gitlab.com/Dica-Developer/vim-jdb.git'
Plugin 'junegunn/vim-easy-align'
Plugin 'Vimjas/vim-python-pep8-indent'
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

set backspace=2

set tags=tags; "This way we get the tags file recursively

set splitbelow "This way the preview window will appear below
set previewheight=10 "The preview height will be 4 when we open a preview window

"highlights the 79th column
set colorcolumn=79
highlight ColorColumn ctermbg=18

"set numbering on the side
set number
set relativenumber

"This allows vim to search for included header files
let &path.="src/include,/usr/include/,"
set includeexpr=substitute(v:fname,'\\.','/','g')

"Always display the status line
set laststatus=2

execute pathogen#infect()

let g:airline_section_y='BN: %{bufnr("%")}' "The buffer number in status bar
let g:airline_powerline_fonts=1 "enables powerline fonts to make it look nicer
if !exists('g:airline_symbols')
    let g:airline_symbols = {}
endif
let g:airline_symbols.dirty='!'
let g:airline_theme='dark'

"make easy tags run asynchronously
let g:easytags_async=1
let g:easytags_dynamic_files=1

map <C-n> :NERDTreeTabsToggle<CR>
nmap <F8> :TagbarToggle<CR>
nmap <F7> :res +2<CR>
nmap <F6> :res -2<CR>
map <C-\> :tab split<CR>:exec("tag ".expand("<cword>"))<CR>
nmap <F9> :Gstatus<CR>
nmap <F10> :Gcommit%<CR>

set completeopt-=preview "Not have preview window jump out every time

if filereadable(expand("~/.vimrc_background"))
  let base16colorspace=256
  source ~/.vimrc_background
endif

au BufNewFile,BufRead *.ldg,*.ledger setf ledger | comp ledger
au FileType ledger nmap <buffer> <F11> :LedgerAlign<CR>
au FileType ledger vmap <buffer> <F11> :LedgerAlign<CR>
au FileType ledger nmap <buffer> <F12> :call ledger#entry()<CR>

au FileType tex map <buffer> <C-l> :w<CR> :!pdflatex %<CR><CR>
au FileType tex imap <buffer> <C-l> <ESC> :w<CR> :!latexmk -pdf<CR><CR>


let g:ycm_global_ycm_extra_conf='~/.ycm_extra_conf.py'
let g:ycm_confirm_extra_conf=0
"Disable YCM for ledger files
let g:ycm_filetype_blacklist = {'ledger': 1}

highlight SpellCap ctermbg=DarkRed ctermfg=White
highlight SpellBad ctermbg=DarkRed ctermfg=White

nnoremap <leader>jd :YcmComplete GoTo<CR>
nnoremap <leader>jr :YcmComplete GoToReferences<CR>
nnoremap <leader>gd :YcmComplete GetDoc<CR>
nnoremap <leader>gt :YcmComplete GetType<CR>
nnoremap <leader>gp :YcmComplete GetParent<CR>

set nohlsearch

let g:ycm_show_diagnostics_ui = 0

" Start interactive EasyAlign in visual mode (e.g. vipga)
xmap ga <Plug>(EasyAlign)

" Start interactive EasyAlign for a motion/text object (e.g. gaip)
nmap ga <Plug>(EasyAlign)
