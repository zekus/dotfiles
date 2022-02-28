local on_attach = function(client, bufnr)
	vim.api.nvim_buf_set_option(bufnr, "omnifunc", "v:lua.lsp.omnifunc")

	-- autoformat on save
	if client.resolved_capabilities.document_formatting then
		vim.cmd("au BufWritePre <buffer> lua vim.lsp.buf.formatting_sync(nil, 1000)")
	end
end

local capabilities = require("cmp_nvim_lsp").update_capabilities(vim.lsp.protocol.make_client_capabilities())

local options = {
	on_attach = on_attach,
	capabilities = capabilities,
}

require("nvim-lsp-installer").on_server_ready(function(server)
	local status, custom_opts = pcall(require, string.format("lsp.%s", server.name))

	-- if there is some custom configuration,
	-- updates the default options
	if status == true then
		for k, v in pairs(custom_opts) do
			options[k] = v
		end
	end

	print(vim.inspect(options))

	server:setup(options)
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
	"   (TypeParameter)",
}
