"TSkeleton

autocmd BufNewFile *.h  TSkeletonSetup cpp.h

"NERDcomments
let NERDComInInsertMap="<F13>"

filetype plugin on
filetype indent on

set ruler
set number
set mouse=a

"setlocal spell spelllang=pl
"set spelllang=pl,en

" kolorki
"colorscheme elflord
"colorscheme oceanblack
syntax on

let g:load_doxygen_syntax=1
let html_use_css = 1

" encoding tekstu
set encoding=utf-8
set fileencoding=utf-8
set termencoding=utf-8

" inne opcje
set modeline
set foldmethod=manual
set foldcolumn=4
set scrolloff=4

set pastetoggle=<F8>

" zmiana pwd
autocmd BufEnter * lcd %:p:h

" edycja
set tabstop=8
set cino=:0l1b1g0t0(0W8
set nowrap
set autowrite
set autoindent
set nosmartindent
set showmatch

" 'szybki' esc
" map <C-Space> <ESC>

" przesuwanie wciec
vmap < <gv
vmap > >gv

" dopasowywanie nawiasow
set mps+=<:>
set showmatch
set matchtime=2

" praca z okienkami
set noequalalways
set winminheight=0
noremap <C-w><PageDown> <C-w><Down><C-w>_
noremap <C-w><PageUp> <C-w><Up><C-w>_

" przewijanie
au BufEnter * set scroll=1
au VimEnter * set scroll=1

" wyszukiwanie
set nohlsearch
map <silent> <C-h> :set invhlsearch<CR>
vmap <silent> <C-h> :<C-u>set invhlsearch<CR>gv
imap <silent> <C-h> <C-o>:set invhlsearch<CR>
set incsearch
set wrapscan

" Project
let g:proj_flags="istbcg"
let g:proj_window_width=35

" Man
runtime! ftplugin/man.vim

" indent
au Syntax c,cpp*,php set cindent
au Syntax java set cindent

" terminal
nmap <silent> <F9> :call system("gnome-terminal&")<CR>

" moj komentarz
au Syntax c,cpp*,php imap <C-_> <esc>:r!date "+\%d \%b \%Y, \%R"<cr>i/* QsoRiX: <end><cr>

autocmd FileType python set expandtab
autocmd FileType python set tabstop=4
autocmd FileType python set softtabstop=4
autocmd FileType python set shiftwidth=4
autocmd FileType python set smarttab
let python_highlight_space_errors = 1

