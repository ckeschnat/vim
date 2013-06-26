" ----------------------------------------------------------------------------
" important
" ----------------------------------------------------------------------------
set nocompatible " Use Vim settings, rather than Vi settings (much better!).
                 " This must be first, because it changes other options as a side effect.

" Windows Compatible 
    " On Windows, also use '.vim' instead of 'vimfiles'; this makes synchronization
    " across (heterogeneous) systems easier.
    if has('win32') || has('win64')
      set runtimepath=$HOME/.vim,$VIM/vimfiles,$VIMRUNTIME,$VIM/vimfiles/after,$HOME/.vim/after
    endif
set pastetoggle=<F4> " Toggle paste

" ----------------------------------------------------------------------------
" moving around, searching and patterns
" ----------------------------------------------------------------------------
set incsearch " Turn on incremental search
set whichwrap=b,s,h,l " Enable cursor movement over lines for <BS>, <SPACE>, h, l
set ignorecase " Case insensitive search
set smartcase " Case sensitive when upper case present
set magic " For regular expressions turn magic on

" ----------------------------------------------------------------------------
" tags
" ----------------------------------------------------------------------------

" ----------------------------------------------------------------------------
" displaying text
" ----------------------------------------------------------------------------
set number " Display line numbers
set linebreak " Break lines on words
set wrap " Wrap lines
set scrolloff=3 " Minimum lines to keep above and below cursor
set list " Show tabs and trailing spaces
set listchars=tab:>·,trail:·,extends:#,nbsp:. " with these symbols(eol:$ removed from default)
set lazyredraw " Don't redraw while executing macros (good performance config)

" ----------------------------------------------------------------------------
" syntax, highlighting and spelling
" ----------------------------------------------------------------------------
syntax on " Turn on syntax highlighting
set hlsearch " Highlight all search matches
filetype plugin indent on " Enable file type detection.
set cursorline " Highlight current line

" ----------------------------------------------------------------------------
" multiple windows
" ----------------------------------------------------------------------------
set hidden " Allow buffer switching without saving
set laststatus=2 " Always show status line

if has('statusline')
    " Broken down into easily includeable segments
    set statusline=%<%f\                     " Filename
    set statusline+=%w%h%m%r                 " Options
    " TODO: Gucken ob plugin was taugt
    "set statusline+=%fugitive#statusline() " Git Hotness
    set statusline+=\ [%{&ff}/%Y]            " Filetype
    set statusline+=\ [%{getcwd()}]          " Current dir
    set statusline+=%=%-14.(%l,%c%V%)\ %p%%  " Right aligned file nav info
endif

" ----------------------------------------------------------------------------
" multiple tab pages
" ----------------------------------------------------------------------------

" ----------------------------------------------------------------------------
" terminal
" ----------------------------------------------------------------------------
set scrolljump=5 " Lines to scroll when cursor leaves screen

" ----------------------------------------------------------------------------
" using the mouse
" ----------------------------------------------------------------------------

" ----------------------------------------------------------------------------
" GUI
" ----------------------------------------------------------------------------
if has("gui_running")
    set guifont=Consolas:h14:cANSI " Font
    colorscheme railscasts " Colorscheme

    set noerrorbells visualbell t_vb= " Disable beep
    autocmd GUIEnter * set visualbell t_vb= " Disable visual flash

    autocmd GUIEnter * simalt ~x " Maximize gvim window.

    set lines=35 columns=150 " Set width and height

    set guioptions=aegt " GUI options

    set mouse=a " Enable mouse
    set mousehide " Hide mouse when typing
else
    if &term == 'xterm' || &term == 'screen'
        set t_Co=256 " Use 256 color terminal
        colorscheme distinguished " Colorscheme
    endif
endif

" ----------------------------------------------------------------------------
" printing
" ----------------------------------------------------------------------------

" ----------------------------------------------------------------------------
" messages and info
" ----------------------------------------------------------------------------
set showmode " Show the current mode
set ruler " Show line and column number of cursor in bottom right
set showcmd " display incomplete commands

" ----------------------------------------------------------------------------
" selecting text
" ----------------------------------------------------------------------------

" ----------------------------------------------------------------------------
" editing text
" ----------------------------------------------------------------------------
set backspace=indent,eol,start " Allow backspacing over everything in insert mode
set omnifunc=syntaxcomplete#Complete " Set function to be used for omni completion
set showmatch " Show opening parens
set matchtime=2 " How many tenths of a second to blink when matching brackets
set matchpairs+=<:> " list of pairs that match for the "%" command

" ----------------------------------------------------------------------------
" tabs and indenting
" ----------------------------------------------------------------------------
set autoindent " Automatically set the indent of a new line
set smartindent " Do clever autoindenting

" Expand tabs with 4 spaces
set tabstop=8
set softtabstop=4
set shiftwidth=4
set expandtab

" ----------------------------------------------------------------------------
" folding
" ----------------------------------------------------------------------------

" ----------------------------------------------------------------------------
" diff mode
" ----------------------------------------------------------------------------

" ----------------------------------------------------------------------------
" mapping
" ----------------------------------------------------------------------------

" ----------------------------------------------------------------------------
" reading and writing files
" ----------------------------------------------------------------------------
set fileformats=unix,dos " Prefer unix file format
set autoread " Set to auto read when a file is changed from the outside
set backup " Enable backup
set backupext=.bak " Change the extentions of backup files

" ----------------------------------------------------------------------------
" command line editing
" ----------------------------------------------------------------------------
set wildmenu " Command-line completion shows a list of matches
set wildignore=*.o,*~,*.pyc " List of patterns to ignore files for file name completion

set history=1000 " Keep big history

if has('persistent_undo')
    set undofile                " Persistent undo
    set undolevels=1000         " Maximum number of changes that can be undone
    set undoreload=10000 " Maximum number lines to save for undo on a buffer reload
endif

" ----------------------------------------------------------------------------
" executing external commands
" ----------------------------------------------------------------------------

" ----------------------------------------------------------------------------
" running make and jumping to errors
" ----------------------------------------------------------------------------

" ----------------------------------------------------------------------------
" language specific
" ----------------------------------------------------------------------------
set iskeyword+=:,-,<,> " Add colons and dashes to keywords (so 'w' for example will jump over them)

" ----------------------------------------------------------------------------
" multi-byte characters
" ----------------------------------------------------------------------------
scriptencoding utf-8
set encoding=utf-8

" ----------------------------------------------------------------------------
" various
" ----------------------------------------------------------------------------
set viminfo='1000,f1,<500,s10,h " See http://vimdoc.sourceforge.net/htmldoc/options.html#%27viminfo%27
set sessionoptions+=unix,slash " Make sessions cross OS compatible

" When editing a file, always jump to the last known cursor position.
" Don't do it when the position is invalid or when inside an event handler
" (happens when dropping a file on gvim).
" Also don't do it when the mark is in the first line, that is the default
" position when opening a file.
autocmd BufReadPost *
  \ if line("'\"") > 1 && line("'\"") <= line("$") |
  \   exe "normal! g`\"" |
  \ endif

" Set pwd to the directory the currently edited file is in
" Caveat: saving and loading sessions will not work correctly
" autocmd BufEnter * silent! lcd %:p:h

let mapleader = ',' " Change <leader> to ','

" Jump to the last line when opening log files
:autocmd BufReadPost *.log normal G

" Remove trailing whitespaces and ^M chars
autocmd FileType c,cpp,java,go,php,javascript,python,ruby,twig,xml,yml autocmd BufWritePre <buffer> call StripTrailingWhitespace()

" File type specifig settings
autocmd Filetype ruby,html setlocal shiftwidth=2

" ----------------------------------------------------------------------------
" mappings
" ----------------------------------------------------------------------------
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

" Saving
nmap <C-s> :w<CR>
imap <C-s> <Esc>:w<CR>a

" Move cursor to next line in display rather than in the file
nnoremap j gj
nnoremap k gk

" Remove highlights
nmap <silent> <leader>m :nohlsearch<CR>

" Change directory to the on containing the current file
nmap <silent> <leader>l :lcd %:p:h<CR>

" Shortcut for projects directory
nmap <leader>p :lcd $HOME/Documents/projects<CR>

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

" ----------------------------------------------------------------------------
" helper functions
" ----------------------------------------------------------------------------
" Strip whitespace
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

" Initialize directories
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
call InitializeDirectories()

" ----------------------------------------------------------------------------
" Setup Vundle
" ----------------------------------------------------------------------------
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
