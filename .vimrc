set nocompatible              " be iMproved, required
filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

" let Vundle manage Vundle, required
Plugin 'gmarik/Vundle.vim'

" helpers
Plugin 'kien/ctrlp.vim'
Plugin 'tpope/vim-commentary'
Plugin 'vim-airline/vim-airline'
Plugin 'SirVer/ultisnips'

" language
Plugin 'tomlion/vim-solidity'

" color scheme
Plugin 'tomasiser/vim-code-dark'

" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required

set autoindent
set copyindent
set backspace=indent,eol,start
set cmdheight=2
set cursorline
set expandtab
set hidden
set hlsearch
set ignorecase
set incsearch
set laststatus=2
set list
set listchars=tab:>-,trail:-
set mouse=c
set ruler
set scrolloff=5
set tabstop=4
set shiftwidth=4
set showcmd
set showmatch
set smarttab
set t_Co=256
set virtualedit=block
set colorcolumn=80
set number
set viminfo='100,<1000,s20,h
set history=1000
set undolevels=1000
set nobackup
set noswapfile
set nowrap
set noerrorbells
set pastetoggle=<C-v>

syntax on

colo codedark

" :help last-position-jump
autocmd BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g`\"" | endif

" filetype
au Bufnewfile,bufRead *.pm,*.t,*.pl set filetype=perl

map <Leader>t :CtrlPBuffer<CR>
 let g:ctrlp_map = '<C-p>'
 let g:ctrlp_working_path_mode = 0 " don’t manage working directory.
 let g:ctrlp_use_caching = 1
 let g:ctrlp_custom_ignore = {
    \ 'dir':  '\v\c\.(git|svn)$|cgi/t/sandbox|cover_db',
    \ 'file': '\v\c\.(swf|bak|png|gif|js|mov|ico|jpg|pdf|jrxml)$'
    \ }
let g:ctrlp_prompt_mappings = {
    \ 'AcceptSelection("e")': ['<c-t>'],
    \ 'AcceptSelection("t")': ['<cr>', '<2-LeftMouse>'],
    \ }

let g:UltiSnipsSnippetsDir = "~/.vim/bundle/ultisnips/UltiSnips"
let g:UltiSnipsExpandTrigger="<tab>"

map <C-a> <esc>ggVG<CR>
map <C-e> <esc>:UltiSnipsEdit<CR>
map <C-c> :set number!<CR>
