local options = {
	backup = false, -- creates a backup file
	clipboard = "unnamedplus", -- allows neovim to access the system clipboard
	cmdheight = 1, -- space in the nvim command line for displaying messages
	completeopt = { "menuone", "noselect" },
	conceallevel = 0, -- make `` visible in markdown files
	cursorline = true, -- highlight the current line
	expandtab = true, -- expand tabs into spaces
	fileencoding = "utf-8", -- encode as UTF-8 when writing files
	guifont = "monospace:h17", -- font used for graphical nvim applications
	hlsearch = true, -- highlight searches
	ignorecase = true, -- ignore case in search patterns
	incsearch = true, -- highlight searches as you type
	lazyredraw = true, -- redraw only when required
	mouse = "n", -- enable mouse in all modes
	number = true, -- add line numbers
	numberwidth = 4, -- use 4 spaces for numbers
	pumheight = 10, -- height of pop-up menu window
	relativenumber = true, -- do set relative numbered lines
	ruler = true, -- show current line/column
	scrolloff = 5, -- leave space from top/bottom
	shiftwidth = 2, -- the number of spaces inserted per indentation
	showmatch = true, -- show matching brackets
	showmode = false, -- don't show the mode we're in on last line
	showtabline = 2, -- always show tabs
	sidescrolloff = 8, -- leave space on sides
	signcolumn = "yes", -- always show the sign column, otherwise it shifts text each time
	smartcase = true, -- intelligently use cases
	smartindent = true, -- intelligently add indent
	splitbelow = true, -- always split window below current
	splitright = true, -- always split window right of current
	swapfile = false, -- create a swap file
	tabstop = 2, -- visual width of tab characters
	termguicolors = true, -- set term GUI colors
	timeoutlen = 1000, -- time to wait for a mapped sequence to end
	undofile = true, -- persistent undo
	updatetime = 300, -- faster completion
	wildmenu = true, -- better menu
	wrap = false, -- don't wrap by default
	writebackup = false, -- make a backup before overwriting a file
}

for k, v in pairs(options) do
	pcall(vim.api.nvim_set_option_value, k, v, {})
end

vim.api.nvim_create_autocmd({ "VimLeave", "VimSuspend" }, {
	callback = function()
		vim.opt["guicursor"] = "a:ver90"
	end,
})

-- Use relative numbers in normal mode, absolute in insert mode
vim.api.nvim_create_autocmd("InsertEnter", {
	callback = function()
		vim.opt["relativenumber"] = false
	end,
})

vim.api.nvim_create_autocmd("InsertLeave", {
	callback = function()
		vim.opt["relativenumber"] = true
	end,
})
