local M = {
	"nvim-treesitter/nvim-treesitter",
	commit = "e6cd337e30962cc0982d51fa03beedcc6bc70e3d",
	event = "BufReadPost",
	dependencies = {
		{
			"JoosepAlviste/nvim-ts-context-commentstring",
			event = "VeryLazy",
			commit = "734ebad31c81c6198dfe102aa23280937c937c42",
		},
		{
			"nvim-tree/nvim-web-devicons",
			event = "VeryLazy",
			commit = "3ee60deaa539360518eaab93a6c701fe9f4d82ef",
		},
	},
}
function M.config()
	local treesitter = require("nvim-treesitter")
	local configs = require("nvim-treesitter.configs")

	configs.setup({
		-- ensure_installed = { "lua", "markdown", "markdown_inline", "bash", "python" }, -- put the language you want in this array
		ensure_installed = "all", -- one of "all" or a list of languages
		ignore_install = { "" }, -- List of parsers to ignore installing
		sync_install = false, -- install languages synchronously (only applied to `ensure_installed`)

		highlight = {
			enable = true, -- false will disable the whole extension
			disable = function(lang, buf) -- disable for large files
				local max_filesize = 100 * 1024 -- 100 KB
				local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
				if ok and stats and stats.size > max_filesize then
					return true
				end
			end,
		},
		autopairs = {
			enable = true,
		},
		indent = { enable = true, disable = { "python", "css" } },
	})

	local commentstring = require("ts_context_commentstring")
	commentstring.setup({
		enable_autocmd = false,
	})
end

return M
