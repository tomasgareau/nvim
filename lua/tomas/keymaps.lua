local opts = { noremap = true, silent = true }

local keymap = vim.api.nvim_set_keymap

vim.g.mapleader = ","
vim.g.maplocalleader = ","

-- Normal mode --
-- Better window navigation
keymap("n", "<C-h>", "<C-w>h", opts)
keymap("n", "<C-j>", "<C-w>j", opts)
keymap("n", "<C-k>", "<C-w>k", opts)
keymap("n", "<C-l>", "<C-w>l", opts)

-- Toggle file explorer
keymap("n", "<leader>e", ":NvimTreeToggle<cr>", opts)

-- Resize with arrows
keymap("n", "<C-Up>", ":resize +2<CR>", opts)
keymap("n", "<C-Down>", ":resize -2<CR>", opts)
keymap("n", "<C-Left>", ":vertical resize -2<CR>", opts)
keymap("n", "<C-Right>", ":vertical resize +2<CR>", opts)

-- Navigate buffers more easily
keymap("n", "<S-l>", ":bnext<CR>", opts)
keymap("n", "<S-h>", ":bprevious<CR>", opts)

-- Clear highlights
keymap("n", "<leader><Space>", ":noh<CR>", opts)

-- Move within wrapped lines
keymap("n", "j", "gj", opts)
keymap("n", "k", "gk", opts)

-- Visual mode --
-- Stay in visual mode while indenting
keymap("v", "<", "<gv", opts)
keymap("v", ">", ">gv", opts)

-- Plugins --
-- EasyAlign
keymap("x", "ga", "<Plug>(EasyAlign)", { noremap = false, silent = true })
keymap("n", "ga", "<Plug>(EasyAlign)", { noremap = false, silent = true })

-- Telescope
keymap("n", "<leader>/f", "<cmd>Telescope find_files<CR>", opts)
keymap("n", "<leader>//", "<cmd>Telescope live_grep<CR>", opts)
