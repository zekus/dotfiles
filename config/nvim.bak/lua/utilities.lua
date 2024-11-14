local Utilities = {}

-- Helps setting a keymap with some default options.
-- Example:
--
--    u.map('', '<leader>ra', ':TestSuite<cr>')
function Utilities.map(mode, lhs, rhs, opts)
  local options = {noremap = true}
  if opts then options = vim.tbl_extend('force', options, opts) end
  vim.api.nvim_set_keymap(mode, lhs, rhs, options)
end

return Utilities
