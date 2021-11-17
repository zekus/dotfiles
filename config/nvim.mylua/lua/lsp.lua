local on_attach = function(client, bufnr)
  vim.api.nvim_buf_set_option(bufnr, "omnifunc", "v:lua.lsp.omnifunc")

  -- autoformat on save
  if client.resolved_capabilities.document_formatting then
    vim.cmd("au BufWritePre <buffer> lua vim.lsp.buf.formatting_sync(nil, 1000)")
  end
end

local default_options = {
  on_attach = on_attach
}

require("nvim-lsp-installer").on_server_ready(function (server)
  local status, opts = pcall(require, string.format("lsp.%s", server.name))

  if not status then
    opts = default_options
  end

  -- can we merge the default options?
  server:setup(opts)
end)

-- symbols for autocomplete
vim.lsp.protocol.CompletionItemKind = {
    "   (Text) ",
    "   (Method)",
    "   (Function)",
    "   (Constructor)",
    " ﴲ  (Field)",
    "[] (Variable)",
    "   (Class)",
    " ﰮ  (Interface)",
    "   (Module)",
    " 襁 (Property)",
    "   (Unit)",
    "   (Value)",
    " 練 (Enum)",
    "   (Keyword)",
    "   (Snippet)",
    "   (Color)",
    "   (File)",
    "   (Reference)",
    "   (Folder)",
    "   (EnumMember)",
    " ﲀ  (Constant)",
    " ﳤ  (Struct)",
    "   (Event)",
    "   (Operator)",
    "   (TypeParameter)"
}
