" Colorscheme
set termguicolors

" set the airline theme as the vim theme
let g:airline_theme=join(split(get(g:, 'colors_name', 'default'), "-"), "_")

lua << EOF
nvim = require 'nvim'
local base16 = require 'base16'
base16(base16.themes[nvim.env.BASE16_THEME or "3024"], true)
EOF
