local M = {
	"williamboman/mason.nvim",
	commit = "7d7efc738e08fc5bee822857db45cb6103f0b0c1",
	cmd = "Mason",
	event = "BufReadPre",
	dependencies = {
		{
			"williamboman/mason-lspconfig.nvim",
			commit = "5230617372e656d4a2e1e236e03bf7e7b4b97273",
			lazy = true,
		},
	},
}

local default_lsp_servers = {
	"clangd",
	"gopls",
	"jsonls",
	"lua_ls",
	"pyright",
	"rust_analyzer",
	"tailwindcss",
}

local settings = {
	ui = {
		border = "none",
		icons = {
			package_installed = "✓",
			package_pending = "➜",
			package_uninstalled = "✗",
		},
	},
	log_level = vim.log.levels.INFO,
	max_concurrent_installers = 4,
}

function M.config()
	require("mason").setup(settings)
	require("mason-lspconfig").setup({
		ensure_installed = default_lsp_servers,
		automatic_installation = true,
	})
end

return M
