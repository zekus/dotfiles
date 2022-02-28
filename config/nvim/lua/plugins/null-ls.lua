local null_ls = require("null-ls")

local sources = {
	null_ls.builtins.formatting.prettier.with({
		filetypes = { "html", "yaml", "markdown" },
	}),
	null_ls.builtins.formatting.shfmt.with({
		args = { "-i", "1", "-filename", "$FILENAME" },
	}),
	null_ls.builtins.formatting.shellharden,
	null_ls.builtins.formatting.stylua,
	null_ls.builtins.diagnostics.credo,
	null_ls.builtins.diagnostics.jsonlint,
	null_ls.builtins.diagnostics.selene,
	null_ls.builtins.diagnostics.shellcheck,
	null_ls.builtins.code_actions.shellcheck,
}

require("null-ls").setup({
	debug = true,
	sources = sources,
	on_attach = function(client)
		if client.resolved_capabilities.document_formatting then
			vim.cmd("autocmd BufWritePre *.md lua vim.lsp.buf.formatting_sync(nil, 1000)")
			vim.cmd("autocmd BufWritePre *.json lua vim.lsp.buf.formatting_sync(nil, 1000)")
			vim.cmd("autocmd BufWritePre *.html lua vim.lsp.buf.formatting_sync(nil, 1000)")
			vim.cmd("autocmd BufWritePre *.yml lua vim.lsp.buf.formatting_sync(nil, 1000)")
			vim.cmd("autocmd BufWritePre *.sh lua vim.lsp.buf.formatting_sync(nil, 1000)")
		end
	end,
})
