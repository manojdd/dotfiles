if ! filereadable(expand('~/.vim/autoload/plug.vim'))
	echo "Downloading junegunn/vim-plug to manage plugins..."
	silent !mkdir -p ~/.config/nvim/autoload/
	silent !curl "https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim" > ~/.config/nvim/autoload/plug.vim
	autocmd VimEnter * PlugInstall
endif

call plug#begin('~/.vim/plugged')
  Plug 'tpope/vim-surround'
  Plug 'scrooloose/nerdtree'
  Plug 'jreybert/vimagit'
  Plug 'bling/vim-airline'
  Plug 'tpope/vim-commentary'
  Plug 'ycm-core/YouCompleteMe'
call plug#end()

" Set encoding to utf-8. Some plugins complain if this is absent
set encoding=utf-8
set t_Co=256
set background=dark
":hi normal ctermbg=234 ctermfg=166

"Needed from nord colorscheme. See https://github.com/vim/vim/issues/993#issuecomment-255651605
let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"

if (has("termguicolors"))
    set termguicolors
endif
:colorscheme nord

" Set colors for search terms' highlighting
":hi Search cterm=NONE ctermfg=black ctermbg=red

" Don't try to act like old vim
set nocompatible

" Enable syntax and plugins (for netrw)
syntax on
filetype indent plugin on

" When opening a new line and no filetype-specific indenting is enabled, keep
" the same indent as the line you're currently on. Useful for READMEs, etc.
set autoindent

"fg 30 123 130 131 134 136 141 142 148 161 161 166 189 252 255

" Search down into subdirectories
" Provides tab completion for all file related tasks
set path+=**

" Display matching files on tab complete
set wildmenu

set number
set relativenumber

" These are highly recommended options.
 
" Vim with default settings does not allow easy switching between multiple files
" in the same editor window. Users can use multiple split windows or multiple
" tab pages to edit multiple files, but it is still best to enable an option to
" allow easier switching between files.
"
" One such option is the 'hidden' option, which allows you to re-use the same
" window and switch from an unsaved buffer without saving it first. Also allows
" you to keep an undo history for multiple files when re-using the same window
" in this way. Note that using persistent undo also lets you undo in multiple
" files even in the same window, but is less efficient and is actually designed
" for keeping undo history after closing Vim entirely. Vim will complain if you
" try to quit without saving, and swap files will keep you safe if your computer
" crashes.
set hidden

" Show partial commands in the last line of the screen
set showcmd
" Split below and to the right instead of default above and left
set splitbelow splitright

set tabstop=2 softtabstop=0 expandtab shiftwidth=2 smarttab

set incsearch   " search as characters are entered
set hlsearch    " highlight matches
" Use case insensitive search, except when using capital letters
set ignorecase
set smartcase

let mapleader=" "

" Open file tree to left by pressing Leader - f
"noremap <Leader>f :topleft 30 vs .<CR>
noremap <Leader>f :25Lexplore .<CR>
"let g:netrw_winsize = 25

"This unsets the "last search pattern" register by hitting return
" See https://stackoverflow.com/a/658478
nnoremap <CR> :noh<CR><CR>
" Map Y to act like D and C, i.e. to yank until EOL, rather than act as yy,
" which is the default
map Y y$
" Shortcutting split navigation, saving a keypress:
map <Left> <C-w>h
map <Down> <C-w>j
map <Up> <C-w>k
map <Right> <C-w>l

nnoremap [1;5D :tabprevious<CR>
"map <C-Down> <C-w>j
"map <C-Up> <C-w>k
nnoremap [1;5C :tabnext<CR>

nnoremap <Leader>t :below terminal ++rows=15<CR>

"Disables automatic commenting on newline:
autocmd FileType * setlocal formatoptions-=c formatoptions-=r formatoptions-=o

" Instead of failing a command because of unsaved changes, instead raise a
" dialogue asking if you wish to save changed files.
set confirm

" My snippets
" Java
nnoremap ,sout :-1read $HOME/.vim/.println.java<CR><S-J>2hi
"nnoremap ,sout :-1read $HOME/.vim/.println.java !head -n -1<CR>
"nnoremap ,psvm :-1read $HOME/.vim/.psvm.java<CR>jA
nnoremap ,psvm :-1read $HOME/.vim/.psvm.java<CR>j<S-J>O
nnoremap ,try :-1read $HOME/.vim/.try.java<CR>jA


nnoremap <C-j> :m .+1<CR>==
nnoremap <A-k> :m .-2<CR>==
inoremap <C-j> <Esc>:m .+1<CR>==gi
inoremap <C-k> <Esc>:m .-2<CR>==gi
vnoremap <C-j> :m '>+1<CR>gv=gv
vnoremap <C-k> :m '<-2<CR>gv=gv

cnoremap w!! execute 'silent! write !sudo tee % >/dev/null' <bar> edit!

" Enable mouse usage(heresy I know)
set mouse=a
" xterm2 mouse handling. Useful for things like resizing splits 
set ttymouse=xterm2

" Let netrw behave like nerdtree
let g:netrw_preview   = 1
"let g:netrw_alto   = 0
let g:netrw_liststyle = 3
"let g:netrw_winsize   = 30
let g:netrw_browse_split = 4
let g:netrw_altv = 1
let g:netrw_banner = 0
let g:netrw_chgwin=1
"TODO: Check https://stackoverflow.com/a/28192203

"" remap shift-enter to fire up the sidebar
"nnoremap <silent> <S-CR> 20vs<CR>:e .<CR>
"" the same remap as above - may be necessary in some distros
"nnoremap <silent> <C-M> 20vs<CR>:e .<CR>
"" remap control-enter to open files in new tab
"nmap <silent> <C-CR> t 20vs<CR>:e .<CR>:wincmd h<CR>
"" the same remap as above - may be necessary in some distros
"nmap <silent> <NL> t 20vs<CR>:e .<CR>:wincmd h<CR>


"augroup ProjectDrawer
"  autocmd!
"  autocmd VimEnter * :30vs .
"augroup END

"https://vim.fandom.com/wiki/Make_Vim_completion_popup_menu_work_just_like_in_an_IDE
set completeopt=longest,menuone
inoremap <expr> <CR> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"

inoremap <expr> <C-n> pumvisible() ? '<C-n>' :
  \ '<C-n><C-r>=pumvisible() ? "\<lt>Down>" : ""<CR>'

inoremap <expr> <M-,> pumvisible() ? '<C-n>' :
  \ '<C-x><C-o><C-n><C-p><C-r>=pumvisible() ? "\<lt>Down>" : ""<CR>'
