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
Plugin 'scrooloose/nerdtree'
Plugin 'easymotion/vim-easymotion'
Plugin 'sheerun/vim-polyglot'
Plugin 'chrisbra/csv.vim'

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
set wrap
set noerrorbells
set pastetoggle=<F2>
set path+=**
set wildmenu
set background=dark
set splitright
set splitbelow
set tags=./tags;
set magic
set undodir=~/.vim/undo//
set backupdir=~/.vim/backup//
set directory=~/.vim/swap//

syntax on

silent! colo codedark

" cursor
let &t_SI = "\<Esc>[4 q"
let &t_SR = "\<Esc>[4 q"
let &t_EI = "\<Esc>[4 q"

" highlight spell
hi SpellBad cterm=underline,bold ctermbg=none ctermfg=none
hi Cursor cterm=underline ctermbg=none ctermfg=none

" :help last-position-jump
autocmd BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g`\"" | endif
autocmd BufWritePre * %s/\s\+$//e

" file type
au Bufnewfile,bufRead *.pm,*.t,*.pl set filetype=perl
au Bufnewfile,bufRead *.rb,*.erb set filetype=ruby
au BufRead,BufWritePost *.csv :%ArrangeColumn
au BufWritePre *.csv :%UnArrangeColumn

autocmd BufNewFile * silent! 0r ~/.vim/templates/%:e.template
autocmd Filetype html setlocal ts=2 sts=2 sw=2
autocmd Filetype ruby setlocal ts=2 sts=2 sw=2

let b:csv_arrange_align = 'l*'
let b:csv_arrange_use_all_rows = 1

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

let g:NERDTreeQuitOnOpen = 1

highlight ExtraWhitespace ctermbg=red guibg=red
match ExtraWhitespace /\s\+$/

function! Run()
    let extension = expand('%:e')
    write
    if (&ft=="perl")
        if(extension=='t')
            :term prove -v %
        else
            :term perl %
        endif
    endif
endfunction

function! Debug()
    write
    :term perl -d %
endfunction

function! ToggleCopy()
    set number!
    :IndentLinesToggle
endfunction

function! SplitTerminal()
    ":vert term
    :term
    :res 10
endfunction

function! Critic()
    write
    :!perlcritic % && perl -c %
endfunction

function! Tidy()
    :%!perltidy -l=150 -st -ce -sct -sot -i=4 -pt=2 -sbt=2 -bbt=0 -nsfs -nolq -asc -wba=";" -cab=0 -nbbc -nolq -syn -isbc -ci=4
endfunction

function! FindTag()
    let co = matchstr(expand('<cword>'), '[a-zA-Z0-9._^\\]*$')
    if matchstr(expand('<cWORD>'), '[$@%]'.co)  == ''
        let tag_string = split(execute("tselect ".co), "\n")[1]
        let tag_file_name = matchstr(tag_string, '[a-zA-Z0-9._^\\]*$')
        if tag_file_name == expand('%:t')
            :exec("tag ".co)
        else
            :exec("tab tag ".co)
        endif
    else
        normal! gD
    endif
endfunction

nmap s <Plug>(easymotion-s)
nmap <Tab> :tabn<CR>
nmap <S-Tab> :tabp<CR>
noremap <C-a> <esc>ggVG<CR>
noremap <C-l> <esc>viw
noremap <C-]> :call FindTag()<CR>
noremap <F3> :call ToggleCopy()<CR>
noremap <F5> :call Run()<CR>
noremap <F6> :call Debug()<CR>
noremap <F7> :call Critic()<CR>
noremap <F8> :call Tidy()<CR>
noremap <F9> :NERDTreeToggle<CR>
noremap <F10> :TagbarToggle<CR>
noremap <F12> :call SplitTerminal()<CR>
