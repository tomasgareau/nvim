local M = {
	"jose-elias-alvarez/null-ls.nvim",
	event = "BufReadPre",
	commit = "a138b14099e9623832027ea12b4631ddd2a49256",
	dependencies = {
		{
			"nvim-lua/plenary.nvim",
			commit = "36aaceb6e93addd20b1b18f94d86aecc552f30c4",
			lazy = true,
		},
	},
}

function M.config()
	local null_ls = require("null-ls")
	local formatting = null_ls.builtins.formatting
	local diagnostics = null_ls.builtins.diagnostics

	null_ls.setup({
		debug = false,
		sources = {
			formatting.black,
			formatting.reorder_python_imports.with({
				extra_args = { "--allow-implicit-duplicates" },
			}),
			formatting.stylua,
      formatting.terraform_fmt,
		},
	})
end

return M
