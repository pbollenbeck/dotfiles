set nocompatible

execute pathogen#infect()
filetype plugin indent on

syntax on
set background=dark
let g:solarized_termcolors=256
colorscheme solarized

set autoindent
set complete=.,w,b,t
set cursorline
set encoding=utf-8
set expandtab
set hidden
set hlsearch
set ignorecase
set incsearch
set laststatus=2
set number
set shiftwidth=4
set showcmd
set showmatch
set showtabline=2
set smartcase
set softtabstop=4
set statusline=%f\ %m%r%y%=%3l,%2c
set tabstop=4
set wildmenu
set wildmode=list:longest

augroup vimrc
    autocmd!
    autocmd FileType ruby,haml,eruby,yaml,javascript,sass,cucumber 
        \ setlocal shiftwidth=2 |
        \ setlocal softtabstop=2 |
        \ setlocal tabstop=2
augroup end

map <left>  <nop>
map <right> <nop>
map <up>    <nop>
map <down>  <nop>

map <C-h> <C-w>h
map <C-j> <C-w>j
map <C-k> <C-w>k
map <C-l> <C-w>l

nmap <CR> :nohlsearch<CR>

let mapleader=","

" use tab for completion unless at beginning of line
" see: https://github.com/thoughtbot/dotfiles/blob/master/vimrc
function! InsertTabWrapper()
    let col = col('.') - 1
    if !col || getline('.')[col - 1] !~ '\k'
        return "\<tab>"
    else
        return "\<c-p>"
    endif
endfunction
inoremap <Tab> <c-r>=InsertTabWrapper()<cr>

