set nocompatible

execute pathogen#infect()
filetype plugin indent on

syntax on
set background=dark
let g:solarized_termcolors=256
colorscheme solarized

highlight NonText ctermfg=236
highlight SpecialKey ctermfg=236

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
set wildmenu
set wildmode=list:longest
set winwidth=79

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


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" RUNNING TESTS
" taken from: https://github.com/garybernhardt/dotfiles/blob/master/.vimrc
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
map <leader>r :call RunTestFile()<cr>
" map <leader>T :call RunNearestTest()<cr>
map <leader>R :!rake<cr>
map <leader>c :w\|:!script/cucumber<cr>
" map <leader>w :w\|:!script/features --profile wip<cr>

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
        exec ":!cucumber " . a:filename
    else
        if filereadable("script/test")
            exec ":!script/test " . a:filename
        elseif filereadable("Gemfile")
            exec ":!bundle exec rspec --color " . a:filename
        else
            exec ":!rspec --color " . a:filename
        end
    end
endfunction
