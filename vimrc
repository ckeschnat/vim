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
set tags+=.git/tags

" ----------------------------------------------------------------------------
" displaying text
" ----------------------------------------------------------------------------
set number " Display line numbers
set linebreak " Break lines on words
set wrap " Wrap lines
set scrolloff=3 " Minimum lines to keep above and below cursor
set list " Show tabs and trailing spaces
set listchars=tab:>·,trail:·,extends:#,nbsp:. " Use these symbols (eol:$ removed from default)
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
    if exists(':Git')
        set statusline+=%{fugitive#statusline()} " Git Hotness
    endif
    if exists(':TagbarOpen')
        set statusline+=%{tagbar#currenttag('[%s]','','f')}   " Tagbar
    endif
    set statusline+=\ [%{&ff}/%Y]            " Filefomat / Filetype
    set statusline+=[%{strlen(&fenc)?&fenc:'none'}] " Encoding
    set statusline+=\ [%{getcwd()}]          " Current dir
    set statusline+=%=%-14.(%l,%c%V%)\ %p%%  " Right aligned file nav info
endif

set splitright " put new vsplit windows to the right of the current
set splitbelow " put new split windows to the bottom of the current

" ----------------------------------------------------------------------------
" multiple tab pages
" ----------------------------------------------------------------------------

" ----------------------------------------------------------------------------
" terminal
" ----------------------------------------------------------------------------
set scrolljump=5 " Lines to scroll when cursor leaves screen
set ttyfast " this is the 21st century, people

" ----------------------------------------------------------------------------
" using the mouse
" ----------------------------------------------------------------------------
if has("gui_running")
    set mouse=a " Enable mouse
    set mousehide " Hide mouse when typing
endif

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

else
    if &term == 'xterm' || &term == 'screen' || &term == 'xterm-256color' || &term == 'screen-256color'
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
set confirm " Ask to save buffer instead of failing when executing
            " commands which close buffers

" ----------------------------------------------------------------------------
" selecting text
" ----------------------------------------------------------------------------
if has('clipboard')
    set clipboard=unnamed " Yank to the system clipboard by default
endif

" ----------------------------------------------------------------------------
" editing text
" ----------------------------------------------------------------------------
set backspace=indent,eol,start " Allow backspacing over everything in insert mode
set omnifunc=syntaxcomplete#Complete " Set function to be used for omni completion
set completeopt+=longest " better omni-complete menu
set showmatch " Show opening parens
set matchtime=2 " How many tenths of a second to blink when matching brackets
set matchpairs+=<:> " list of pairs that match for the "%" command
set nojoinspaces    " Use only one space after '.' when joining
                    " lines, instead of two
if v:version > 703 || v:version == 703 && has("patch541")
    set formatoptions+=j " delete comment char on second line when
                       " joining two commented lines
endif

set nrformats= " Dont consider 07 octal and 0x7 hex

" ----------------------------------------------------------------------------
" tabs and indenting
" ----------------------------------------------------------------------------
set autoindent " Automatically set the indent of a new line
set smartindent " Do clever autoindenting
set shiftround " round to 'shiftwidth' for "<<" and ">>"

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
set wildmode=longest,list
set wildmenu " Command-line completion shows a list of matches
set wildignore=*.o,*~,*.pyc,*.pyo " List of patterns to ignore files for file name completion
set suffixes+=.pyc,.pyo " Don't autocomplete these filetypes
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
" set iskeyword+=:,- " Add colons and dashes to keywords (so 'w' for example will jump over them)

" ----------------------------------------------------------------------------
" multi-byte characters
" ----------------------------------------------------------------------------
set encoding=utf-8

" ----------------------------------------------------------------------------
" various
" ----------------------------------------------------------------------------
set viminfo='1000,f1,<500,s10,h,% " See http://vimdoc.sourceforge.net/htmldoc/options.html#%27viminfo%27
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

" Jump to the last line when opening log files
:autocmd BufReadPost *.log normal G

" Ruby syntax for capistrano files
au BufRead,BufNewFile Capfile set filetype=ruby

" Remove trailing whitespaces and ^M chars
autocmd FileType c,cpp,java,go,php,javascript,python,ruby,twig,xml,yml,eruby autocmd BufWritePre <buffer> call StripTrailingWhitespace()

" File type specifig settings
autocmd Filetype ruby,html,eruby,scss,yaml setlocal shiftwidth=2

" Automatically reload vimrc when changing vimrc/bundles.vim/pluginsrc.vim
" has to be in augroup or it will bog down vim, see http://vimbits.com/bits/128
augroup AutoReloadVimRC
    au!
    autocmd! BufWritePost vimrc,bundles.vim,pluginsrc.vim source $MYVIMRC
augroup END

" ----------------------------------------------------------------------------
" mappings
" ----------------------------------------------------------------------------
" Change <leader> to ','
let mapleader = ','

" Easier escape
inoremap jk <esc>
inoremap kj <esc>

" Use \ as , (repeat last f,F,t or T in reverse direction) 
nnoremap \ ,

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

" Move cursor to next line in display rather than in the file
nnoremap j gj
nnoremap k gk

" Move to first/last char with H and L
nnoremap H ^
nnoremap L g_

" Don't jump with */#
nnoremap <silent> * *<C-o>
nnoremap <silent> # #<C-o>
nnoremap <silent> g* g*<C-o>
nnoremap <silent> g# g#<C-o>

" Remove highlights
nmap <silent> <leader>m :nohlsearch<CR>

" Yank from the cursor to the end of the line, to be consistent with C and D.
nnoremap Y y$

" Visual shifting (does not exit Visual mode)
vnoremap < <gv
vnoremap > >gv

" Edit vimrc with ,v
nmap <Leader>v :edit ~/.vim/vimrc<CR>

" Visual mode pressing * or # searches for the current selection
" Super useful! From an idea by Michael Naumann
vnoremap <silent> * :call VisualSelection('f')<CR>
vnoremap <silent> # :call VisualSelection('b')<CR>

" Quickly open a buffer for scribble
map <leader>q :e ~/buffer<cr>

" Space for command mode
nnoremap <Space> :

" Ctrl-a used for tmux, so rebind
nnoremap <C-q> <C-a>

" Scroll through ex history with filtering
cnoremap <C-p> <Up>
cnoremap <C-n> <Down>

" Emacs-style editing on the command-line
" start of line
cnoremap <C-A>         <Home>
" back one character
cnoremap <C-B>         <Left>
" delete character under cursor
cnoremap <C-D>         <Del>
" end of line
cnoremap <C-E>         <End>
" forward one character
cnoremap <C-F>         <Right>
" recall newer command-line
cnoremap <C-N>         <Down>
" recall previous (older) command-line
cnoremap <C-P>         <Up>
" back one word
cnoremap <Esc><C-B>    <S-Left>
" forward one word
cnoremap <Esc><C-F>    <S-Right>

" Not releasing shift when trying to select multiple lines often happens
vnoremap <S-j> j

" Sane regexes
nnoremap / /\v
vnoremap / /\v
nnoremap ? ?\v
vnoremap ? ?\v
cnoremap s/ s/\v
cnoremap %s/ %s/\v

" ----------------------------------------------------------------------------
" custom functions
" ----------------------------------------------------------------------------
" Ag motions
" Motions to Ag for things.  Works with pretty much everything, including:
"
"   w, W, e, E, b, B, t*, f*, i*, a*, and custom text objects
" https://bitbucket.org/sjl/dotfiles/src/tip/vim/vimrc
nnoremap <silent> <leader>a :set opfunc=<SID>AgMotion<CR>g@
xnoremap <silent> <leader>a :<C-U>call <SID>AgMotion(visualmode())<CR>

nnoremap <bs> :Ag! '\b<c-r><c-w>\b'<cr>
xnoremap <silent> <bs> :<C-U>call <SID>AgMotion(visualmode())<CR>

function! s:CopyMotionForType(type)
    if a:type ==# 'v'
        silent execute "normal! `<" . a:type . "`>y"
    elseif a:type ==# 'char'
        silent execute "normal! `[v`]y"
    endif
endfunction

function! s:AgMotion(type) abort
    let reg_save = @@

    call s:CopyMotionForType(a:type)

    execute "normal! :Ag " . shellescape(@@) . "\<cr>"

    let @@ = reg_save
endfunction

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

function! CmdLine(str)
    exe "menu Foo.Bar :" . a:str
    emenu Foo.Bar
    unmenu Foo
endfunction

function! VisualSelection(direction) range
    let l:saved_reg = @"
    execute "normal! vgvy"

    let l:pattern = escape(@", '\\/.*$^~[]')
    let l:pattern = substitute(l:pattern, "\n$", "", "")

    if a:direction == 'b'
        execute "normal ?" . l:pattern . "^M"
    elseif a:direction == 'gv'
        call CmdLine("vimgrep " . '/'. l:pattern . '/' . ' **/*.')
    elseif a:direction == 'replace'
        call CmdLine("%s" . '/'. l:pattern . '/')
    elseif a:direction == 'f'
        execute "normal /" . l:pattern . "^M"
    endif

    let @/ = l:pattern
    let @" = l:saved_reg
endfunction

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
