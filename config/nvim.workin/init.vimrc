let g:python3_host_prog = '/Users/antoniolorusso/.asdf/installs/python/3.8.4/bin/python'
let python_highlight_all = 1
let python_version_2 = 0

set encoding=utf-8

filetype plugin indent on " Enable filetype-specific indenting and plugins
syntax on                 " Enable syntax highlighting
set hlsearch
" show the ruler after the textwidth
set colorcolumn=+1

" fix FileTypes
" ---------------------------------------------------------------------

au FileType ruby,eruby,yaml,javascript,html,css set ai ts=2 sw=2 sts=2 tw=80 ff=unix et
au FileType php,python set ai ts=4 sw=4 sts=4 tw=80 ff=unix et
" Enter insert mode automatically when editing git commit messages
au FileType gitcommit startinsert
" When loading text files, wrap them and don't split up words.
au BufNewFile,BufRead *.txt setlocal wrap lbr
" Make sure all markdown files have the correct filetype
au BufRead,BufNew,BufNewFile *.{md,markdown,mdown,mkd,mkdn,txt} set ft=markdown
" Set the Ruby filetype for a number of common Ruby files without .rb
au BufRead,BufNewFile {Berksfile,Vagrantfile,Procfile,config.ru,*.god,*.arb,*.pill} set ft=ruby
" Treat JSON files like JSON
au BufNewFile,BufRead {*.json,*.jsm} set ft=json
" Recognize CoffeeScript
au BufNewFile,BufRead *.coffee set ft=coffee
" zsh themes are sh files
" Added Javascript Template Support
au BufNewFile,BufRead *.ejs set ft=jst

" When editing a file, always jump to the last known cursor position.
" Don't do it when the position is invalid or when inside an event handler
" (happens when dropping a file on gvim).
au BufReadPost *
                  \ if line("'\"") > 1 && line("'\"") <= line("$") |
                  \   exe "normal! g'\"" |
                  \ endif

" GLOBAL COMMANDS
" ---------------------------------------------------------------------

command! Q q " Bind :Q to :q
command! Qall qall
" just save, damn it
command! W w
" Rails commands
command! Troutes :T rake routes
command! -nargs=+ Troute :T rake routes | grep <args>
command! Tmigrate :T rake db:migrate
" END COMMANDS

let g:indent_guides_start_level = 2

" TextEdit might fail if hidden is not set.
set hidden
" Some servers have issues with backup files, see #649.
set nobackup
set nowritebackup
" Give more space for displaying messages.
set cmdheight=2
" Having longer updatetime (default is 4000 ms = 4 s) leads to noticeable
" delays and poor user experience.
set updatetime=300
" Don't pass messages to |ins-completion-menu|.
set shortmess+=c

set backspace=indent,eol,start " allow backspacing over everything in insert mode
set history=500		" keep 500 lines of command line history
set ruler		" show the cursor position all the time
set showcmd		" display incomplete commands
set showmatch
set nowrap
set directory=~/.tmp " Don't clutter my dirs up with swp and tmp files
set autoread
set wmh=0
set viminfo+=!
set guioptions-=T
set et
set sw=2
set smarttab
set noincsearch
set ignorecase smartcase
set laststatus=2  " Always show status line.
set relativenumber
set number
set gdefault " assume the /g flag on :s substitutions to replace all matches in a line
set autoindent " always set autoindenting on
set cursorline
set cursorcolumn
" Use ag instead of grep
set grepprg=rg
set shiftround " When at 3 spaces and I hit >>, go to 4, not 5.
set nofoldenable " Say no to code folding...
set foldmethod=syntax


" Disable output and VCS files
set wildignore+=*.o,*.out,*.obj,.git,*.rbc,*.rbo,*.class,.svn,*.gem
" Disable archive files
set wildignore+=*.zip,*.tar.gz,*.tar.bz2,*.rar,*.tar.xz
" Disable temp and backup files
set wildignore+=*.swp,*~,._*
set wildignore+=*/tmp/*,*.pyc,*.so,*.swp,*.zip,*/log/*,*/vendor/bundler/*,*/build/*,*/vendor/Pods/*,*/public/uploads/*,*/node_modules/*
" Ignore simplecov
set wildignore+=*/coverage/*

" Don't add the comment prefix when I hit enter or o/O on a comment line.
set formatoptions-=or
" Don't wait so long for the next keypress (particularly in ambigious Leader situations).
set timeoutlen=500
" the mode is shown by the status line now
set noshowmode
