vim.opt.expandtab = true -- Use spaces instead of tabs
vim.opt.ignorecase = true -- Ignore case
vim.opt.joinspaces = false -- No double spaces with join
vim.opt.list = true -- Show some invisible characters
vim.opt.number = true -- Show line numbers
vim.opt.relativenumber = true -- Relative line numbers
vim.opt.scrolloff = 4 -- Lines of context
vim.opt.shiftround = true -- Round indent
vim.opt.shiftwidth = 2 -- Size of an indent
vim.opt.sidescrolloff = 8 -- Columns of context
vim.opt.smartcase = true -- Do not ignore case with capitals
vim.opt.smartindent = true -- Insert indents automatically
vim.opt.splitbelow = true -- Put new windows below current
vim.opt.splitright = true -- Put new windows right of current
vim.opt.tabstop = 2 -- Number of spaces tabs count for
vim.opt.termguicolors = true -- True color support
vim.opt.wrap = false -- Disable line wrap
vim.opt.completeopt = "menuone,noselect" -- Completion menu
vim.opt.fileencoding = "utf-8" -- The encoding written to file
vim.opt.cursorline = true -- Enable highlighting of the current line
vim.opt.showtabline = 2 -- Always show tabs
vim.opt.showmode = false -- We don't need to see things like -- INSERT -- anymore
vim.opt.backup = false -- This is recommended by coc
vim.opt.writebackup = false -- This is recommended by coc
vim.opt.signcolumn = "yes" -- Always show the signcolumn, otherwise it would shift the text each time
vim.opt.hidden = true -- Required to keep multiple buffers open multiple buffers
vim.opt.title = true
vim.opt.titlestring="%<%F%=%l/%L - nvim"
vim.opt.wrap = false
vim.opt.cmdheight = 2 -- More space for displaying messages
vim.opt.conceallevel = 0 -- So that I can see `` in markdown files
vim.opt.updatetime = 300 -- Faster completion

vim.cmd('set iskeyword+=-') -- treat dash separated words as a word text object"
vim.cmd('set shortmess+=c') -- Don't pass messages to |ins-completion-menu|.
vim.cmd('set inccommand=split') -- Make substitution work in realtime
TERMINAL = vim.fn.expand('$TERMINAL')
vim.cmd('let &titleold="'..TERMINAL..'"')
vim.cmd('set whichwrap+=<,>,[,],h,l') -- move to next line with theses keys
vim.cmd('set colorcolumn=99999') -- fix indentline for now
vim.cmd('set ts=2') -- Insert 2 spaces for a tab
vim.cmd('set sw=2') -- Change the number of space characters inserted for indentation

-- Format on save!
-- TODO: move each to an on_attach function for each specific lsp configuration
vim.cmd([[
    autocmd BufWritePre *.lua lua vim.lsp.buf.formatting_sync(nil, 100)
    autocmd BufWritePre *.ex,*.exs,*.eex,*.leex,*.sface,mix.lock lua vim.lsp.buf.formatting_sync(nil, 100)
]])

vim.cmd('au TextYankPost * lua vim.highlight.on_yank {on_visual = false}') -- disabled in visual mode
