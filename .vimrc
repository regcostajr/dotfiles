set nocompatible              " be iMproved, required
filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

" let Vundle manage Vundle, required
Plugin 'gmarik/Vundle.vim'

Plugin 'scrooloose/nerdtree'
Plugin 'vim-airline/vim-airline'
Plugin 'kien/ctrlp.vim'
Plugin 'majutsushi/tagbar'
Plugin 'tomasiser/vim-code-dark'
Plugin 'Nopik/vim-nerdtree-direnter'

Plugin 'vim-perl/vim-perl'
Plugin 'tomlion/vim-solidity'
Plugin 'fatih/vim-go'

" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required

set autoindent
set backspace=indent,eol,start
set cindent " set smartindent
set cmdheight=2
set cursorcolumn
set cursorline
set errorformat=\"../../%f\"\\,%*[^0-9]%l:\ %m
set expandtab
set hidden
set hlsearch
set ignorecase
set incsearch
set laststatus=2
set list
set listchars=tab:>-,trail:-
set mouse=c
set nowrap
set ruler
set scrolloff=5
set shiftwidth=4
set showcmd
set showmatch
set smarttab
set t_Co=256
set tags=tags
set virtualedit=block
set wrap
set colorcolumn=80
set number
set viminfo='100,<100,s20,h

syntax on

colo codedark

" :help last-position-jump
autocmd BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g`\"" | endif

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

let g:NERDTreeMapOpenInTab='<ENTER>'
let g:NERDTreeQuitOnOpen = 1

map <C-n> :NERDTreeToggle<CR>
nmap <C-m> :TagbarToggle<CR>

