local dap_ok, dap = pcall(require, "dap")
if not dap_ok then
  vim.notify("Failed to require dap")
	return
end

local debug_adapters = {
	"cpp",
}

for _, adapter in pairs(debug_adapters) do
	local adapter_ok, _ = pcall(require, "tomas.dap.settings." .. adapter)
	if not adapter_ok then
		vim.notify("Failed to setup debug adapter for " .. adapter)
	end
end

require("tomas.dap.dapui-setup")
require("tomas.keymaps").dap_keymaps()
