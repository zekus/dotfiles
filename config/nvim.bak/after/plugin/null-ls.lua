local null_ls = require("null-ls")
local on_attach = require("lsp").on_attach
local capabilities = require("lsp").capabilities

local sources = {
  null_ls.builtins.formatting.prettierd.with({
    filetypes = {
      "css", "json", "jsonc", "javascript", "typescript",
      "javascript.glimmer", "typescript.glimmer",
      "handlebars", "markdown"
    }
  }),
  null_ls.builtins.formatting.shfmt.with({
    args = { "-i", "1", "-filename", "$FILENAME" },
  }),
  null_ls.builtins.diagnostics.credo,
  --  null_ls.builtins.diagnostics.jsonlint,
  null_ls.builtins.diagnostics.shellcheck,
  null_ls.builtins.code_actions.shellcheck,
}

null_ls.setup({
  debug = true,
  sources = sources,
  on_attach = on_attach,
  capabilities = capabilities
})
