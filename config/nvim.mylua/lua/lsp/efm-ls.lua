local prettier = {formatCommand = "prettier --stdin-filepath ${INPUT}", formatStdin = true}

local eslint = {
  lintCommand = "./node_modules/.bin/eslint -f unix --stdin --stdin-filename ${INPUT}",
  lintIgnoreExitCode = true,
  lintStdin = true,
  lintFormats = {"%f:%l:%c: %m"},
  formatCommand = "./node_modules/.bin/eslint --fix-to-stdout --stdin --stdin-filename=${INPUT}",
  formatStdin = true
}

require('lspconfig').efm.setup {
  init_options = {documentFormatting = false, codeAction = false},
  filetypes = {"lua", "javascriptreact", "javascript", "typescript","typescriptreact", "html", "css", "json", "yaml", "markdown"},
  settings = {
    rootMarkers = {".git/"},
    languages = {
      lua = {
        {formatCommand = "lua-format -i", formatStdin = true},
      },
      javascript = {prettier, eslint},
      javascriptreact = {prettier, eslint},
      typescript = {prettier, eslint},
      typescriptreact = {prettier, eslint},
      html = {prettier},
      css = {prettier},
      json = {prettier},
      yaml = {prettier},
      markdown = {prettier},
    }
  }
}
