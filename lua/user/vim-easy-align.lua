local M = {
	"junegunn/vim-easy-align",
	commit = "12dd6316974f71ce333e360c0260b4e1f81169c3",
	event = "VeryLazy",
}

function M.config()
	local keymaps = require("keymaps")
	keymaps.easy_align()
end

return M
