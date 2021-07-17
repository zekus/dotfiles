require('lspconfig').elixir.setup {
    settings = {}
}

-- needed for the LSP to recognize elixir files
vim.cmd([[
  au BufRead,BufNewFile *.ex,*.exs set filetype=elixir
  au BufRead,BufNewFile *.eex,*.leex,*.sface set filetype=eelixir
  au BufRead,BufNewFile mix.lock set filetype=elixir
]])
