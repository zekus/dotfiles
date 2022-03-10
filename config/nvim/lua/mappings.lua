local u = require 'utilities'
local opts = { noremap = true, silent = true }

vim.g.mapleader = ','

u.map('', '<leader>c', '"+y') -- Copy to clipboard in normal, visual, select and operator modes

-- <Tab> to navigate the completion menu
u.map('i', '<S-Tab>', 'pumvisible() ? "\\<C-b>" : "\\<Tab>"', {expr = true})
u.map('i', '<Tab>', 'pumvisible() ? "\\<C-f>" : "\\<Tab>"', {expr = true})

u.map('n', '<C-l>', '<cmd>noh<CR>') -- Clear highlights
u.map('n', '<leader>o', 'm`o<Esc>``') -- Insert a newline in normal mode

-- vim-test integration to run tests
u.map('', '<leader>ra', ':TestSuite<cr>')
u.map('', '<leader>rf', ':TestFile<cr>')
u.map('', '<leader>rc', ':TestNearest<cr>')
u.map('', '<leader>rr', ':TestLast<cr>')

-- clear trailing white spaces
u.map('', '<leader>rw', ':%s/\\s\\+$//e<cr>')

-- Save!
u.map('', '<C-s>', '<esc>:w<cr>')
u.map('i', '<C-s>', '<esc>:w<cr>')

-- Telescope
--
u.map('', '<Leader>h', ':Telescope find_files<cr>')
u.map('', ';', ':Telescope buffers<cr>')
u.map('', '<space>/', ':Telescope live_grep<cr>')
u.map('', '<space>k', ':Telescope grep_string<cr>')

-- LSP (some are handled by lspsaga)
--
u.map('n','gD','<cmd>lua vim.lsp.buf.declaration()<cr>')
u.map('n','gd','<cmd>lua vim.lsp.buf.definition()<cr>')
u.map('n','gr','<cmd>lua vim.lsp.buf.references()<cr>')
u.map('n','gi','<cmd>lua vim.lsp.buf.implementation()<cr>')
u.map('n','gt','<cmd>lua vim.lsp.buf.type_definition()<cr>')

u.map('n','<leader>gw','<cmd>lua vim.lsp.buf.document_symbol()<cr>')
u.map('n','<leader>gW','<cmd>lua vim.lsp.buf.workspace_symbol()<cr>')
u.map('n','K','<cmd>lua vim.lsp.buf.hover()<cr>')
u.map('n','<leader>af','<cmd>lua vim.lsp.buf.code_action()<cr>')
u.map('n','<leader>ee','<cmd>lua vim.lsp.util.show_line_diagnostics()<cr>')
u.map('n','<leader>ar','<cmd>lua vim.lsp.buf.rename()<cr>')
u.map('n','<leader>=', '<cmd>lua vim.lsp.buf.formatting()<cr>')
u.map('n','<leader>ai','<cmd>lua vim.lsp.buf.incoming_calls()<cr>')
u.map('n','<leader>ao','<cmd>lua vim.lsp.buf.outgoing_calls()<cr>')

-- BarBar
--
-- Move to previous/next
u.map('n', '<A-,>', ':BufferPrevious<CR>', opts)
u.map('n', '<A-.>', ':BufferNext<CR>', opts)
-- Re-order to previous/next
u.map('n', '<A-<>', ':BufferMovePrevious<CR>', opts)
u.map('n', '<A->>', ' :BufferMoveNext<CR>', opts)
-- Goto buffer in position...
u.map('n', '<A-1>', ':BufferGoto 1<CR>', opts)
u.map('n', '<A-2>', ':BufferGoto 2<CR>', opts)
u.map('n', '<A-3>', ':BufferGoto 3<CR>', opts)
u.map('n', '<A-4>', ':BufferGoto 4<CR>', opts)
u.map('n', '<A-5>', ':BufferGoto 5<CR>', opts)
u.map('n', '<A-6>', ':BufferGoto 6<CR>', opts)
u.map('n', '<A-7>', ':BufferGoto 7<CR>', opts)
u.map('n', '<A-8>', ':BufferGoto 8<CR>', opts)
u.map('n', '<A-9>', ':BufferGoto 9<CR>', opts)
u.map('n', '<A-0>', ':BufferLast<CR>', opts)
-- Close buffer
u.map('n', '<A-c>', ':BufferClose<CR>', opts)
-- Magic buffer-picking mode
u.map('n', '<A-p>', ':BufferPick<CR>', opts)
