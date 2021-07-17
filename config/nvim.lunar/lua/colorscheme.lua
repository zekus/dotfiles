vim.cmd('let g:nvcode_termcolors=256')


local base16 = require 'base16'
base16(base16.themes[vim.env.BASE16_THEME or "3024"], true)
