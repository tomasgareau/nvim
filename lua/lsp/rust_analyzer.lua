local M = {
	settings = {
		["rust-analyzer"] = {
			check = {
				command = "clippy",
			},
			completion = {
				postfix = {
					enable = false,
				},
			},
		},
	},
}

return M
