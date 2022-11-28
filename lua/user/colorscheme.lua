-- vim.g.catppuccin_flavour = "latte"
-- local colorscheme = "catppuccin"

local colorscheme = "solarized"
vim.g.solarized_termtrans = 1
-- vim.o.bg = "light"
vim.o.bg = "dark"

local status_ok, _ = pcall(vim.cmd, "colorscheme " .. colorscheme)
if not status_ok then
  vim.notify("colorscheme " .. colorscheme .. " not found!")
end
