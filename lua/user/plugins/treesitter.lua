local status_ok, configs = pcall(require, "nvim-treesitter.configs")
if not status_ok then
	return
end

configs.setup({
	ensure_installed = "all", -- one of "all", "maintained", or a list of languages
	sync_install = false, -- install languages synchronously (only applied to `ensure_installed`)
	ignore_install = { "" }, -- list of parsers to ignore installing
	highlight = {
		enable = true, -- false disables treesitter
		disable = { "" }, -- list of languages to disable
		additional_vim_regex_highlighting = true,
	},
	indent = {
		enable = true,
		disable = { "yaml", "python" },
	},
})
