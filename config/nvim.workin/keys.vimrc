let mapleader = ","

vmap <Leader>b :<C-U>terminal git blame <C-R>=expand("%:p") <cr> \| sed -n <C-R>=line("<") <cr>,<C-R>=line(">") <cr>p <cr>
map <Leader>cp "*y
map <Leader>d obinding.pry<esc>:w<cr>
map <Leader>fix :cnoremap % %<cr>
map <Leader>i mmgg=G`m<cr>
map <Leader>m :Rmodel
map <Leader>mm :T migrate && annotate<cr>
map <Leader>n <plug>NERDTreeTabsToggle<cr>
map <Leader>rd :T rspec % --format documentation<cr>
" vim-test integration to run tests
map <Leader>ra :TestSuite<cr>
map <Leader>rf :TestFile<cr>
map <Leader>rc :TestNearest<cr>
map <Leader>rr :TestLast<cr>
" clear the extra white spaces with the trailing-whitespaces plugin
map <Leader>rw :FixWhitespace<cr>
map <Leader>sp yss<p>
map <Leader>so :so %<cr>
map <Leader>vi :tabe ~/.config/nvim/init.vimrc<cr>
map <Leader>vik :tabe ~/.config/nvim/keys.vimrc<cr>
map <Leader>vip :tabe ~/.config/nvim/plugins.vimrc<cr>
map <Leader>vic :tabe ~/.config/nvim/colors.vimrc<cr>
map <Leader>w <C-w>w
autocmd FileType ruby map <Leader><tab> :A<cr>
autocmd FileType go map <Leader><tab> :GoAlternate<cr>
" Edit another file in the same directory as the current file
" uses expression to extract path from current file's path
map <Leader>e :e <C-R>=expand("%:p:h") . '/'<cr>
map <Leader>s :split <C-R>=expand("%:p:h") . '/'<cr>
map <Leader>sn :CocCommand snippets.editSnippets<cr>
map <Leader>v :vnew <C-R>=expand("%:p:h") . '/'<cr>
" Ruby: convert hashrockets to new hash syntax
nmap <Leader>hr :%s/\:\([a-zA-Z_]*\)\s*=>/\1\:/<cr>
vmap <Leader>hr :s/\:\([a-zA-Z_]*\)\s*=>/\1\:/<cr>

map <C-h> :nohl<cr>
imap <C-l> :<Space>
map <C-s> <esc>:w<cr>
imap <C-s> <esc>:w<cr>
map <C-t> <esc>:tabnew<cr>
map <C-x> <C-w>c
map <C-n> :cn<cr>
map <C-p> :cp<cr>
" disable the arrow keys
nnoremap  <Up> ""
nnoremap  <Down> ""
nnoremap  <Left> ""
nnoremap  <Right> ""
vnoremap  <Up> ""
vnoremap  <Down> ""
vnoremap  <Left> ""
vnoremap  <Right> ""
" make hjkl movements accessible from insert mode via the <Alt> modifier key
inoremap <C-h> <C-o>h
inoremap <C-j> <C-o>j
inoremap <C-k> <C-o>k
inoremap <C-l> <C-o>l
" Emacs-like beginning and end of line.
imap <c-e> <c-o>$
imap <c-a> <c-o>^
" Disable Ex mode
map Q <Nop>
" Disable K looking stuff up
map K <Nop>
" Let's be reasonable, shall we?
nmap k gk
nmap j gj
" remove search highlights on CR
map <CR> :noh<CR>

" ------------------------------------
" Neoterm mappings
" ------------------------------------
nnoremap <silent> <f10> :TREPLSendFile<cr>
nnoremap <silent> <f9> :TREPLSendLine<cr>
vnoremap <silent> <f9> :TREPLSendSelection<cr>
" open terminal or reuse the existing one
nnoremap <silent> <leader>to :TT<cr>
" hide/close terminal
nnoremap <silent> <leader>tc :Tclose<cr>
" clear terminal
nnoremap <silent> <leader>tl :Tclear<cr>
" kills the current job (send a <c-c>)
nnoremap <silent> <leader>tk :Tkill<cr>

" ------------------------------------
" Denite
" ------------------------------------
nnoremap <Leader>h :Denite file/rec -split=floating -winrow=1 -start-filter<cr>
nnoremap ; :Denite buffer -split=floating -winrow=1 -start-filter<cr>
nnoremap <leader>t :DeniteProjectDir file/rec<CR>
nnoremap <space>/ :Denite grep:. -no-empty -start-filter<cr>
nnoremap <space>k :DeniteCursorWord grep:.<cr>
nnoremap <space>l :Denite line<cr>

" Define mappings while in 'filter' mode
"   <C-o>         - Switch to normal mode inside of search results
"   <Esc>         - Exit denite window in any mode
"   <CR>          - Open currently selected file in any mode
"   <C-t>         - Open currently selected file in a new tab
"   <C-v>         - Open currently selected file a vertical split
"   <C-s>         - Open currently selected file in a horizontal split
autocmd FileType denite-filter call s:denite_filter_my_settings()
function! s:denite_filter_my_settings() abort
  imap <silent><buffer> <CR>
  \ <Plug>(denite_filter_update)
  nnoremap <silent><buffer><expr> <Esc>
  \ denite#do_map('quit')
  inoremap <silent><buffer><expr> <C-t>
  \ denite#do_map('do_action', 'tabopen')
  inoremap <silent><buffer><expr> <C-v>
  \ denite#do_map('do_action', 'vsplit')
  inoremap <silent><buffer><expr> <C-s>
  \ denite#do_map('do_action', 'split')
endfunction

" Define mappings while in denite window
"   <CR>        - Opens currently selected file
"   q or <Esc>  - Quit Denite window
"   o           - Opens currently selected file
"   d           - Delete currenly selected file
"   p           - Preview currently selected file
"   <C-o> or i  - Switch to insert mode inside of filter prompt
"   t           - Open currently selected file in a new tab
"   v           - Open currently selected file a vertical split
"   s           - Open currently selected file in a horizontal split
autocmd FileType denite call s:denite_my_settings()
function! s:denite_my_settings() abort
  nnoremap <silent><buffer><expr> <CR>
  \ denite#do_map('do_action')
  nnoremap <silent><buffer><expr> q
  \ denite#do_map('quit')
  nnoremap <silent><buffer><expr> <Esc>
  \ denite#do_map('quit')
  nnoremap <silent><buffer><expr> o
  \ denite#do_map('do_action', 'open')
  nnoremap <silent><buffer><expr> d
  \ denite#do_map('do_action', 'delete')
  nnoremap <silent><buffer><expr> p
  \ denite#do_map('do_action', 'preview')
  nnoremap <silent><buffer><expr> i
  \ denite#do_map('open_filter_buffer')
  nnoremap <silent><buffer><expr> <C-o>
  \ denite#do_map('open_filter_buffer')
  nnoremap <silent><buffer><expr> v
  \ denite#do_map('do_action', 'vsplitswitch')
  nnoremap <silent><buffer><expr> s
  \ denite#do_map('do_action', 'splitswitch')
  nnoremap <silent><buffer><expr> t
  \ denite#do_map('do_action', 'tabswitch')
endfunction

" ------------------------------------
" CoC
" ------------------------------------
" Use tab for trigger completion with characters ahead and navigate.
" Use command ':verbose imap <tab>' to make sure tab is not mapped by other plugin.
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use <c-space> to trigger completion.
inoremap <silent><expr> <c-space> coc#refresh()

" Use <cr> to confirm completion, `<C-g>u` means break undo chain at current
" position. Coc only does snippet and additional edit on confirm.
" <cr> could be remapped by other vim plugin, try `:verbose imap <CR>`.
if exists('*complete_info')
  inoremap <expr> <cr> complete_info()["selected"] != "-1" ? "\<C-y>" : "\<C-g>u\<CR>"
else
  inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
endif

" Remap for rename current word
nmap <leader>rn <Plug>(coc-rename)

" Remap keys for gotos
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)
nmap <silent> co :<C-u>CocList outline<CR>

" Use K to show documentation in preview window
nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction

xmap <leader>f  <Plug>(coc-format-selected)
nmap <leader>f  <Plug>(coc-format-selected)
" Use <leader>x for convert visual selected code to snippet
xmap <leader>x  <Plug>(coc-convert-snippet)
