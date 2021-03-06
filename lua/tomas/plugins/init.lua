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
    autocmd BufWritePost $HOME/.config/nvim/lua/tomas/plugins/init.lua source <afile> | PackerSync
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
  use("junegunn/limelight.vim") -- Highlight active paragraph
  use("tpope/vim-abolish") -- (S)earch for case-variants of words
  use("tpope/vim-commentary") -- easily comment stuff
  use("tpope/vim-fugitive") -- git integration
  use("tpope/vim-repeat") -- repeat complex/plugin commands like surround
  use("tpope/vim-surround") -- add tools for working with surroundings
  use({
    "junegunn/vim-easy-align",
    config = function()
      require("tomas.keymaps").easy_align_keymaps()
    end,
  }) -- Align on custom characters

  -- Apps
  use({
    "iamcco/markdown-preview.nvim",
    run = function()
      vim.fn["mkdp#util#install"]()
    end,
    ft = { "markdown" },
  })

  use({
    "pwntester/octo.nvim",
    config = function()
      require("tomas.plugins.octo")
    end
  })

  -- UI
  use({
    "ishan9299/nvim-solarized-lua",
    config = function()
      if require("tomas.colorscheme") == "solarized" then
        require("tomas.utils").set_colorscheme("solarized")
      end
    end,
  })
  use({
    "marko-cerovac/material.nvim",
    config = function()
      if require("tomas.colorscheme") == "material" then
        require("tomas.plugins.material")
        require("tomas.keymaps").material_keymaps()
        vim.g.material_style = "palenight"
        require("tomas.utils").set_colorscheme("material")
      end
    end,
    after = "lualine.nvim",
  })
  use("kyazdani42/nvim-web-devicons")

  use({
    "kyazdani42/nvim-tree.lua",
    config = function()
      require("tomas.plugins.nvim-tree")
      require("tomas.keymaps").nvim_tree_keymaps()
    end,
  })

  use({
    "akinsho/bufferline.nvim",
    config = function()
      require("tomas.plugins.bufferline")
    end,
  })

  use({
    "nvim-lualine/lualine.nvim",
    config = function()
      require("tomas.plugins.lualine")
    end,
  })

  use({
    "lewis6991/gitsigns.nvim",
    config = function()
      require("tomas.plugins.gitsigns")
    end,
  })

  use({
    "nvim-telescope/telescope.nvim",
    config = function()
      require("tomas.plugins.telescope")
      require("tomas.keymaps").telescope_keymaps()
    end,
  }) -- Telescope main
  use("nvim-telescope/telescope-media-files.nvim") -- preview images
  use("nvim-telescope/telescope-ui-select.nvim") -- register telescope for vim.ui.select

  -- Completion
  use({
    "hrsh7th/nvim-cmp",
    requires = {
      "hrsh7th/cmp-buffer", -- buffer completions
      "hrsh7th/cmp-path", -- path completions
      "hrsh7th/cmp-cmdline", -- command line completions
      "hrsh7th/cmp-nvim-lsp-signature-help", -- signature help completions
      "saadparwaiz1/cmp_luasnip", -- snippet completions
      "hrsh7th/cmp-nvim-lsp", -- lsp completion
      "hrsh7th/cmp-nvim-lua", -- lua completion
      "L3MON4D3/LuaSnip", -- snippets engine
      "rafamadriz/friendly-snippets", -- a bunch of snippets to use
    },
    config = function()
      require("tomas.plugins.cmp")
    end,
  }) -- The completion plugin

  -- LSP
  use("neovim/nvim-lspconfig") -- enable built-in LSP
  use("williamboman/nvim-lsp-installer") -- language server installer
  use("jose-elias-alvarez/null-ls.nvim") -- for formatters & linters (where LSP doesn't include it)

  -- Languages
  use("hashivim/vim-terraform") -- support Terraform syntax, ftdetect, etc.,

  use({
    "nvim-treesitter/nvim-treesitter",
    run = ":TSUpdate",
    config = function()
      require("tomas.plugins.treesitter")
    end,
  })

  use("pedrohdz/vim-yaml-folds") -- better yaml folding

  -- Automatically set up config after cloning packer.nvim
  -- Must appear after other plugins
  if PACKER_BOOTSTRAP then
    require("packer").sync()
  end
end)
