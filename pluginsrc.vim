" CtrlP
" Starting directory
let g:ctrlp_working_path_mode = 'ra'
" Tell CtrlP to show hidden files
let g:ctrlp_show_hidden = 1
" Mappings
nmap <leader>. :CtrlP<CR>

let g:ctrlp_custom_ignore = {
            \ 'dir': 'tmp\/',
            \ }

" Ignore .git directory
let g:ctrlp_user_command = ['.git', 'cd %s && git ls-files . -co --exclude-standard', 'find %s -type f']
let g:ctrlp_use_caching = 0

" Supertab
" Set completion type for supertab
let g:SuperTabDefaultCompletionType = "<c-x><c-o>"

" rails
let g:rubycomplete_buffer_loading = 1
let g:rubycomplete_rails = 1

" Tagbar
nnoremap <silent> <leader>l :TagbarOpenAutoClose<CR>

" vimux
" nnoremap <silent> <leader><Space> :call VimuxRunCommand("cd ~/projects/sample_app/ && clear; rspec spec")<CR>
nnoremap <silent> <leader><Space> :call VimuxRunCommand("clear; rspec spec")<CR>
nnoremap <silent> <leader>r :call VimuxInspectRunner()<CR>
nnoremap <silent> <leader>cc :VimuxCloseRunner<CR>

" vim-sneak
let g:sneak#streak = 1

" Rainbow parenthesis
au VimEnter * RainbowParenthesesToggle
au Syntax * RainbowParenthesesLoadRound
au Syntax * RainbowParenthesesLoadSquare
au Syntax * RainbowParenthesesLoadBraces

" vim-expand-region
vmap v <Plug>(expand_region_expand)
vmap <C-v> <Plug>(expand_region_shrink)

" targets
let g:targets_pairs = '()b {}B <>a'

" airline
let g:airline_theme='powerlineish'
let g:airline_left_sep=''
let g:airline_right_sep=''
