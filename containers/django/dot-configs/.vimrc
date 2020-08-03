set fenc=utf-8
set autoindent
set smartindent
set showmatch matchtime=1
set mouse=a
color desert

set tabstop=2
set list listchars=tab:\▸\-
set shiftwidth=2
set expandtab
set title
set number
set hlsearch
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif

