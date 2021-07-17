local u = require 'utilities'

vim.g.mapleader = ','

u.map('', '<leader>c', '"+y') -- Copy to clipboard in normal, visual, select and operator modes

-- <Tab> to navigate the completion menu
u.map('i', '<S-Tab>', 'pumvisible() ? "\\<C-p>" : "\\<Tab>"', {expr = true})
u.map('i', '<Tab>', 'pumvisible() ? "\\<C-n>" : "\\<Tab>"', {expr = true})

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
u.map('', '<Leader>h', ':Telescope find_files<cr>')
u.map('', ';', ':Telescope buffers<cr>')
u.map('', '<space>/', ':Telescope live_grep<cr>')
u.map('', '<space>k', ':Telescope grep_string<cr>')

--- LSP (some are handled by lspsaga)
u.map('n','gD','<cmd>lua vim.lsp.buf.declaration()<cr>')
--u.map('n','gd','<cmd>lua vim.lsp.buf.definition()<cr>')
--u.map('n','gr','<cmd>lua vim.lsp.buf.references()<cr>')
u.map('n','gi','<cmd>lua vim.lsp.buf.implementation()<cr>')
u.map('n','gt','<cmd>lua vim.lsp.buf.type_definition()<cr>')
u.map('n','<leader>gw','<cmd>lua vim.lsp.buf.document_symbol()<cr>')
u.map('n','<leader>gW','<cmd>lua vim.lsp.buf.workspace_symbol()<cr>')
u.map('n','<leader>ah','<cmd>lua vim.lsp.buf.hover()<cr>')
u.map('n','<leader>af','<cmd>lua vim.lsp.buf.code_action()<cr>')
u.map('n','<leader>ee','<cmd>lua vim.lsp.util.show_line_diagnostics()<cr>')
u.map('n','<leader>ar','<cmd>lua vim.lsp.buf.rename()<cr>')
u.map('n','<leader>=', '<cmd>lua vim.lsp.buf.formatting()<cr>')
u.map('n','<leader>ai','<cmd>lua vim.lsp.buf.incoming_calls()<cr>')
u.map('n','<leader>ao','<cmd>lua vim.lsp.buf.outgoing_calls()<cr>')
