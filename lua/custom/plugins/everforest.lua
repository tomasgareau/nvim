return {
	"sainnhe/everforest",
	lazy = false,
	priority = 1000,
	config = function()
		vim.g.everforest_background = "hard"
		vim.g.everforest_enable_italic = 1
		vim.g.everforest_disable_italic_comment = 0
		vim.g.everforest_cursor = "auto"
		vim.g.everforest_transparent_background = 2
		vim.g.everforest_dim_inactive_windows = 1
		vim.g.everforest_sign_column_background = "grey"
		vim.g.everforest_spell_foreground = "none"
		vim.g.everforest_ui_contrast = "low"
		vim.g.everforest_show_eob = 1
		vim.g.everforest_float_style = "bright"
		vim.g.everforest_diagnostic_text_highlight = 1
		vim.g.everforest_diagnostic_line_highlight = 0
		vim.g.everforest_diagnostic_virtual_text = "grey"
		vim.g.everforest_inlay_hints_background = "none"
		vim.g.everforest_disable_terminal_colors = 0
		vim.g.everforest_better_performance = 1
		vim.cmd.colorscheme("everforest")
	end,
}
