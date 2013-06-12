#!/bin/bash
cat > ~/.vimrc <<DELIM
function! MySys()
    return "unix"
endfunction

" Uncomment to disable loading of plugins
" let g:disable_all_plugins = 1

source ~/.vim/vimrc
DELIM
