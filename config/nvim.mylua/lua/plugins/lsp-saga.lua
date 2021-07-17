local saga = require 'lspsaga'

saga.init_lsp_saga()

local function map(mode, lhs, rhs, opts)
  local options = {noremap = true}
  if opts then
    options = vim.tbl_extend('force', options, opts)
  end

  vim.api.nvim_set_keymap(mode, lhs, rhs, options)
end

-- lsp provider to find the cursor word definition and reference
map('n', 'gh', '<cmd>lua require(\'lspsaga.provider\').lsp_finder()<cr>', {noremap = true, silent = true})

-- code action
map('n', '<leader>ca', '<cmd>lua require(\'lspsaga.codeaction\').code_action()<cr>', {noremap = true, silent = true})
map('v', '<leader>ca', ':<C-U>lua require(\'lspsaga.codeaction\').range_code_action()<cr>', {noremap = true, silent = true})

-- show hover doc
map('n', 'K', '<cmd>lua require(\'lspsaga.hover\').render_hover_doc()<cr>', {noremap = true, silent = true})

-- scroll down hover doc or scroll in definition preview
map('n', '<C-f>', '<cmd>lua require(\'lspsaga.action\').smart_scroll_with_saga(1)<cr>', {noremap = true, silent = true})
-- scroll up hover doc
map('n', '<C-b>', '<cmd>lua require(\'lspsaga.action\').smart_scroll_with_saga(-1)<cr>', {noremap = true, silent = true})

-- show signature help
map('n', 'gs', '<cmd>lua require(\'lspsaga.signaturehelp\').signature_help()<cr>', {noremap = true, silent = true})

-- show signature help
map('n', 'gs', '<cmd>lua require(\'lspsaga.signaturehelp\').signature_help()<cr>', {noremap = true, silent = true})

-- rename
map('n', 'gr', '<cmd>lua require(\'lspsaga.rename\').rename()<cr>', {noremap = true, silent = true})

-- preview definition
map('n', 'gd', '<cmd>lua require\'lspsaga.provider\'.preview_definition()<cr>', {noremap = true, silent = true})

-- show diagnostic
map('n', '<leader>cd', '<cmd>lua require\'lspsaga.diagnostic\'.show_line_diagnostics()<cr>', {noremap = true, silent = true})

-- only show diagnostic if cursor is over the area
map('n', '<leader>cc', '<cmd>lua require\'lspsaga.diagnostic\'.show_cursor_diagnostics()<cr>', {noremap = true, silent = true})

-- jump diagnostic
map('n', '[e', '<cmd>lua require\'lspsaga.diagnostic\'.lsp_jump_diagnostic_prev()<cr>', {noremap = true, silent = true})
map('n', ']e', '<cmd>lua require\'lspsaga.diagnostic\'.lsp_jump_diagnostic_next()<cr>', {noremap = true, silent = true})

-- float terminal also you can pass the cli command in open_float_terminal function
map('n', '<A-d>', '<cmd>lua require(\'lspsaga.floaterm\').open_float_terminal()<cr>', {noremap = true, silent = true}) -- or open_float_terminal('lazygit')<CR>
map('t', '<A-d>', '<C-\\><C-n>:lua require(\'lspsaga.floaterm\').close_float_terminal()<cr>', {noremap = true, silent = true})
