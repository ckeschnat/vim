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

" rails
let g:rubycomplete_buffer_loading = 1
let g:rubycomplete_rails = 1

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

" lightline
let g:lightline = {
      \ 'active': {
      \   'left': [ [ 'mode', 'paste' ], [ 'fugitive', 'filename' ], ['ctrlpmark'] ],
      \   'right': [ [ 'syntastic', 'lineinfo' ], ['percent'], [ 'fileformat', 'fileencoding', 'filetype' ] ]
      \ },
      \ 'component_function': {
      \   'filename': 'MyFilename',
      \   'fileformat': 'MyFileformat',
      \   'filetype': 'MyFiletype',
      \   'fileencoding': 'MyFileencoding',
      \   'mode': 'MyMode',
      \   'ctrlpmark': 'CtrlPMark',
      \ },
      \ 'component_expand': {
      \   'syntastic': 'SyntasticStatuslineFlag',
      \ },
      \ 'component_type': {
      \   'syntastic': 'error',
      \ },
      \ 'subseparator': { 'left': '|', 'right': '|' }
      \ }

function! MyModified()
  return &ft =~ 'help' ? '' : &modified ? '+' : &modifiable ? '' : '-'
endfunction

function! MyReadonly()
  return &ft !~? 'help' && &readonly ? 'RO' : ''
endfunction

function! MyFilename()
  let fname = expand('%:t')
  return fname == 'ControlP' ? g:lightline.ctrlp_item :
        \ ('' != MyReadonly() ? MyReadonly() . ' ' : '') .
        \ ('' != fname ? fname : '[No Name]') .
        \ ('' != MyModified() ? ' ' . MyModified() : '')
endfunction

function! MyFugitive()
  try
    if exists('*fugitive#head')
      let mark = ''  " edit here for cool mark
      let _ = fugitive#head()
      return strlen(_) ? mark._ : ''
    endif
  catch
  endtry
  return ''
endfunction

function! MyFileformat()
  return winwidth(0) > 70 ? &fileformat : ''
endfunction

function! MyFiletype()
  return winwidth(0) > 70 ? (strlen(&filetype) ? &filetype : 'no ft') : ''
endfunction

function! MyFileencoding()
  return winwidth(0) > 70 ? (strlen(&fenc) ? &fenc : &enc) : ''
endfunction

function! MyMode()
  let fname = expand('%:t')
  return fname ==  'ControlP' ? 'CtrlP':
        \ winwidth(0) > 60 ? lightline#mode() : ''
endfunction

function! CtrlPMark()
  if expand('%:t') =~ 'ControlP'
    call lightline#link('iR'[g:lightline.ctrlp_regex])
    return lightline#concatenate([g:lightline.ctrlp_prev, g:lightline.ctrlp_item
          \ , g:lightline.ctrlp_next], 0)
  else
    return ''
  endif
endfunction

let g:ctrlp_status_func = {
  \ 'main': 'CtrlPStatusFunc_1',
  \ 'prog': 'CtrlPStatusFunc_2',
  \ }

function! CtrlPStatusFunc_1(focus, byfname, regex, prev, item, next, marked)
  let g:lightline.ctrlp_regex = a:regex
  let g:lightline.ctrlp_prev = a:prev
  let g:lightline.ctrlp_item = a:item
  let g:lightline.ctrlp_next = a:next
  return lightline#statusline(0)
endfunction

function! CtrlPStatusFunc_2(str)
  return lightline#statusline(0)
endfunction

augroup AutoSyntastic
  autocmd!
  autocmd BufWritePost *.c,*.cpp call s:syntastic()
augroup END
function! s:syntastic()
  SyntasticCheck
  call lightline#update()
endfunction
let g:lightline.colorscheme = 'hybrid'

" Neocomplete

let g:neocomplete#enable_at_startup = 1
let g:neocomplete#enable_smart_case = 1
let g:neocomplete#enable_refresh_always = 1
let g:neocomplete#max_list = 30
let g:neocomplete#min_keyword_length = 1
let g:neocomplete#sources#syntax#min_keyword_length = 1
let g:neocomplete#data_directory = $HOME.'/.vim/tmp/neocomplete'

" disable the auto select feature by default to speed up writing without
" obstacles (is optimal for certain situations)
let g:neocomplete#enable_auto_select = 1
" toggle the auto select feature
function! ToggleNeoComplete()
  if !g:neocomplete#disable_auto_complete && g:neocomplete#enable_auto_select
      let g:neocomplete#disable_auto_complete = 0
      let g:neocomplete#enable_auto_select = 0
  elseif !g:neocomplete#disable_auto_complete && !g:neocomplete#enable_auto_select
      let g:neocomplete#disable_auto_complete = 1
      let g:neocomplete#enable_auto_select = 0
  elseif g:neocomplete#disable_auto_complete && !g:neocomplete#enable_auto_select
      let g:neocomplete#disable_auto_complete = 0
      let g:neocomplete#enable_auto_select = 1
  endif
endfunction
nnoremap <silent><Leader>ea :call ToggleNeoComplete()<CR>
" Enable omni completion.
autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
autocmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
autocmd FileType python setlocal omnifunc=pythoncomplete#Complete
autocmd FileType ruby setlocal omnifunc=rubycomplete#Complete
autocmd FileType xml setlocal omnifunc=xmlcomplete#CompleteTags

if !exists('g:neocomplete#sources#omni#input_patterns')
    let g:neocomplete#sources#omni#input_patterns = {}
endif

let g:neocomplete#sources#omni#input_patterns.python='[^. \t]\.\w*'

