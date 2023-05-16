local mason_ok, mason = pcall(require, "mason")
if not mason_ok then
  return
end

mason.setup({
  ui = {
    icons = {
      package_installed = "✓"
    }
  }
})

local status_ok, lsp_installer = pcall(require, "mason-lspconfig")
if not status_ok then
	return
end

local lspconfig = require("lspconfig")

local servers = {
	"clangd",
	"gopls",
	"jsonls",
  "lua_ls",
	"pyright",
	"terraformls",
	"tsserver",
	"yamlls",
}

lsp_installer.setup({
	ensure_installed = servers,
})

for _, server in ipairs(lsp_installer.get_installed_servers()) do
	local opts = {
		on_attach = require("user.lsp.handlers").on_attach,
		capabilities = require("user.lsp.handlers").capabilities,
	}

	local has_custom_opts, server_custom_opts = pcall(require, "user.lsp.settings." .. server)
	if has_custom_opts then
		opts = vim.tbl_deep_extend("force", server_custom_opts, opts)
	end

	lspconfig[server].setup(opts)
end
