local Lsp = {}
local augroup = vim.api.nvim_create_augroup("LspFormatting", {})

Lsp.on_attach = function(client, bufnr)
  vim.api.nvim_buf_set_option(bufnr, "omnifunc", "v:lua.lsp.omnifunc")

  -- Format on save
  if client.supports_method("textDocument/formatting") then
    vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
    vim.api.nvim_create_autocmd("BufWritePre", {
      group = augroup,
      buffer = bufnr,
      callback = function()
        vim.lsp.buf.format({ bufnr = bufnr, timeout_ms = 5000 })
      end,
    })
  end

  require('cmp_nvim_lsp').default_capabilities()
end

Lsp.capabilities = vim.lsp.protocol.make_client_capabilities()

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
  "   (TypeParameter)",
}


require("mason").setup {
  ui = {
    icons = {
      package_installed = "✓"
    }
  }
}

require("mason-lspconfig").setup {
  ensure_installed = { "lua_ls" },
}

local lspconfig = require("lspconfig")
local runtime_path = vim.split(package.path, ";", {})

table.insert(runtime_path, "lua/?.lua")
table.insert(runtime_path, "lua/?/init.lua")

require("mason-lspconfig").setup_handlers({
  function(server_name) -- default handler (optional)
    require("lspconfig")[server_name].setup {
      on_attach = Lsp.on_attach,
      capabilities = Lsp.capabilities
    }
  end,
  -- Next, you can provide targeted overrides for specific servers.

  ["elixirls"] = function()
    lspconfig.elixirls.setup {
      on_attach = Lsp.on_attach,
      capabilities = Lsp.capabilities,
      settings = {
        dialyzerEnabled = true,
        fetchDeps = true,
        enableTestLenses = true,
        suggestSpecs = true,
      }
    }
  end,

  ["lua_ls"] = function()
    lspconfig.lsp_ls.setup {
      on_attach = Lsp.on_attach,
      capabilities = Lsp.capabilities,
      settings = {
        Lua = {
          runtime = {
            -- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
            version = "LuaJIT",
            -- Setup your lua path
            path = vim.split(package.path, ";", {}),
          },
          diagnostics = {
            -- Get the language server to recognize the `vim` global
            globals = { 'vim' },
          },
          workspace = {
            -- Make the server aware of Neovim runtime files
            library = {
              [vim.fn.expand("$VIMRUNTIME/lua")] = true,
              [vim.fn.expand("$VIMRUNTIME/lua/vim/lsp")] = true,
            },
            -- library = vim.api.nvim_get_runtime_file("", true),
          },
        },
      },
    }
  end,
})

return Lsp
