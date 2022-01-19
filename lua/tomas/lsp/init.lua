local status_ok, _ = pcall(require, "lspconfig")
if not status_ok then
	return
end

require("tomas.lsp.lsp-installer")
require("tomas.lsp.handlers").setup()
require("tomas.lsp.null-ls")
