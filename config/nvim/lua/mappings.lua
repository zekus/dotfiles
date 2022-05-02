local opts = { noremap = true, silent = true }

vim.g.mapleader = ','

vim.keymap.set('', '<leader>c', '"+y') -- Copy to clipboard in normal, visual, select and operator modes

vim.keymap.set('n', '<C-l>', '<cmd>noh<CR>') -- Clear highlights
vim.keymap.set('n', '<leader>o', 'm`o<Esc>``') -- Insert a newline in normal mode

-- vim-test integration to run tests
vim.keymap.set('', '<leader>ra', ':TestSuite<cr>')
vim.keymap.set('', '<leader>rf', ':TestFile<cr>')
vim.keymap.set('', '<leader>rc', ':TestNearest<cr>')
vim.keymap.set('', '<leader>rr', ':TestLast<cr>')

-- clear trailing white spaces
vim.keymap.set('', '<leader>rw', ':%s/\\s\\+$//e<cr>')

-- Save!
vim.keymap.set('', '<C-s>', '<esc>:w<cr>')
vim.keymap.set('i', '<C-s>', '<esc>:w<cr>')

-- Telescope
--
vim.keymap.set('', '<Leader>h', ':Telescope find_files<cr>')
vim.keymap.set('', ';', ':Telescope buffers<cr>')
vim.keymap.set('', '<space>/', ':Telescope live_grep<cr>')
vim.keymap.set('', '<space>k', ':Telescope grep_string<cr>')

-- LSP (some are handled by lspsaga)
--
vim.keymap.set('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<cr>')
vim.keymap.set('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<cr>')
vim.keymap.set('n', 'gr', '<cmd>lua vim.lsp.buf.references()<cr>')
vim.keymap.set('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<cr>')
vim.keymap.set('n', 'gt', '<cmd>lua vim.lsp.buf.type_definition()<cr>')
vim.keymap.set('n', 'fs', '<cmd>lua vim.lsp.buf.formatting_seq_sync()<cr>')
vim.keymap.set('n', 'do', '<cmd>lua vim.diagnostic.open_float()<cr>')
-- run the codelens under the cursor
vim.keymap.set('n', '<space>r', vim.lsp.codelens.run)

vim.keymap.set('n', '<leader>gw', '<cmd>lua vim.lsp.buf.document_symbol()<cr>')
vim.keymap.set('n', '<leader>gW', '<cmd>lua vim.lsp.buf.workspace_symbol()<cr>')
vim.keymap.set('n', 'K', '<cmd>lua vim.lsp.buf.hover()<cr>')
vim.keymap.set('n', '<leader>af', '<cmd>lua vim.lsp.buf.code_action()<cr>')
vim.keymap.set('n', '<leader>ee', '<cmd>lua vim.lsp.util.show_line_diagnostics()<cr>')
vim.keymap.set('n', '<leader>ar', '<cmd>lua vim.lsp.buf.rename()<cr>')
vim.keymap.set('n', '<leader>=', '<cmd>lua vim.lsp.buf.formatting()<cr>')
vim.keymap.set('n', '<leader>ai', '<cmd>lua vim.lsp.buf.incoming_calls()<cr>')
vim.keymap.set('n', '<leader>ao', '<cmd>lua vim.lsp.buf.outgoing_calls()<cr>')

-- BarBar
--
-- Move to previous/next
vim.keymap.set('n', '<A-,>', ':BufferPrevious<CR>', opts)
vim.keymap.set('n', '<A-.>', ':BufferNext<CR>', opts)
-- Re-order to previous/next
vim.keymap.set('n', '<A-<>', ':BufferMovePrevious<CR>', opts)
vim.keymap.set('n', '<A->>', ' :BufferMoveNext<CR>', opts)
-- Goto buffer in position...
vim.keymap.set('n', '<A-1>', ':BufferGoto 1<CR>', opts)
vim.keymap.set('n', '<A-2>', ':BufferGoto 2<CR>', opts)
vim.keymap.set('n', '<A-3>', ':BufferGoto 3<CR>', opts)
vim.keymap.set('n', '<A-4>', ':BufferGoto 4<CR>', opts)
vim.keymap.set('n', '<A-5>', ':BufferGoto 5<CR>', opts)
vim.keymap.set('n', '<A-6>', ':BufferGoto 6<CR>', opts)
vim.keymap.set('n', '<A-7>', ':BufferGoto 7<CR>', opts)
vim.keymap.set('n', '<A-8>', ':BufferGoto 8<CR>', opts)
vim.keymap.set('n', '<A-9>', ':BufferGoto 9<CR>', opts)
vim.keymap.set('n', '<A-0>', ':BufferLast<CR>', opts)
-- Close buffer
vim.keymap.set('n', '<A-c>', ':BufferClose<CR>', opts)
-- Magic buffer-picking mode
vim.keymap.set('n', '<A-p>', ':BufferPick<CR>', opts)
