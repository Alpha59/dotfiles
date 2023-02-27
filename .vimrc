syntax enable
set wildmenu
set showmatch
set hlsearch
nnoremap <silent> <C-k> :set relativenumber!<CR> :set invnumber<CR><C-k>
nnoremap <silent> <leader>cf :call writefile([], expand("<cfile>"), "t")<cr>
nnoremap <silent> <C-l> :nohl<CR><C-l>
nnoremap <silent> <C-c> :%!awk '{print length}'<CR><C-c>
set ruler
set history=700
set noerrorbells
set novisualbell
colorscheme desert
set background=dark
set noswapfile
set nobackup
set nowb
set autoread
map j gj
map k gk
set ai
set si
set wrap
set nocompatible
set backspace=2
set backspace=indent,eol,start

let mapleader = ","
let g:mapleader = ","

set smartcase
set incsearch

filetype plugin indent on
set tabstop=36
set softtabstop=0
set expandtab
set shiftwidth=4
set smarttab

set binary
"set noeol

func! DeleteTrailingWS()
    exe "normal mz"
    %s/\s\+$//ge
    exe "normal `z"
endfunc

func! GDrivePython()
    set updatetime=400
    let g:auto_save = 1
    let g:auto_save_silent = 0
    let g:auto_save_events = ["CursorHoldI"]
    set autoread
endfunc

"autocmd BufWritePost * :! npm run lint && sleep 2 && refresh.scpt 0
" autocmd BufWritePost * :! sleep 2 && refresh.scpt 0
" autocmd BufWritePost * :! refresh.scpt 0
autocmd BufWrite * :call DeleteTrailingWS()
autocmd BufRead,BufNewFile *.vue setlocal filetype=vue.html.javascript.css " syntax highlighting for vue
":call GDrivePython()

let g:syntastic_shell = "/bin/bash"
let g:syntastic_debug = 0
set shell=/bin/bash

" Return to last edit position when opening files (You want this!)
autocmd BufReadPost *
     \ if line("'\"") > 0 && line("'\"") <= line("$") |
     \   exe "normal! g`\"" |
     \ endif
set suffixesadd+=.js
set suffixesadd+=.tsx
set path=$PWD/**" Remember info about open buffers on close
set viminfo^=%

let g:syntastic_enable_python_checker = 1
let g:syntastic_python_checkers = ['flake8']
let g:syntastic_python_checker_args='--config=.flake8'
let g:syntastic_java_checkers = ['checkstyle']
let g:syntastic_java_checkstyle_classpath="~/Downloads/checkstyle-8.18-all.jar"
let g:syntastic_java_checkstyle_conf_file="checkstyle-config.xml"
let g:syntastic_enable_html_checker = 0
let g:syntastic_disabled_filetypes=['html']
let g:syntastic_html_tidy_ignore_errors=["<i18n>", "is not recognized!"]
let g:syntastic_html_tidy_quiet_messages = { "level" : "warnings" }
let g:syntastic_enable_html_checker = 0
let g:syntastic_enable_html_tidy_checker = 0
let g:syntastic_typescript_checkers = ['eslint']
let g:syntastic_typescript_eslint_exe = 'npm run lint --'
let g:syntastic_enable_typescript_checker = 1
let g:syntastic_javascript_checkers = ['eslint']
let g:syntastic_javascript_eslint_exe = 'npm run eslint --'
" let g:syntastic_javascript_eslint_exec = 'eslint_d'
let g:syntastic_enable_javascript_checker = 1
let g:syntastic_mode_map = { 'mode': 'passive' }
highlight SyntasticError guibg=#2f0000

set statusline+=%#warningmsg#
" set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

let g:ale_linters = {'javascript': ['eslint'], 'python': ['flake8'], 'java': 'checkstyle', 'typescript': ['eslint']}
let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 1

let g:multi_cursor_select_all_word_key = '<C-m>'
set laststatus=2
set noshowmode

let g:lightline = {
      \ 'colorscheme': 'jellybeans',
      \ 'active': {
      \   'left': [ [ 'mode', 'paste' ],
      \             [ 'gitbranch', 'readonly', 'filename', 'modified' ] ]
      \ },
      \ 'component_function': {
      \   'gitbranch': 'fugitive#head'
      \ },
      \ }

autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif
autocmd BufWritePre * call mkdir(expand("<afile>:p:h"), "p")

autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 1 && isdirectory(argv()[0]) && !exists("s:std_in") | exe 'NERDTree' argv()[0] | wincmd p | ene | endif

map <C-t> :NERDTreeToggle<CR>
map <C-p> :TableModeToggle<CR>

com! FormatJSON .!python -c "import json, sys, collections; print json.dumps(json.load(sys.stdin, object_pairs_hook=collections.OrderedDict), indent=4)"

