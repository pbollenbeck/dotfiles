set nocompatible

filetype off
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

Plugin 'VundleVim/Vundle.vim'
Plugin 'altercation/vim-colors-solarized.git'
Plugin 'vim-ruby/vim-ruby.git'
Plugin 'tpope/vim-endwise.git'
Plugin 'tpope/vim-commentary.git'
Plugin 'tpope/vim-surround.git'
Plugin 'godlygeek/tabular.git'
Plugin 'othree/html5.vim.git'
Plugin 'mileszs/ack.vim.git'
Plugin 'kien/ctrlp.vim.git'
Plugin 'elixir-lang/vim-elixir'
Plugin 'scrooloose/syntastic'
Plugin 'reedes/vim-pencil'
Plugin 'tpope/vim-markdown'
Plugin 'junegunn/goyo.vim'
Plugin 'junegunn/limelight.vim'
Plugin 'dpelle/vim-LanguageTool'
Plugin 'majutsushi/tagbar'

call vundle#end()
filetype plugin indent on

syntax on
set background=dark
let g:solarized_termcolors=256
colorscheme solarized

highlight NonText ctermfg=236
highlight SpecialKey ctermfg=236

autocmd InsertEnter * match ExtraWhitespace /\s\+\%#\@<!$/
autocmd BufRead,InsertLeave * match ExtraWhitespace /\s\+$/

highlight ExtraWhitespace ctermbg=red guibg=red
highlight ExtraLines ctermbg=red guibg=red
autocmd ColorScheme * highlight ExtraWhitespace ctermbg=red guibg=red

set autoindent
set backspace=indent,eol,start
set colorcolumn=80
set complete=.,w,b,t
set cursorline
set dir=~/tmp,/var/tmp,.
set encoding=utf-8
set expandtab
set hidden
set hlsearch
set ignorecase
set incsearch
set laststatus=2
set list
set listchars=tab:▸\ ,eol:¬
set number
set shiftwidth=4
set showcmd
set showmatch
set showtabline=2
set smartcase
set softtabstop=4
set statusline=%f\ %m%r%y%=%3l,%2c
set tabstop=4
set undofile
set undodir=$HOME/.vimundo/
set wildmenu
set wildmode=list:longest
set winwidth=79

augroup vimrc
    autocmd!
    autocmd BufNewFile,BufRead *.json      set ft=javascript
    autocmd BufNewFile,BufRead *.md        set ft=markdown
    autocmd BufNewFile,BufRead Jenkinsfile set ft=groovy
    autocmd FileType ruby,haml,html,eruby,yaml,sass,scss,css,javascript,cucumber,coffee,groovy
        \ setlocal shiftwidth=2 |
        \ setlocal softtabstop=2 |
        \ setlocal tabstop=2
    autocmd FileType ruby,haml,html,eruby,yaml,sass,scss,css,javascript,cucumber,vim,cpp,groovy
        \ autocmd BufWritePre <buffer> :%s/\s\+$//e
    autocmd FileType vim
        \ autocmd BufWrite :so %
    autocmd FileType markdown
        \ call pencil#init() |
        \ setlocal spell textwidth=80
    autocmd FileType gitcommit setlocal spell textwidth=72
    autocmd User GoyoEnter Limelight
    autocmd User GoyoLeave Limelight!
augroup end

let g:vim_markdown_frontmatter = 1
let g:pencil#map#suspend_af = 'K'   " default is no mapping

" Syntastics settings
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*
" let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0
let g:syntastic_ruby_checkers = ['mri']

map <left>  <nop>
map <right> <nop>
map <up>    <nop>
map <down>  <nop>

map <C-h> <C-w>h
map <C-j> <C-w>j
map <C-k> <C-w>k
map <C-l> <C-w>l

nmap <CR> :nohlsearch<CR>

imap öö <Esc>
imap öÖ <Esc>

let mapleader=" "
let maplocalleader=" "

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

" Edit global files
nmap <leader>gv :tabnew ~/.vimrc<cr>
nmap <leader>gt :tabnew ~/Dropbox/todo.txt<cr>

" CtrlP settings
let g:ctrlp_show_hidden=1
nmap <leader>f :CtrlP<cr>
nmap <leader>t :CtrlPTag<cr>

if executable('ag')
    set grepprg=ag\ --nogroup\ --nocolor
    let g:ackprg = 'ag --nogroup --nocolor --column'
    let g:ctrlp_user_command = 'ag %s -l --nocolor --hidden -g ""'
    let g:ctrlp_use_caching = 0
endif

" CTags
nmap <leader>ct :!ctags -R .<cr>

" Tagbar
nmap <leader>b :TagbarToggle<cr>
