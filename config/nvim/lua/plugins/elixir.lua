vim.cmd [[au BufWritePre *.ex,*.exs,*.eex,*.leex,*.sface,mix.lock set filetype=elixir"]]

local elixir = require("elixir")
local lsp = require("lsp")

local elixir_on_attach = function(client, bufnr)
  local map_opts = { buffer = true, noremap = true }

  -- remove the pipe operator
  vim.keymap.set("n", "<space>fp", ":ElixirFromPipe<cr>", map_opts)
  -- add the pipe operator
  vim.keymap.set("n", "<space>tp", ":ElixirToPipe<cr>", map_opts)
  vim.keymap.set("v", "<space>em", ":ElixirExpandMacro<cr>", map_opts)

  -- run the global function defined in lsp.lua
  return lsp.on_attach(client, bufnr)
end

elixir.setup({
  settings = elixir.settings({
    dialyzerEnabled = true,
    fetchDeps = true,
    enableTestLenses = true,
    suggestSpecs = true,
  }),

  on_attach = elixir_on_attach,

  -- capabilities are defined in lsp.lua
  capabilities = lsp.capabilities
})
