local null_ls_status_ok, null_ls = pcall(require, "null-ls")
if not null_ls_status_ok then
	return
end

local formatting = null_ls.builtins.formatting
local diagnostics = null_ls.builtins.diagnostics

null_ls.setup({
	debug = false,
	sources = {
		formatting.black,
    formatting.gofmt,
		formatting.reorder_python_imports.with({
			extra_args = { "--allow-implicit-duplicates" },
		}),
		formatting.stylua,
		diagnostics.flake8,
	},
})
