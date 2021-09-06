require('lspconfig').lua.setup {
  settings = {
    Lua = {
      diagnostics = {
        globals = {'vim'}
      }
    }
  }
}

require("lspconfig")["lua"].setup({
  on_attach = function(client)
    if client.resolved_capabilities.document_formatting then
        vim.cmd("autocmd BufWritePre *.lua lua vim.lsp.buf.formatting_sync(nil, 100)")
    end
  end
})
