function get_python_path(dir)
	if vim.env.VIRTUAL_ENV then
		return vim.env.VIRTUAL_ENV .. "/bin/python"
	elseif vim.env.CONDA_PREFIX then
		return vim.env.CONDA_PREFIX .. "/bin/python"
	else
		local venv_ok, venv = pcall(vim.fn.system, "cd " .. dir .. " && poetry env info -p 2>/dev/null")
		if venv_ok then
			return vim.fn.trim(venv) .. "/bin/python"
		end
	end

	return vim.fn.exepath("python3") or vim.fn.exepath("python") or "python"
end

local M = {
	settings = {
		python = {
			analysis = {
				typeCheckingMode = "basic",
				diagnosticSeverityOverrides = {
					reportUnknownParameterType = "none",
					reportUnknownMemberType = "none",
				},
			},
		},
	},
	on_init = function(client)
		local ppath = get_python_path(client.config.root_dir)
		client.config.settings.python.pythonPath = ppath
	end,
}

return M
