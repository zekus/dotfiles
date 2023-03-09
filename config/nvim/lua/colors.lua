-- uncomment the following if you want to set nvim colors to the
-- theme managed by base16-shell in the terminal
-- it will make nvim and zsh use the same theme
--
--local base16 = require 'base16'
--base16(base16.themes[vim.env.BASE16_THEME or "3024"], true)

-- Tokio theme
--vim.cmd [[colorscheme tokyonight-storm]]

-- Rose Pine theme
require('rose-pine').setup({
  variant = 'moon',
  dark_variant = 'moon',
})
vim.cmd('colorscheme rose-pine')
