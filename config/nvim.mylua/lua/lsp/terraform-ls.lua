require("lspconfig").terraformls.setup {
  on_attach = function(client)
    if client.resolved_capabilities.document_formatting then
        vim.cmd("autocmd BufWritePre *.tf lua vim.lsp.buf.formatting()")
    end
  end
}
