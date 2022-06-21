local utils = require("tomas.utils")

return {
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
		local ppath = utils.get_python_path(client.config.root_dir)
		client.config.settings.python.pythonPath = ppath
	end,
}
