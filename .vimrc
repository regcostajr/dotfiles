set nocompatible
filetype off

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

" let Vundle manage Vundle, required
Plugin 'gmarik/Vundle.vim'

" highlight

" helpers
Plugin 'kien/ctrlp.vim'
Plugin 'tpope/vim-commentary'
Plugin 'vim-airline/vim-airline'
Plugin 'SirVer/ultisnips'
Plugin 'terryma/vim-multiple-cursors'
Plugin 'majutsushi/tagbar'
Plugin 'yggdroot/indentline'
Plugin 'jiangmiao/auto-pairs'
Plugin 'FooSoft/vim-argwrap'

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

silent! colo codedark

" highlight spell
hi SpellBad cterm=underline,bold ctermbg=none ctermfg=none
hi ColorColumn ctermbg=8

let &t_SI = "\<Esc>[4 q"
let &t_SR = "\<Esc>[4 q"
let &t_EI = "\<Esc>[4 q"
hi Cursor cterm=underline ctermbg=none ctermfg=none

" :help last-position-jump
autocmd BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g`\"" | endif

" file type
au Bufnewfile,bufRead *.pm,*.t,*.pl set filetype=perl
au Bufnewfile,bufRead *.rb,*.erb set filetype=ruby
au Bufnewfile,bufRead *.js,*.sol set filetype=javascript
autocmd BufNewFile * silent! 0r ~/.vim/templates/%:e.template

autocmd Filetype html setlocal ts=2 sts=2 sw=2
autocmd Filetype ruby setlocal ts=2 sts=2 sw=2

let g:ctrlp_working_path_mode = 0
let g:ctrlp_use_caching = 1
let g:ctrlp_custom_ignore = {
    \'dir': '\v\c\.(git|svn)$|cgi/t/sandbox|cover_db',
    \'file': '\v\c\.(swf|bak|png|gif|js|mov|ico|jpg|pdf|jrxml)$'
\}
let g:ctrlp_prompt_mappings = {
    \'AcceptSelection("e")': ['<c-t>'],
    \'AcceptSelection("t")': ['<cr>', '<2-LeftMouse>']
\}

let g:UltiSnipsSnippetsDir = "~/.vim/snips/"
let g:UltiSnipsSnippetDirectories=["snips"]
let g:UltiSnipsExpandTrigger = "<tab>"
let g:UltiSnipsJumpForwardTrigger = "<tab>"
let g:UltiSnipsJumpBackwardTrigger = "<s-tab>"

let g:move_key_modifier = 'C'

let g:perltidy_path = "/home/" . $USER . "/.vim/.perltidyrc"
let g:perlcritic_path = "/home/" . $USER . "/.vim/.perlcriticrc"

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

function! Tidy()
    write
    silent execute ':!perltidy -pro=' . g:perltidy_path . ' --backup-and-modify-in-place -bext=tidyup %'
endfunction

function! Critic()
    write
    call Tidy()
    execute ':!perlcritic -p=' . g:perlcritic_path . '  % && perl -c %'
endfunction

nnoremap <silent> <tab> :ArgWrap<CR>
noremap <C-a> <esc>ggVG<CR>
noremap <F3> :set number!<CR>
noremap <F5> :call Run()<CR>
command -range=% -nargs=* Debug !perl -d %
noremap <F6> :Debug<CR>
noremap <F7> :call Critic()<CR>
noremap <F8> :call Tidy()<CR>
noremap <F10> :TagbarToggle<CR>
