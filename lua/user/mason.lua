local M = {
	"williamboman/mason.nvim",
	commit = "c43eeb5614a09dc17c03a7fb49de2e05de203924",
	cmd = "Mason",
	event = "BufReadPre",
	dependencies = {
		{
			"williamboman/mason-lspconfig.nvim",
			commit = "2ba17cecfde8b8c7c7c287909a1e4de895223df6",
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
