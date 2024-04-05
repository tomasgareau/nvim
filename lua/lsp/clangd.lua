local function get_clangd_command()
	if vim.env.IDF_TOOLS_PATH then
    return {
      "clangd",
      "--query-driver=" .. vim.env.IDF_TOOLS_PATH .. "/tools/xtensa-esp32-elf/esp-*/xtensa-esp32-elf/bin/xtensa-esp32-elf-*"
    }
  else
    return {
      "clangd"
    }
	end
end

local M = {
  cmd = get_clangd_command()
}

return M
