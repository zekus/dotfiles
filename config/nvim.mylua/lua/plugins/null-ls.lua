local null_ls = require("null-ls")

local sources = {
  null_ls.builtins.formatting.prettier.with({
    filetypes = { "html", "json", "yaml", "markdown" },
  })
}

require("null-ls").config({ sources = sources  })

require("lspconfig")["null-ls"].setup({
  on_attach = function(client)
    if client.resolved_capabilities.document_formatting then
        vim.cmd("autocmd BufWritePre *.md lua vim.lsp.buf.formatting_sync(nil, 100)")
    end
  end
})
