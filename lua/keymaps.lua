local M = {}

local opts = { noremap = true, silent = true }

local keymap = vim.keymap.set
local bufkeymap = vim.api.nvim_buf_set_keymap
local callback_keymap = function(mode, key, mapping, callback_opts)
	local extended_opts = {
		callback = mapping,
	}
	extended_opts = vim.tbl_deep_extend("force", extended_opts, callback_opts)
	vim.api.nvim_set_keymap(mode, key, "", extended_opts)
end

function M.default()
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
	keymap("n", "<leader>p", '"+p', opts)
	keymap("n", "<leader>P", '"+P', opts)

	-- Visual mode --
	-- Stay in visual mode while indenting
	keymap("v", "<", "<gv", opts)
	keymap("v", ">", ">gv", opts)

	-- Rename visual selection -- like LSP rename but for non-LSP-symbols
	keymap("v", "<leader>rn", '"hy:%s/<C-r>h//gc<left><left><left>', opts)

	-- F3 to insert timestamp
	keymap("n", "<F3>", '"=strftime("%s")<CR>gP', opts)
	keymap("i", "<F3>", "<C-r>=strftime('%s')<CR>", opts)
end

function M.nvim_tree()
	keymap("n", "<leader>nt", ":NvimTreeToggle<cr>", opts)
	keymap("n", "<leader>nf", ":NvimTreeFindFileToggle<cr>", opts)
end

function M.telescope()
	keymap("n", "<leader>/f", "<cmd>Telescope find_files<CR>", opts)
	keymap("n", "<leader>//", "<cmd>Telescope live_grep<CR>", opts)
end

function M.easy_align()
	keymap("x", "ga", "<Plug>(EasyAlign)", { noremap = false, silent = true })
	keymap("n", "ga", "<Plug>(EasyAlign)", { noremap = false, silent = true })
end

function M.lsp(bufnr)
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
	bufkeymap(bufnr, "n", "<leader>f", "<cmd>lua vim.lsp.buf.format()<CR>", opts)
end

function M.dap()
	local dap = require("dap")
	local dapui = require("dapui")
	callback_keymap("n", "<leader>dc", dap.continue, opts)
	callback_keymap("n", "<leader>dn", dap.step_over, opts)
	callback_keymap("n", "<leader>di", dap.step_into, opts)
	callback_keymap("n", "<leader>do", dap.step_out, opts)
	callback_keymap("n", "<leader>db", dap.toggle_breakpoint, opts)
	callback_keymap("n", "<leader>de", dap.eval, opts)
	callback_keymap("v", "<leader>de", dap.eval, opts)
	callback_keymap("n", "<leader>df", dap.float_element, opts)
	callback_keymap("n", "<leader>ds", function()
		dapui.float_element("scopes")
	end, opts)
	callback_keymap("n", "<leader>dr", function()
		dapui.float_element("repl")
	end, opts)
	callback_keymap("n", "<leader>dq", dap.terminate, opts)
	callback_keymap("n", "<leader>dt", dapui.toggle, opts)
end

return M
