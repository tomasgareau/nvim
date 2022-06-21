local M = {}

local opts = { noremap = true, silent = true }

local keymap = vim.api.nvim_set_keymap
local bufkeymap = vim.api.nvim_buf_set_keymap

M.default_keymaps = function()
  vim.g.mapleader = ","
  vim.g.maplocalleader = ","

  -- Normal mode --
  -- Better window navigation
  keymap("n", "<C-h>", "<C-w>h", opts)
  keymap("n", "<C-j>", "<C-w>j", opts)
  keymap("n", "<C-k>", "<C-w>k", opts)
  keymap("n", "<C-l>", "<C-w>l", opts)

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

  -- Leader yank to system clipboard
  keymap("n", "<leader>y", '"+y', opts)

  -- Visual mode --
  -- Stay in visual mode while indenting
  keymap("v", "<", "<gv", opts)
  keymap("v", ">", ">gv", opts)
end

M.nvim_tree_keymaps = function()
  keymap("n", "<leader>nt", ":NvimTreeToggle<cr>", opts)
  keymap("n", "<leader>nf", ":NvimTreeFindFileToggle<cr>", opts)
end

M.telescope_keymaps = function()
  keymap("n", "<leader>/f", "<cmd>Telescope find_files<CR>", opts)
  keymap("n", "<leader>//", "<cmd>Telescope live_grep<CR>", opts)
end

M.easy_align_keymaps = function()
  keymap("x", "ga", "<Plug>(EasyAlign)", { noremap = false, silent = true })
  keymap("n", "ga", "<Plug>(EasyAlign)", { noremap = false, silent = true })
end

M.lsp_keymaps = function(bufnr)
  bufkeymap(bufnr, "n", "gD", "<cmd>lua vim.lsp.buf.declaration()<CR>", opts)
  bufkeymap(bufnr, "n", "gd", "<cmd>lua vim.lsp.buf.definition()<CR>", opts)
  bufkeymap(bufnr, "n", "gh", "<cmd>lua vim.lsp.buf.hover()<CR>", opts)
  bufkeymap(bufnr, "n", "gi", "<cmd>lua vim.lsp.buf.implementation()<CR>", opts)
  bufkeymap(bufnr, "n", "gs", "<cmd>lua vim.lsp.buf.signature_help()<CR>", opts)
  bufkeymap(bufnr, "n", "<leader>rn", "<cmd>lua vim.lsp.buf.rename()<CR>", opts)
  bufkeymap(bufnr, "n", "gr", "<cmd>lua vim.lsp.buf.references()<CR>", opts)
  bufkeymap(bufnr, "n", "<leader>ca", "<cmd>lua vim.lsp.buf.code_action()<CR>", opts)
  bufkeymap(bufnr, "n", "gl", '<cmd>lua vim.diagnostic.open_float({ border = "rounded" })<CR>', opts)
  bufkeymap(bufnr, "n", "[d", '<cmd>lua vim.diagnostic.goto_prev({ border = "rounded" })<CR>', opts)
  bufkeymap(bufnr, "n", "]d", '<cmd>lua vim.diagnostic.goto_next({ border = "rounded" })<CR>', opts)
  bufkeymap(bufnr, "n", "<leader>q", "<cmd>lua vim.diagnostic.setloclist()<CR>", opts)
  bufkeymap(bufnr, "n", "<leader>f", "<cmd>lua vim.lsp.buf.formatting_sync()<CR>", opts)
end

M.material_keymaps = function()
  keymap("n", "<leader>mm", [[<Cmd>lua require('material.functions').toggle_style()<CR>]], opts)
  keymap("n", "<leader>ml", [[<Cmd>lua require('material.functions').change_style('lighter')<CR>]], opts)
  keymap("n", "<leader>md", [[<Cmd>lua require('material.functions').change_style('darker')<CR>]], opts)
  keymap("n", "<leader>mp", [[<Cmd>lua require('material.functions').change_style('palenight')<CR>]], opts)
  keymap("n", "<leader>mo", [[<Cmd>lua require('material.functions').change_style('oceanic')<CR>]], opts)
end

return M
