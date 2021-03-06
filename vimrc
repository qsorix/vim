set nocompatible
syntax on                 " syntax highlighing
filetype on               " try to detect filetypes
filetype plugin indent on " enable loading indent file for filetype
set backupcopy=yes        " helps npm builder notice file changes

" In GVIM
if has("gui_running")
    set guifont=DejaVu\ Sans\ Mono\ Book\ 13 " use this font
    "set lines=35                     "
    "set columns=130                  "
    set background=light              " adapt colors for background
    let g:lucius_style="light"
    colorscheme lucius
    set guioptions-=T
    set guioptions-=m
else
    set background=dark              " adapt colors for dark background
    "colorscheme lucius
    "set t_Co=256
endif

hi Normal ctermbg=None


" Don't create .swp files everywhere
set directory-=.

" Together with vim-rooter, this works nice to find files in the current
" directory, which I tend to keep at project's root.
set path=**
set suffixesadd+=.handlebars
set suffixesadd+=.coffee
set suffixesadd+=.py

" ==================================================
" Hack: Reset background
" ==================================================
autocmd VimLeave * set t_Co=

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
set diffopt+=iwhite
set noautochdir
"set spell

" default text encoding
set encoding=utf-8
set fileencoding=utf-8
set termencoding=utf-8

" tags
set tags=tags; " ';' searches for tags file in parent directories

" complete in vim commands with a nice list
set wildmode=longest,list
set wildignore+=*.pyc
set wildignore+=*.o,*.a,*.so,*.d,*.obj,.git

" custom keys
set pastetoggle=<F8>

" If we're running in vimdiff then tweak out settings a bit
if &diff
   set nospell
endif

autocmd FileType gitcommit setlocal spell!

autocmd BufNewFile,BufRead *.handlebars set filetype=handlebars

" ==================================================
" spell checking
" ==================================================
"set spell
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

" sane copy-pasting :)
imap <c-v> <c-o>"+P
vmap <c-c> "+y

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
"set ignorecase  " ignore case when searching
"set smartcase   " if searching and search contains upper case, make case sensitive search

map  <silent> <leader><C-i>      :set invhlsearch<CR>
imap <silent> <leader><C-i> <C-o>:set invhlsearch<CR>

" ==================================================
" JSON formatting
" ==================================================
menu FormatFile.JSON                :%!python -mjson.tool<CR>
menu Format.JSON                :'<,'>!python -mjson.tool<CR>
menu FormatFile.HTML                :%!tidy -i -xml -wrap 0 2>/dev/null<CR>
menu Format.HTML                :'<,'>!tidy -i -xml -wrap 0 2>/dev/null<CR>

map   <silent> <leader><C-f>?          :popup FormatFile<CR>
vmap  <silent> <leader><C-f>?     <ESC>:popup Format<CR>
map  <silent> <leader><C-f>j     :%!python -mjson.tool<CR>
vmap  <silent> <leader><C-f>j    :'<,'>!python -mjson.tool<CR>
imap <silent> <leader><C-f>j     <C-o>:'<,'>!python -mjson.tool<CR>

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
autocmd BufNewFile *Test.cpp  TSkeletonSetup cppTest.cpp


" ==================================================
" Project
" ==================================================
let g:proj_flags="istbcg"
let g:proj_window_width=35


" ==================================================
" CommandT
" ==================================================
let g:CommandTAcceptSelectionSplitMap = '<C-o>'
let g:CommandTMaxFiles=30000

" ==================================================
" Alternate
" ==================================================
let g:alternateExtensions_h = "C,cpp,cxx,cc,CC,c"
let g:alternateExtensions_C = "h,H,hpp"

" ==================================================
" Taglist
" ==================================================
let Tlist_Ctags_Cmd = "/usr/bin/ctags"
let Tlist_WinWidth = 50
let Tlist_Show_One_File=1
map <F4> :TlistToggle<cr>

" ==================================================
" Folding
" ==================================================
"autocmd FileType cpp set foldmethod=syntax
"set foldtext=getline(v:foldstart)
"set foldnestmax=4
"set foldcolumn=5
"set foldopen+=search
"set foldlevel=0

" ==================================================
" Clang Complete
" ==================================================
let g:clang_snippets = 1
"let g:clang_snippets_engine = 'ultisnips'

" ==================================================
" Clang Format
" ==================================================
" map <leader><C-f> :pyf /home/qsorix/bin/clang-format.py<CR>
" imap <leader><C-f> <ESC>:pyf /home/qsorix/bin/clang-format.py<CR>i

autocmd BufNewFile,BufRead *.cpp set syntax=cpp11
autocmd BufNewFile,BufRead *.cc set syntax=cpp11


" ==================================================
" 3-way diff helper
" ==================================================
" Disable one diff window during a three-way diff allowing you to cut out the
" noise of a three-way diff and focus on just the changes between two versions
" at a time. Inspired by Steve Losh's Splice
function! DiffToggle(window)
  " Save the cursor position and turn on diff for all windows
  let l:save_cursor = getpos('.')
  windo :diffthis
  " Turn off diff for the specified window (but keep scrollbind) and move
  " the cursor to the left-most diff window
  exe a:window . "wincmd w"
  diffoff
  set scrollbind
  set cursorbind
  exe a:window . "wincmd " . (a:window == 1 ? "l" : "h")
  " Update the diff and restore the cursor position
  diffupdate
  call setpos('.', l:save_cursor)
endfunction
" Toggle diff view on the left, center, or right windows
nmap <silent> <leader>dl :call DiffToggle(1)<cr>
nmap <silent> <leader>dc :call DiffToggle(2)<cr>
nmap <silent> <leader>dr :call DiffToggle(3)<cr>

" ==================================================
" Syntastic
" ==================================================
set statusline=%<%f\ 
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*
set statusline+=%h%m%r%=%-14.(%l,%c%V%)\ %P

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 2 " automatically close, but not open
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0

let g:syntastic_disabled_filetypes=['cpp']
let g:syntastic_python_checkers = ["flake8", "pyflakes", "python"]
let g:syntastic_javascript_checkers = ['eslint']
let g:syntastic_cpp_checkers = []

let g:syntastic_error_symbol = "✗"
let g:syntastic_warning_symbol = "⚠"

" ==================================================
" py.test
" ==================================================
map <leader><C-t> :Pytest project<CR>
imap <leader><C-t> <ESC>:Pytest project<CR>i

" ==================================================
" NERDTree
" ==================================================
map <f12> :NERDTreeToggle<CR>
let NERDTreeIgnore = ['\.pyc$']

" ==================================================
" Unite
" ==================================================
nnoremap <C-p> :Unite -start-insert file_rec/git<cr>
nnoremap <leader><C-g> :Unite -auto-preview grep:.<cr>
let g:unite_source_grep_command = 'git'
let g:unite_source_grep_default_opts = 'gr'
let g:unite_source_grep_recursive_opt = ''
let g:unite_source_tag_max_fname_length = 70

autocmd FileType unite call s:unite_my_settings()
function! s:unite_my_settings()"{{{
  imap <silent><buffer><expr> <C-CR>     unite#do_action('above')
  map <silent><buffer><expr> <C-CR>     unite#do_action('above')
endfunction"}}}

autocmd BufEnter *
  \   if empty(&buftype)
  \|      nnoremap <buffer> <C-]> :<C-u>UniteWithCursorWord -immediately tag<CR>
  \|      nnoremap <buffer> <C-w><C-]> :<C-u>UniteWithCursorWord -immediately -default-action=split tag<CR>
  \|  endif

" ==================================================
" JavaScript indenting
" ==================================================
let g:SimpleJsIndenter_BriefMode = 1
