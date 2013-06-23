" Use Vim settings, rather than Vi settings (much better!).
" This must be first, because it changes other options as a side effect.
set nocompatible

" Windows Compatible {
    " On Windows, also use '.vim' instead of 'vimfiles'; this makes synchronization
    " across (heterogeneous) systems easier.
    if has('win32') || has('win64')
      set runtimepath=$HOME/.vim,$VIM/vimfiles,$VIMRUNTIME,$VIM/vimfiles/after,$HOME/.vim/after
    endif
" }

scriptencoding utf-8
set encoding=utf-8

" Allow buffer switching without saving
set hidden

" Display line numbers
set number

" Wrap lines
set wrap
" Break lines on words
set linebreak

" Allow backspacing over everything in insert mode
set backspace=indent,eol,start

" Show the current mode
set showmode

if has("gui_running")
    " Font and colorscheme
    set guifont=Consolas:h14:cANSI
    colorscheme railscasts

    " Disable beep and flash with an autocmd
    set noerrorbells visualbell t_vb=
    autocmd GUIEnter * set visualbell t_vb=

    " Maximize gvim window.
    autocmd GUIEnter * simalt ~x

    " Set width and height
    set lines=35 columns=150

    " GUI options
    set guioptions=aegt

    " Enable mouse
    set mouse=a
    " Hide mouse when typing
    set mousehide
else
    if &term == 'xterm' || &term == 'screen'
    " Use 256 color terminal
    set t_Co=256
    colorscheme distinguished
endif

endif

" Show line and column number of cursor in bottom right
set ruler

" Minimum lines to keep above and below cursor
set scrolloff=3

" Turn on syntax highlighting
syntax on

" Highlight all search matches
set hlsearch

" Turn on incremental searc
set incsearch

" display incomplete commands
set showcmd

" Better tab completion
set wildmenu
set wildignore=*.o,*~,*.pyc

" Only do this part when compiled with support for autocommands.
if has("autocmd")
    " Enable file type detection.
    filetype plugin indent on

    " When editing a file, always jump to the last known cursor position.
    " Don't do it when the position is invalid or when inside an event handler
    " (happens when dropping a file on gvim).
    " Also don't do it when the mark is in the first line, that is the default
    " position when opening a file.
    autocmd BufReadPost *
      \ if line("'\"") > 1 && line("'\"") <= line("$") |
      \   exe "normal! g`\"" |
      \ endif
endif " has("autocmd")

set autoindent
set smartindent

" Keep big history
set history=1000

" Expand tabs with 4 spaces
set tabstop=8
set softtabstop=4
set shiftwidth=4
set expandtab

" Enable cursor movement over lines for <BS>, <SPACE>, h, l
set whichwrap=b,s,h,l

" Show tabs and trailing spaces (eol:$ removed from default)
set list
set listchars=tab:>·,trail:·,extends:#,nbsp:.

" Add colons and dashes to keywords (so 'w' for example will jump over them)
set iskeyword+=:,-,<,>

" Case insensitive search
set ignorecase
" Case sensitive when uc present
set smartcase

" Always show status line
set laststatus=2

" Toggle paste
set pastetoggle=<F4>

" See http://vimdoc.sourceforge.net/htmldoc/options.html#%27viminfo%27
set viminfo='1000,f1,<500,s10,h

" Make sessions cross OS compatible
set sessionoptions+=unix,slash

" Set pwd to the directory the currently edited file is in
" Caveat: saving and loading sessions will not work correctly
" autocmd BufEnter * silent! lcd %:p:h

" Prefer unix file format
set fileformats=unix,dos

" Show opening parens
set showmatch
" How many tenths of a second to blink when matching brackets
set matchtime=2

" Highlight current line
set cursorline

" Change <leader> to ','
let mapleader = ','

" Switching between windows
noremap <C-h> <C-w>h
noremap <C-j> <C-w>j
noremap <C-k> <C-w>k
noremap <C-l> <C-w>l

" Move windows around
noremap <C-w>h <C-w>H
noremap <C-w>j <C-w>J
noremap <C-w>k <C-w>K
noremap <C-w>l <C-w>L
map <C-w><C-h> <C-w>h
map <C-w><C-j> <C-w>j
map <C-w><C-k> <C-w>k
map <C-w><C-l> <C-w>l

" Easier moving by words
map <Space> w
map <S-Space> b

" Saving
nmap <C-s> :w<CR>
imap <C-s> <Esc>:w<CR>a

" Move cursor to next line in display rather than in the file
nnoremap j gj
nnoremap k gk

" Remove highlights
nmap <silent> <leader>m :nohlsearch<CR>

" Jump to the last line when opening log files
:autocmd BufReadPost *.log normal G

" Change directory to the on containing the current file
nmap <silent> <leader>l :lcd %:p:h<CR>

" Shortcut for projects directory
nmap <leader>p :lcd $HOME/Documents/projects<CR>

if has('statusline')
    " Broken down into easily includeable segments
    set statusline=%<%f\                     " Filename
    set statusline+=%w%h%m%r                 " Options
    " TODO: Gucken ob plugin was taugt
    "set statusline+=%{fugitive#statusline()} " Git Hotness
    set statusline+=\ [%{&ff}/%Y]            " Filetype
    set statusline+=\ [%{getcwd()}]          " Current dir
    set statusline+=%=%-14.(%l,%c%V%)\ %p%%  " Right aligned file nav info
endif

" Lines to scroll when cursor leaves screen
set scrolljump=5

set matchpairs+=<:>

" Set to auto read when a file is changed from the outside
set autoread

" Don't redraw while executing macros (good performance config)
set lazyredraw

" For regular expressions turn magic on
set magic

" Enable backup
set backup
" Change the extentions of backup files
set backupext=.bak

if has('persistent_undo')
    set undofile                " Persistent undo
    set undolevels=1000         " Maximum number of changes that can be undone
    " Maximum number lines to save for undo on a buffer reload
    set undoreload=10000
endif

" Yank from the cursor to the end of the line, to be consistent with C and D.
nnoremap Y y$

" Visual shifting (does not exit Visual mode)
vnoremap < <gv
vnoremap > >gv

" Map <Leader>ff to display all lines with keyword under cursor
" and ask which one to jump to
nmap <Leader>ff [I:let nr = input("Which one: ")<Bar>exe "normal " . nr ."[\t"<CR>

" Edit vimrc with ,v
nmap <Leader>v :edit ~/.vim/vimrc<CR>

" Remove trailing whitespaces and ^M chars
autocmd FileType c,cpp,java,go,php,javascript,python,twig,xml,yml autocmd BufWritePre <buffer> call StripTrailingWhitespace()

" Strip whitespace {
function! StripTrailingWhitespace()
    " Preparation: save last search, and cursor position.
    let _s=@/
    let l = line(".")
    let c = col(".")
    " do the business:
    %s/\s\+$//e
    " clean up: restore previous search history, and cursor position
    let @/=_s
    call cursor(l, c)
endfunction
" }

" Initialize directories {
function! InitializeDirectories()
    let parent = $HOME . '/.vim'
    let prefix = 'vim'
    let dir_list = {
                \ 'backup': 'backupdir',
                \ 'views': 'viewdir',
                \ 'swap': 'directory' }

    if has('persistent_undo')
        let dir_list['undo'] = 'undodir'
    endif

    " Specify different directories in which to place the vimbackup,
    " vimviews, vimundo, and vimswap files/directories
    let common_dir = parent . '/.' . prefix

    for [dirname, settingname] in items(dir_list)
        let directory = common_dir . dirname . '/'
        if exists("*mkdir")
            if !isdirectory(directory)
                call mkdir(directory)
            endif
        endif
        if !isdirectory(directory)
            echo "Warning: Unable to create backup directory: " . directory
            echo "Try: mkdir -p " . directory
        else
            let directory = substitute(directory, " ", "\\\\ ", "g")
            exec "set " . settingname . "=" . directory
        endif
    endfor
endfunction
" }
call InitializeDirectories()

" Setup Vundle {
" Install Vundle if it is not present
let vundle_installed=0
let vundle_fresh=0
let vundle_readme=expand('~/.vim/bundle/vundle/README.md')
if !filereadable(vundle_readme) && !exists("g:disable_all_plugins")
    echo "Installing Vundle..."
    echo ""
    call system("git --version")
    if v:shell_error == 0
        silent !git clone https://github.com/gmarik/vundle ~/.vim/bundle/vundle
        let vundle_installed=1
        let vundle_fresh=1
    else
        echo "git not found, cannot install Vundle"
    endif
elseif filereadable(vundle_readme)
    let vundle_installed=1
endif


if vundle_installed==1
    filetype off " required!
    set runtimepath+=~/.vim/bundle/vundle
    call vundle#rc()

    " Let Vundle manage Vundle
    " required !
    Bundle 'gmarik/vundle'

    if filereadable($HOME . "/.vim/bundles.vim")
        source ~/.vim/bundles.vim
    endif

    if vundle_fresh==1
        :BundleInstall
    endif

    filetype plugin indent on

    " Configuration for plugins
    if filereadable($HOME . "/.vim/pluginsrc.vim")
        source ~/.vim/pluginsrc.vim
    endif
endif
" } end setup Vundle
set omnifunc=syntaxcomplete#Complete

" TODO
" vimrc in Sektionen unterteilen, http://amix.dk/vim/vimrc.html
