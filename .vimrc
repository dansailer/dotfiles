"	          ██
"	         ░░
"	 ██    ██ ██ ██████████  ██████  █████
"	░██   ░██░██░░██░░██░░██░░██░░█ ██░░░██
"	░░██ ░██ ░██ ░██ ░██ ░██ ░██ ░ ░██  ░░
"	 ░░████  ░██ ░██ ░██ ░██ ░██   ░██   ██
"	  ░░██   ░██ ███ ░██ ░██░███   ░░█████
"	   ░░    ░░ ░░░  ░░  ░░ ░░░     ░░░░░

" ==============================
"	Init
" ==============================
"
set nocompatible
set noshowmode
syntax on

" ==============================
" Plugins
" ==============================
"
call plug#begin('~/.dotfiles/.vim/plugged')

Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'nathanaelkane/vim-indent-guides'
Plug 'tpope/vim-sensible'
Plug 'ap/vim-css-color'
Plug 'scrooloose/nerdcommenter'
" Plug 'fatih/vim-go'
" Plug 'majutsushi/tagbar'
" Plug 'bronson/vim-trailing-whitespace'
" Plug 'junegunn/goyo.vim'
"fatih/vim-go
""nsf/gocode


call plug#end()

"
" ==============================
"	Interface Settings
" ==============================
"
set number " Display line numbers on the left
"set colorcolumn=81,121 " Set a column at 81 chars wide
set encoding=utf-8 nobomb
set noerrorbells " Disable error bells
set guifont=Inconsolata\ for\ Powerline
set confirm " confim instead of error when leaving unsaved file
"set mouse=a " Enable use of the mouse for all modes
set lcs=tab:▸\ ,trail:·,eol:¬,nbsp:_ " Show “invisible” characters
set list
set cursorline " Highlight current line
set tabstop=4 " Make tabs as wide as four spaces

"
" ==============================
"	Color Scheme
" ==============================
"
syntax enable
set background=dark
syntax on " Enable syntax highlighting


"
" ==============================
"	Search
" ==============================
"
set hlsearch " highlight all results of a search
set incsearch " highlight first result of search whilst typing
set ignorecase " Use case insensitive search
set smartcase  "except when using capital letters
if executable('ag')
  " Use Ag over Grep
  set grepprg=ag\ --nogroup\ --nocolor

  " Use ag in CtrlP for listing files. Lightning fast and respects .gitignore
  let g:ctrlp_user_command = 'ag %s -l --nocolor -g ""'

  " ag is fast enough that CtrlP doesn't need to cache
  let g:ctrlp_use_caching = 0
endif

"
" ==============================
"	Airline Settings
" ==============================
"
let g:airline#extensions#tabline#enabled = 1
let g:airline_powerline_fonts = 1
let g:airline_theme='luna'
let g:Powerline_symbols = 'fancy'


"  nathanaelkane/vim-indent-guides
let g:indent_guides_enable_on_vim_startup = 1

filetype plugin on


"
" ==============================
"	Misc Settings
" ==============================
"
set noswapfile " eff swp files
set nobackup
set nowritebackup
set lazyredraw
set binary
set noeol
set expandtab

" Uncomment the following to have Vim jump to the last position when reopening a file
if has("autocmd")
  au BufReadPost * if line("'\"") > 0 && line("'\"") <= line("$") | exe "normal! g`\"" | endif
endif


"let g:go_fmt_command = "goimports"


"
" ==============================
"	Keybindings and Mappings
" ==============================
"
let mapleader = "-<Space>"
let g:mapleader = "-<Space>"

noremap <leader>W :w !sudo tee % > /dev/null<CR> " Save a file as root (,W)

nmap <leader>q :q!<cr>
nmap <leader>w :w!<cr>
nmap <leader>s :w!<cr>
nmap <leader>/ <leader>c<space><cr>
nmap <leader>g :Gstatus<cr>
nmap <leader>t :TagbarToggle<cr>

nnoremap <silent> ]c /\v^(\<\|\=\|\>){7}([^=].+)?$<CR>
nnoremap <silent> [c ?\v^(\<\|\=\|\>){7}([^=].+)\?$<CR>
nnoremap ; :

inoremap jk <esc> " jk is escape

nnoremap <F2> :set invpaste paste?<CR>
set pastetoggle=<F2>

nnoremap <F3> :set invnumber <bar> set list!<CR>

command Wq wq
command Q q
command W w

let g:UltiSnipsExpandTrigger="<tab-x>"
let g:UltiSnipsJumpForwardTrigger="<c-b>"
let g:UltiSnipsJumpBackwardTrigger="<c-z>"

nmap q :nohlsearch<CR>
