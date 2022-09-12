vim.g.catppuccin_flavour = "latte"
local colorscheme = "catppuccin"

-- vim.o.bg = "light"
-- vim.o.bg = "dark"

local status_ok, _ = pcall(vim.cmd, "colorscheme " .. colorscheme)
if not status_ok then
  vim.notify("colorscheme " .. colorscheme .. " not found!")
end
