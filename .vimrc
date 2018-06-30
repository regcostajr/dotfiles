set nocompatible
filetype off

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
Plugin 'terryma/vim-multiple-cursors'

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
set spell spelllang=en_us
set cmdheight=2
set cursorline
set expandtab
set hidden
set hlsearch
set ignorecase
set incsearch
set laststatus=2
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
set pastetoggle=<F2>
set path+=**
set wildmenu

syntax on

colo codedark

" file type
au Bufnewfile,bufRead *.pm,*.t,*.pl set filetype=perl
autocmd BufNewFile * silent! 0r ~/.vim/templates/%:e.template

let g:ctrlp_working_path_mode = 0
let g:ctrlp_use_caching = 1
let g:ctrlp_custom_ignore = { 'dir':  '\v\c\.(git|svn)$|cgi/t/sandbox|cover_db', 'file': '\v\c\.(swf|bak|png|gif|js|mov|ico|jpg|pdf|jrxml)$' }
let g:ctrlp_prompt_mappings = { 'AcceptSelection("e")': ['<c-t>'], 'AcceptSelection("t")': ['<cr>', '<2-LeftMouse>'] }

let g:UltiSnipsSnippetsDir = "~/.vim/snips/"
let g:UltiSnipsExpandTrigger = "<tab>"

function! Run()
    let extension = expand('%:e')
    write
    if (&ft=="perl")
        if(extension=='t')
            :!prove -v %
        else
            :!perl %
        endif
    endif
endfunction

noremap <F3> :set number!<CR>
noremap <F5> :call Run()<CR>
command -range=% -nargs=* Debug !perl -d %
noremap <F6> :Debug<CR>
command -range=% -nargs=* Tidy <line1>,<line2>!perltidy -q
noremap <F8> :Tidy<CR>
command -range=% -nargs=* Critic !perlcritic %
noremap <F7> :Critic<CR>
