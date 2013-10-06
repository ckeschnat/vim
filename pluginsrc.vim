" Easymotion {
    " Change key for EasyMotion to <leader> (default: <leader><leader>)
    let g:EasyMotion_leader_key = '<Leader>'
" }

" CtrlP {
    " Starting directory
    let g:ctrlp_working_path_mode = 'ra'
    " Tell CtrlP to show hidden files
    let g:ctrlp_show_hidden = 1
    " Mappings
    nmap <leader><leader> :CtrlP<CR>
    nmap <leader>. :CtrlPMRU<CR>
    nmap <leader>/ :CtrlPBuffer<CR>
" }

" Supertab {
    " Set completion type for supertab
    let g:SuperTabDefaultCompletionType = "context"
    " Mappings
    " This isn't necessarily used but the default is
    " overridden because neosnipped calls <Plug>SuperTabForward
    " if it can't find a snippet (see below). So this is just here to
    " "give" <Tab> to neosnippet
    let g:SuperTabMappingForward = '<C-Space>'
" }

" Numbers {
    nnoremap <F3> :NumbersToggle<CR>
    nnoremap <F4> :NumbersOnOff<CR>
" }

" neosnippet {
    " Plugin key-mappings.
    imap <C-k>     <Plug>(neosnippet_expand_or_jump)
    smap <C-k>     <Plug>(neosnippet_expand_or_jump)
    xmap <C-k>     <Plug>(neosnippet_expand_target)

    " SuperTab like snippets behavior.
    imap <expr><TAB> neosnippet#expandable_or_jumpable() ?
    \ "\<Plug>(neosnippet_expand_or_jump)"
    \: pumvisible() ? "\<C-n>" : "<Plug>SuperTabForward"
    smap <expr><TAB> neosnippet#expandable_or_jumpable() ?
    \ "\<Plug>(neosnippet_expand_or_jump)"
    \: "<Plug>SuperTabForward"

    " For snippet_complete marker.
    if has('conceal')
      set conceallevel=2 concealcursor=i
    endif

    " Enable snipMate compatibility feature.
    let g:neosnippet#enable_snipmate_compatibility = 1
    " Tell Neosnippet about the other snippets
    let g:neosnippet#snippets_directory='~/.vim/bundle/vim-snippets/snippets'
" }

" rails {
let g:rubycomplete_buffer_loading = 1
let g:rubycomplete_rails = 1
" }

" TaskList.vim
map <leader>x <Plug>TaskList

" Tagbar
nnoremap <silent> <leader>l :TagbarOpenAutoClose<CR>

" vimux
" nnoremap <silent> <leader><Space> :call VimuxRunCommand("cd ~/projects/sample_app/ && clear; rspec spec")<CR>
nnoremap <silent> <leader><Space> :call VimuxRunCommand("clear; rspec spec")<CR>
nnoremap <silent> <leader>r :call VimuxInspectRunner()<CR>
nnoremap <silent> <leader>cc :VimuxCloseRunner<CR>

" YankRing
nnoremap <silent> <leader>p :YRShow<CR>
