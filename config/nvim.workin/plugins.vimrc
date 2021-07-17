" Plugin Manager (Plug) autoinstall
if empty(glob('~/.config/nvim/autoload/plug.vim'))
  silent !curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs
        \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall
endif

call plug#begin('~/.config/nvim/plugged')

" start the luification with useful shortcuts
Plug 'norcalli/nvim.lua'

Plug 'tpope/vim-repeat'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-unimpaired'
Plug 'tpope/vim-commentary'
" Heuristically set indent settings
Plug 'tpope/vim-sleuth'
" formats tabular data
Plug 'godlygeek/tabular'
Plug 'Raimondi/delimitMate'
Plug 'svermeulen/vim-easyclip'
" create directory if it does not exist
Plug 'DataWraith/auto_mkdir'
" resize windows easily
Plug 'jimsei/winresizer'
Plug 'nathanaelkane/vim-indent-guides'
" Highlight trailing whitespaces
Plug 'bronson/vim-trailing-whitespace'
" run shell commands in background and output in quickfix window
Plug 'skywind3000/asyncrun.vim'
" colors, colors, colors and icons
Plug 'KeitaNakamura/neodark.vim'
Plug 'zacanger/angr.vim'
Plug 'kyazdani42/nvim-web-devicons'

Plug 'norcalli/nvim-base16.lua'
" status line
Plug 'hoob3rt/lualine.nvim'


" snippets collection - used by coc-snippets
Plug 'honza/vim-snippets'

" Polyglot
" --------------------------------------------------
" All the languages in one megapack
" --------------------------------------------------
Plug 'elixir-lang/vim-elixir'
Plug 'sheerun/vim-polyglot'
  let g:polyglot_disabled = ['elixir']

" CoC - Conquer Of Completition
" --------------------------------------------------
" Intellisense engine for vim8 & neovim,
" full language server protocol support as VSCode
" NOTE: solargraph is Ruby LS
" --------------------------------------------------
Plug 'neoclide/coc.nvim', {'branch': 'release'}
  let g:coc_global_extensions = [
        \ 'coc-elixir',
        \ 'https://github.com/hyhugh/coc-erlang_ls',
        \ 'coc-snippets',
        \ 'coc-json',
        \ 'coc-yaml',
        \ 'coc-solargraph',
        \ 'coc-git',
        \ 'coc-go',
        \ 'coc-tsserver',
        \ 'coc-eslint',
        \ 'coc-prettier',
        \ ]

  augroup mygroup
    autocmd!
    " Setup formatexpr specified filetype(s).
    autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
    " Update signature help on jump placeholder.
    autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
    autocmd FileType elixir setl formatprg=CocAction('format')
  augroup end

  " Add `:Format` command to format current buffer.
  command! -nargs=0 Format :call CocAction('format')

  " Add `:Fold` command to fold current buffer.
  command! -nargs=? Fold :call CocAction('fold', <f-args>)

" Git
" --------------------------------------------------
"  collection of git related plugins
" --------------------------------------------------
Plug 'tpope/vim-fugitive'
" Enable :Gbrowse => hub
Plug 'tpope/vim-rhubarb'
" Enable :Gbrowse => gitlab
Plug 'shumphrey/fugitive-gitlab.vim'
" A better merge tool for git
Plug 'samoshkin/vim-mergetool'

" NERDTree
" --------------------------------------------------
" the file explorer
" --------------------------------------------------
Plug 'scrooloose/nerdtree' | Plug 'jistr/vim-nerdtree-tabs'
  noremap <leader>n :NERDTreeToggle %<CR>
  " Show hidden files/directories
  let g:NERDTreeShowHidden = 1
  " Remove bookmarks and help text from NERDTree
  let g:NERDTreeMinimalUI = 1
  " Hide certain files and directories from NERDTree
  let NERDTreeIgnore=['^\.DS_Store$', '^tags$', '\.git$[[dir]]', '\.idea$[[dir]]', '\.sass-cache$', '\.pyc$', '\.pyo$', '\.rbc$', '\.rbo$', '\.class$', '\.o$', '\~$']

" Vim-Test
" --------------------------------------------------
" test runner inside vim
" --------------------------------------------------
Plug 'janko-m/vim-test'
  let test#strategy = 'neoterm'
  let g:test#runner_commands = ['Minitest', 'Rspec', 'Cucumber']
  let test#ruby#rspec#executable = 'rspec'
  let test#ruby#minitest#executable = 'rake test'

" Neoterm
" --------------------------------------------------
" make the neovim :terminal awesome
" --------------------------------------------------
Plug 'kassio/neoterm'
  let g:neoterm_default_mod = 'belowright'
  let g:neoterm_automap_keys = ',tt'
  let g:neoterm_repl_ruby = 'pry'
  let g:neoterm_shell = 'zsh'
  let g:neoterm_clear_cmd = "clear; printf '=%.0s' {1..80}; clear"
  let g:neoterm_open_in_all_tabs = 1
  let g:neoterm_term_per_tab = 1
  let g:neoterm_keep_term_open = 0
  let g:neoterm_autoscroll = 1

" Denite
" --------------------------------------------------
" GOD fuzzy finder
" --------------------------------------------------
Plug 'Shougo/denite.nvim'
  " dependecy to fuzzy search faster
  Plug 'raghur/fruzzy', {'do': { -> fruzzy#install()}}

call plug#end()

" Denite
" --------------------------------------------------
" GOD fuzzy finder
" --------------------------------------------------
let g:fruzzy#usenative = 1
" Use ripgrep for searching current directory for files
" By default, ripgrep will respect rules in .gitignore
"   --files: Print each file that would be searched (but don't search)
"   --glob:  Include or exclues files for searching that match the given glob
"            (aka ignore .git files)
"
call denite#custom#var('file/rec', 'command', ['rg', '--files', '--glob', '!.git'])

" Use ripgrep in place of "grep"
call denite#custom#var('grep', 'command', ['rg'])

" Custom options for ripgrep
"   --vimgrep:  Show results with every match on it's own line
"   --hidden:   Search hidden directories and files
"   --heading:  Show the file name above clusters of matches from each file
"   --S:        Search case insensitively if the pattern is all lowercase
call denite#custom#var('grep', 'default_opts', ['--hidden', '--vimgrep', '--heading', '-S'])

" Recommended defaults for ripgrep via Denite docs
call denite#custom#var('grep', 'recursive_opts', [])
call denite#custom#var('grep', 'pattern_opt', ['--regexp'])
call denite#custom#var('grep', 'separator', ['--'])
call denite#custom#var('grep', 'final_opts', [])

" Remove date from buffer list
call denite#custom#var('buffer', 'date_format', '')

" Custom options for Denite
"   auto_resize             - Auto resize the Denite window height automatically.
"   prompt                  - Customize denite prompt
"   direction               - Specify Denite window direction as directly below current pane
"   winminheight            - Specify min height for Denite window
"   highlight_mode_insert   - Specify h1-CursorLine in insert mode
"   prompt_highlight        - Specify color of prompt
"   highlight_matched_char  - Matched characters highlight
"   highlight_matched_range - matched range highlight
let s:denite_options = {'default' : {
\ 'auto_resize': 1,
\ 'split': 'floating',
\ 'filter_split_direction': 'floating',
\ 'start_filter': 1,
\ 'source_names': 'short',
\ 'prompt': 'λ ',
\ 'floating_preview': 1
\ }}

" Loop through denite options and enable them
function! s:profile(opts) abort
  for l:fname in keys(a:opts)
    for l:dopt in keys(a:opts[l:fname])
      call denite#custom#option(l:fname, l:dopt, a:opts[l:fname][l:dopt])
    endfor
  endfor
endfunction

" lualine
" ==================================================
lua << EOF
require('lualine').setup {
  options = {theme = 'auto'}
}
EOF
