require('nvim-treesitter.configs').setup {
  ensure_installed = {},
  sync_install = false,
  auto_install = true,
  ignore_install = {},
  highlight = { enable = true },
  context_commentstring = { -- commentstring plugin
    enable = true,
    config = {
      elixir = '# %s'
    }
  },
  indent = { enable = true },
  autotag = { enable = true },
  autopairs = { enable = true }, -- nvim-autopairs plugin
}
