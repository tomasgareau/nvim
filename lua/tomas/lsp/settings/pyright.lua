local found_util, util = pcall(require, "lspconfig.util")
if not found_util then
	vim.notify("Could not find lspconfig.util in pyright.lua")
	return
end

local function get_python_path(workspace)
	if vim.env.VIRTUAL_ENV then
		return util.path.join(vim.env.VIRTUAL_ENV, "bin", "python")
	else
		if util.path.exists(util.path.join(workspace, "poetry.lock")) then
			local venv_ok, venv = pcall(vim.fn.system, "cd " .. workspace .. " && poetry env info -p")
			if venv_ok then
				return util.path.join(vim.fn.trim(venv), "bin", "python")
			end
		end
	end

	return vim.fn.exepath("python3") or vim.fn.exepath("python") or "python"
end

return {
	settings = {
		python = {
			analysis = {
				typeCheckingMode = "strict",
			},
		},
	},
	on_init = function(client)
		local ppath = get_python_path(client.config.root_dir)
		client.config.settings.python.pythonPath = ppath
	end,
}
