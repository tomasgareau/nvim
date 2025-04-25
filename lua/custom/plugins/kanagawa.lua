return {
	{
		"rebelot/kanagawa.nvim",
		priority = 1000, -- Make sure to load this before all the other start plugins.
		init = function()
			-- Automatically switch the terminal theme if possible
			vim.api.nvim_create_autocmd("ColorScheme", {
				pattern = "kanagawa",
				callback = function()
					if vim.o.background == "light" then
						vim.fn.system("command -v alacritty-theme-switcher && alacritty-theme-switcher kanagawa_lotus")
					elseif vim.o.background == "dark" then
						vim.fn.system("command -v alacritty-theme-switcher && alacritty-theme-switcher kanagawa_dragon")
					else
						vim.fn.system("command -v alacritty-theme-switcher && alacritty-theme-switcher kanagawa_wave")
					end
				end,
			})

			require("kanagawa").setup({
				compile = true, -- enable compiling the colorscheme
				undercurl = true, -- enable undercurls
				commentStyle = { italic = true },
				functionStyle = {},
				keywordStyle = { italic = true },
				statementStyle = { bold = true },
				typeStyle = {},
				transparent = true, -- do not set background color
				dimInactive = true, -- dim inactive window `:h hl-NormalNC`
				terminalColors = true, -- define vim.g.terminal_color_{0,17}
				colors = { -- add/modify theme and palette colors
					palette = {},
					theme = { wave = {}, lotus = {}, dragon = {}, all = {} },
				},
				overrides = function(colors) -- add/modify highlights
					return {}
				end,
				theme = "wave", -- Load "wave" theme when 'background' option is not set
				background = { -- map the value of 'background' option to a theme
					dark = "wave", -- try "dragon" !
					light = "lotus",
				},
			})

			vim.cmd.colorscheme("kanagawa")
		end,
	},
}
-- vim: ts=2 sts=2 sw=2 et
