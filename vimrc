set nocompatible
syntax on                 " syntax highlighing
filetype on               " try to detect filetypes
filetype plugin indent on " enable loading indent file for filetype

" In GVIM
if has("gui_running")
    set guifont=Liberation\ Mono\ 12 " use this font
    "set lines=35                     "
    "set columns=130                  "
    set background=dark              " adapt colors for background
    colorscheme lucius
    set guioptions-=T          " don't show icons in gui
else
    set background=dark              " adapt colors for dark background
    colorscheme lucius
    set t_Co=256
endif

" ==================================================
" Basic Settings
" ==================================================
let mapleader=","          " change the leader to be a comma vs slash
set textwidth=80           " Try this out to see how textwidth helps
set cmdheight=3            " Make command line bigger
set laststatus=2           " always show status line
set scrolloff=4            " keep 3 lines when scrolling
set nocursorline           " have a line indicate the cursor location
set autoindent             " always set autoindenting on
set noshowcmd              " don't display incomplete commands
set ruler                  " show the cursor position all the time
set nobackup               " do not keep a backup file
set modeline               " last lines in document sets Vim mode
set modelines=3            " number lines checked for modelines
set shortmess=atI          " Abbreviate messages
set nostartofline          " don't jump to first character when paging
set backspace=start,indent,eol " backspace over everything
set matchpairs+=<:>        " show matching <> (html mainly) as well
set showmatch
set matchtime=3
set mouse=a
set nowrap
set autowrite

" default text encoding
set encoding=utf-8
set fileencoding=utf-8
set termencoding=utf-8

" tags
set tags=tags; " ';' searches for tags file in parent directories

" complete in vim commands with a nice list
set wildmenu
set wildmode=longest,list
set wildignore+=*.pyc

" custom keys
set pastetoggle=<F8>

" If we're running in vimdiff then tweak out settings a bit
if &diff
   set nospell
endif

" ==================================================
" spell checking
" ==================================================
set spell
set spelllang=pl,en
" shortcut to toggle spelling
nmap <leader>s :setlocal spell! <CR>

" setup a custom dict for spelling
" zg = add word to dict
" zw = mark word as not spelled correctly (remove)
set spellfile=~/.vim/dict.add

" ==================================================
" Basic Maps
" ==================================================
"
" Maps for jj to act as Esc
inoremap ,, <esc>
vnoremap ,, <esc>
cnoremap ,, <c-c>

" map ctrl-c to something else so I quit using it
map <c-c> <Nop>
imap <c-c> <Nop>

" start new commands without shift
nnoremap ; :

" shift block
vmap < <gv
vmap > >gv

nmap <leader>nu :set number!<cr>

" terminal
nmap <silent> <F9> :call system("gnome-terminal&")<CR>

let g:load_doxygen_syntax=1


" ==================================================
" Windows / Splits
" ==================================================
" ctrl-jklm changes to that split
map <c-j> <c-w>j
map <c-k> <c-w>k
map <c-l> <c-w>l
map <c-h> <c-w>h

" use - and + to resize horizontal splits
map - 3<C-W>-
map + 3<C-W>+
" and for vsplits with alt-< or alt->
map <M-,> 3<C-W><
map <M-.> 3<C-W>>

set noequalalways
set winminheight=0
noremap <C-w><PageDown> <C-w><Down><C-w>_
noremap <C-w><PageUp> <C-w><Up><C-w>_


" ==================================================
" Search
" ==================================================
set nohlsearch  " don't highlight searches by default
set incsearch   " do incremental searching
set wrapscan
set ignorecase  " ignore case when searching
set smartcase   " if searching and search contains upper case, make case sensitive search

map  <silent> <C-h>      :set invhlsearch<CR>
imap <silent> <C-h> <C-o>:set invhlsearch<CR>


" ==================================================
" initialize Pathogen
" ==================================================
call pathogen#infect()

" ==================================================
" Clean all end of line extra whitespace with ,S
" Credit: voyeg3r https://github.com/mitechie/pyvim/issues/#issue/1
" ==================================================
fun! CleanExtraSpaces()
    let save_cursor = getpos(".")
    let old_query = getreg('/')
    :%s/\s\+$//e
    call setpos('.', save_cursor)
    call setreg('/', old_query)
endfun
map <silent><leader>S <esc>:keepjumps call CleanExtraSpaces()<cr>


" ==================================================
" Skeletons
" ==================================================
autocmd BufNewFile *.h  TSkeletonSetup cpp.h


" ==================================================
" Project
" ==================================================
let g:proj_flags="istbcg"
let g:proj_window_width=35


" ==================================================
" CommandT
" ==================================================
let g:CommandTAcceptSelectionSplitMap = '<C-o>'
