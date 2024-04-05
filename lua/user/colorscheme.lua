local M = {
	"rebelot/kanagawa.nvim",
	commit = "14a7524a8b259296713d4d77ef3c7f4dec501269",
	lazy = false, -- make sure we load this during startup if it is your main colorscheme
	priority = 1000, -- make sure to load this before all the other start plugins
}

M.name = "kanagawa"
function M.config()
	local status_ok, _ = pcall(vim.cmd.colorscheme, M.name)
	if not status_ok then
		return
	end

	local kanagawa_ok, kanagawa = pcall(require, "kanagawa")
	if not kanagawa_ok then
		vim.notify("Colorscheme load failed!")
		return
	end

	kanagawa.setup({
		compile = true, -- enable compiling the colorscheme
		undercurl = true, -- enable undercurls
		commentStyle = { italic = true },
		functionStyle = {},
		keywordStyle = { italic = true },
		statementStyle = { bold = true },
		typeStyle = {},
		transparent = false, -- do not set background color
		dimInactive = true, -- dim inactive window `:h hl-NormalNC`
		terminalColors = true, -- define vim.g.terminal_color_{0,17}
		colors = {
			-- add/modify theme and palette colors
			palette = {
				lotusWhite0 = "#f7f1e1",
				lotusWhite1 = "#f6efdd",
				lotusWhite2 = "#f5edd9",
				lotusWhite3 = "#f3ebd4",
				lotusWhite4 = "#f2e9d0",
				lotusWhite5 = "#f1e7cc",
			},
			theme = {
				wave = {},
				lotus = {},
				dragon = {},
				all = {},
			},
		},
		overrides = function(colors) -- add/modify highlights
			return {}
		end,
		theme = "wave", -- Load "wave" theme when 'background' option is not set
		background = {
			-- map the value of 'background' option to a theme
			dark = "wave", -- try "dragon" !
			light = "lotus",
		},
	})

	vim.cmd("colorscheme kanagawa")
  vim.cmd("highlight Normal ctermbg=NONE guibg=NONE")
end

return M
