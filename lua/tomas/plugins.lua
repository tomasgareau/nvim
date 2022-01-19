local fn = vim.fn

local install_path = fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"
if fn.empty(fn.glob(install_path)) > 0 then
	PACKER_BOOTSTRAP = fn.system({
		"git",
		"clone",
		"--depth",
		"1",
		"https://github.com/wbthomason/packer.nvim",
		install_path,
	})
	print("Installing packer: close and reopen Neovim")
	vim.cmd([[packadd packer.nvim]])
end

-- Autocommand to reload neovim every time the plugins.lua file changes
vim.cmd([[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost plugins.lua source <afile> | PackerSync
  augroup end
]])

-- Use a protected call so we don't choke on first use
local status_ok, packer = pcall(require, "packer")
if not status_ok then
	return
end

-- Have packer use a popup window
packer.init({
	display = {
		open_fn = function()
			return require("packer.util").float({ border = "rounded" })
		end,
	},
})

-- Install plugins!
return packer.startup(function(use)
	use("wbthomason/packer.nvim") -- Let packer manage itself
	use("nvim-lua/popup.nvim") -- Popup window API from vim for nvim
	use("nvim-lua/plenary.nvim") -- Lua utils used by other plugins

	-- Utils
	use("junegunn/vim-easy-align") -- Align on custom characters
	use("tpope/vim-abolish") -- (S)earch for case-variants of words
	use("tpope/vim-commentary") -- easily comment stuff
	use("tpope/vim-fugitive") -- git integration
	use("tpope/vim-repeat") -- repeat complex/plugin commands like surround
	use("tpope/vim-surround") -- add tools for working with surroundings
	use("tpope/vim-vinegar") -- enhancements for netrw

	-- Markdown preview tool
	use({
		"iamcco/markdown-preview.nvim",
		run = function()
			vim.fn["mkdp#util#install"]()
		end,
		ft = { "markdown" },
	})

	-- Colorschemes
	use("rose-pine/neovim")
	use("folke/tokyonight.nvim")
	use("ishan9299/nvim-solarized-lua")

	-- Completion plugins
	use("hrsh7th/nvim-cmp") -- The completion plugin
	use("hrsh7th/cmp-buffer") -- buffer completions
	use("hrsh7th/cmp-path") -- path completions
	use("hrsh7th/cmp-cmdline") -- command line completions
	use("saadparwaiz1/cmp_luasnip") -- snippet completions
	use("hrsh7th/cmp-nvim-lsp") -- lsp completion
	use("hrsh7th/cmp-nvim-lua") -- lua completion

	-- Snippets
	use("L3MON4D3/LuaSnip") -- snippets engine
	use("rafamadriz/friendly-snippets") -- a bunch of snippets to use

	-- LSP
	use("neovim/nvim-lspconfig") -- enable LSP
	use("williamboman/nvim-lsp-installer") -- languager server installer

	-- Telescope
	use("nvim-telescope/telescope.nvim") -- Telescope main
	use("nvim-telescope/telescope-media-files.nvim") -- preview images

	-- Files/window
	use("kyazdani42/nvim-web-devicons")
	use("kyazdani42/nvim-tree.lua")
	use("akinsho/bufferline.nvim")
	use("nvim-lualine/lualine.nvim")

	-- Git
	use("lewis6991/gitsigns.nvim")

	-- language/syntax
	use("hashivim/vim-terraform") -- support Terraform syntax, ftdetect, etc
	use("jose-elias-alvarez/null-ls.nvim") -- for formatters & linters (where LSP doesn't include it)
	use({
		"nvim-treesitter/nvim-treesitter",
		run = ":TSUpdate",
	})

	-- Automatically set up config after cloning packer.nvim
	-- Must appear after other plugins
	if PACKER_BOOTSTRAP then
		require("packer").sync()
	end
end)
