require('lspconfig').elixir.setup {
    settings = {}
}

-- needed for the LSP to recognize elixir files
vim.cmd([[
  au BufRead,BufNewFile *.ex,*.exs set filetype=elixir
  au BufRead,BufNewFile *.eex,*.leex,*.sface set filetype=eelixir
  au BufRead,BufNewFile mix.lock set filetype=elixir
]])

require("lspconfig")["elixir"].setup({
  on_attach = function(client)
    if client.resolved_capabilities.document_formatting then
        vim.cmd("autocmd BufWritePre *.ex,*.exs,*.eex,*.leex,*.sface,mix.lock lua vim.lsp.buf.formatting_sync(nil, 100)")
    end
  end
})
