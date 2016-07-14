set nocompatible

filetype off
set rtp+=~/.vim/bundle/vundle
call vundle#begin()

Plugin 'VundleVim/Vundle.vim'
Plugin 'altercation/vim-colors-solarized.git'
Plugin 'tpope/vim-rails.git'
Plugin 'vim-ruby/vim-ruby.git'
Plugin 'tpope/vim-endwise.git'
Plugin 'tpope/vim-bundler.git'
Plugin 'tpope/vim-commentary.git'
Plugin 'tpope/vim-surround.git'
Plugin 'godlygeek/tabular.git'
Plugin 'othree/html5.vim.git'
Plugin 'mileszs/ack.vim.git'
Plugin 'kien/ctrlp.vim.git'
Plugin 'heartsentwined/vim-emblem'
Plugin 'rust-lang/rust.vim'
Plugin 'elixir-lang/vim-elixir'
Plugin 'scrooloose/syntastic'
Plugin 'kchmck/vim-coffee-script'

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
set colorcolumn=79
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
    autocmd FileType ruby,haml,html,eruby,yaml,sass,scss,css,javascript,cucumber,coffee
        \ setlocal shiftwidth=2 |
        \ setlocal softtabstop=2 |
        \ setlocal tabstop=2
    autocmd FileType ruby,haml,html,eruby,yaml,sass,scss,css,javascript,cucumber,vim,cpp
        \ autocmd BufWritePre <buffer> :%s/\s\+$//e
    autocmd BufNewFile,BufRead *.json set ft=javascript
    autocmd BufNewFile,BufRead *.md set ft=text
    autocmd FileType gitcommit setlocal spell textwidth=72
augroup end

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


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" RUNNING TESTS
" taken from: https://github.com/garybernhardt/dotfiles/blob/master/.vimrc
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
map <leader>r :call RunTestFile()<cr>
" map <leader>T :call RunNearestTest()<cr>
map <leader>R :!rake<cr>
map <leader>c :w\|:!bundle exec bin/cucumber<cr>
map <leader>w :w\|:!bundle exec bin/cucumber --profile wip<cr>

function! RunTestFile(...)
    if a:0
        let command_suffix = a:1
    else
        let command_suffix = ""
    endif

    " Run the tests for the previously-marked file.
    let in_test_file = match(expand("%"), '\(.feature\|_spec.rb\)$') != -1
    if in_test_file
        call SetTestFile()
    elseif !exists("t:grb_test_file")
        return
    end
    call RunTests(t:grb_test_file . command_suffix)
endfunction

function! RunNearestTest()
    let spec_line_number = line('.')
    call RunTestFile(":" . spec_line_number . " -b")
endfunction

function! SetTestFile()
    " Set the spec file that tests will be run for.
    let t:grb_test_file=@%
endfunction

function! RunTests(filename)
    " Write the file and run tests for the given filename
    :w
    :silent !echo;echo;echo;echo;echo
    if match(a:filename, '\.feature$') != -1
        exec ":!bundle exec bin/cucumber -r features/ " . a:filename
    else
        if filereadable("Gemfile")
            exec ":!bundle exec rspec --color " . a:filename
        else
            exec ":!rspec --color " . a:filename
        end
    end
endfunction

" Edit global files
nmap <leader>gv :tabnew ~/.vimrc<cr>
nmap <leader>gt :tabnew ~/Dropbox/todo.txt<cr>

" Align cucumber tables
nmap <leader>a :Tabularize /\|<cr>

" Use ag in ack.vim
let g:ackprg = 'ag --nogroup --nocolor --column'

" CtrlP settings
let g:ctrlp_show_hidden=1

" Use The Silver Searcher https://github.com/ggreer/the_silver_searcher
if executable('ag')
  " Use Ag over Grep
  set grepprg=ag\ --nogroup\ --nocolor

  " Use ag in CtrlP for listing files. Lightning fast and respects .gitignore
  let g:ctrlp_user_command = 'ag %s -l --nocolor --hidden -g ""'

  " ag is fast enough that CtrlP doesn't need to cache
  let g:ctrlp_use_caching = 0
endif
