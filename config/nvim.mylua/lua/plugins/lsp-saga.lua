local u = require 'utilities'

require('lspsaga').init_lsp_saga()

-- lsp provider to find the cursor word definition and reference
u.map('n', 'gh', '<cmd>lua require(\'lspsaga.provider\').lsp_finder()<cr>', {noremap = true, silent = true})

-- code action
u.map('n', '<leader>ca', '<cmd>lua require(\'lspsaga.codeaction\').code_action()<cr>', {noremap = true, silent = true})
u.map('v', '<leader>ca', ':<C-U>lua require(\'lspsaga.codeaction\').range_code_action()<cr>', {noremap = true, silent = true})

-- show hover doc
u.map('n', 'K', '<cmd>lua require(\'lspsaga.hover\').render_hover_doc()<cr>', {noremap = true, silent = true})

-- scroll down hover doc or scroll in definition preview
u.map('n', '<C-f>', '<cmd>lua require(\'lspsaga.action\').smart_scroll_with_saga(1)<cr>', {noremap = true, silent = true})

-- scroll up hover doc
u.map('n', '<C-b>', '<cmd>lua require(\'lspsaga.action\').smart_scroll_with_saga(-1)<cr>', {noremap = true, silent = true})

-- show signature help
u.map('n', 'gs', '<cmd>lua require(\'lspsaga.signaturehelp\').signature_help()<cr>', {noremap = true, silent = true})

-- show signature help
u.map('n', 'gs', '<cmd>lua require(\'lspsaga.signaturehelp\').signature_help()<cr>', {noremap = true, silent = true})

-- rename
u.map('n', 'gR', '<cmd>lua require(\'lspsaga.rename\').rename()<cr>', {noremap = true, silent = true})

-- preview definition - not working with Elixir
u.map('n', 'gP', '<cmd>lua require\'lspsaga.provider\'.preview_definition()<cr>', {noremap = true, silent = true})

-- show diagnostic
u.map('n', '<leader>cd', '<cmd>lua require\'lspsaga.diagnostic\'.show_line_diagnostics()<cr>', {noremap = true, silent = true})

-- only show diagnostic if cursor is over the area
u.map('n', '<leader>cc', '<cmd>lua require\'lspsaga.diagnostic\'.show_cursor_diagnostics()<cr>', {noremap = true, silent = true})

-- jump diagnostic
u.map('n', '[e', '<cmd>lua require\'lspsaga.diagnostic\'.lsp_jump_diagnostic_prev()<cr>', {noremap = true, silent = true})
u.map('n', ']e', '<cmd>lua require\'lspsaga.diagnostic\'.lsp_jump_diagnostic_next()<cr>', {noremap = true, silent = true})

-- float terminal also you can pass the cli command in open_float_terminal function
u.map('n', '<A-d>', '<cmd>lua require(\'lspsaga.floaterm\').open_float_terminal()<cr>', {noremap = true, silent = true}) -- or open_float_terminal('lazygit')<CR>
u.map('t', '<A-d>', '<C-\\><C-n>:lua require(\'lspsaga.floaterm\').close_float_terminal()<cr>', {noremap = true, silent = true})
