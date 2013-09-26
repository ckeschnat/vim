On Windows, rename 'vimfiles' to '.vim' (rename it to '.vim.',
windows explorer will remove the trailing dot).
Create a vimrc with the following content (on linux 'create_vimrc.sh' can be used):

    function! MySys()
        return "windows"
    endfunction
    " Uncomment to disable loading of plugins
    " let g:disable_all_plugins = 1

    source ~/.vim/vimrc

Plugins are managed with [Vundle](https://github.com/gmarik/vundle "Vundle").
Follow the instructions on the Vundle page for installation.
(usually 'git clone https://github.com/gmarik/vundle.git ~/.vim/bundle/vundle)
If Vundle is not installed, no plugins will be loaded. So this vimrc will work without it.
