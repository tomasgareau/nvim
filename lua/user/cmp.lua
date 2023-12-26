local M = {
	"hrsh7th/nvim-cmp",
	commit = "cfafe0a1ca8933f7b7968a287d39904156f2c57d",
	dependencies = {
		{
			"hrsh7th/cmp-nvim-lsp",
			commit = "0e6b2ed705ddcff9738ec4ea838141654f12eeef",
		},
		{
			"hrsh7th/cmp-buffer",
			commit = "3022dbc9166796b644a841a02de8dd1cc1d311fa",
		},
		{
			"hrsh7th/cmp-path",
			commit = "91ff86cd9c29299a64f968ebb45846c485725f23",
		},
		{
			"hrsh7th/cmp-cmdline",
			commit = "23c51b2a3c00f6abc4e922dbd7c3b9aca6992063",
		},
		{
			"hrsh7th/cmp-nvim-lsp-signature-help",
			commit = "3d8912ebeb56e5ae08ef0906e3a54de1c66b92f1",
		},
		{
			"saadparwaiz1/cmp_luasnip",
			commit = "18095520391186d634a0045dacaa346291096566",
		},
		{
			"L3MON4D3/LuaSnip",
			commit = "9bff06b570df29434a88f9c6a9cea3b21ca17208",
			event = "InsertEnter",
			dependencies = {
				"rafamadriz/friendly-snippets",
				commit = "a6f7a1609addb4e57daa6bedc300f77f8d225ab7",
			},
		},
		{
			"hrsh7th/cmp-nvim-lua",
			commit = "f3491638d123cfd2c8048aefaf66d246ff250ca6",
		},
	},
	event = {
		"InsertEnter",
		"CmdlineEnter",
	},
}

function M.config()
	local cmp = require("cmp")
	local types = require("cmp.types")
	local luasnip = require("luasnip")
	require("luasnip/loaders/from_vscode").lazy_load()

	local check_backspace = function()
		local col = vim.fn.col(".") - 1
		return col == 0 or vim.fn.getline("."):sub(col, col):match("%s")
	end

	function compare_kind_low_snippets(entry1, entry2)
		local kind1 = entry1:get_kind() --- @type lsp.CompletionItemKind | number
		local kind2 = entry2:get_kind() --- @type lsp.CompletionItemKind | number
		kind1 = kind1 == types.lsp.CompletionItemKind.Text and 100 or kind1
		kind2 = kind2 == types.lsp.CompletionItemKind.Text and 100 or kind2
		if kind1 ~= kind2 then
			if kind1 == types.lsp.CompletionItemKind.Snippet then
				return false
			end
			if kind2 == types.lsp.CompletionItemKind.Snippet then
				return true
			end
			local diff = kind1 - kind2
			if diff < 0 then
				return true
			elseif diff > 0 then
				return false
			end
		end
		return nil
	end

	--   פּ ﯟ   some other good icons
	local kind_icons = {
		Text = "",
		Method = "m",
		Function = "",
		Constructor = "",
		Field = "",
		Variable = "",
		Class = "",
		Interface = "",
		Module = "",
		Property = "",
		Unit = "",
		Value = "",
		Enum = "",
		Keyword = "",
		Snippet = "",
		Color = "",
		File = "",
		Reference = "",
		Folder = "",
		EnumMember = "",
		Constant = "",
		Struct = "",
		Event = "",
		Operator = "",
		TypeParameter = "",
	}

	cmp.setup({
		snippet = {
			expand = function(args)
				luasnip.lsp_expand(args.body) -- For `luasnip` users.
			end,
		},
		mapping = cmp.mapping.preset.insert({
			["<C-k>"] = cmp.mapping.select_prev_item(),
			["<C-j>"] = cmp.mapping.select_next_item(),
			["<C-b>"] = cmp.mapping(cmp.mapping.scroll_docs(-1), { "i", "c" }),
			["<C-f>"] = cmp.mapping(cmp.mapping.scroll_docs(1), { "i", "c" }),
			["<C-Space>"] = cmp.mapping(cmp.mapping.complete(), { "i", "c" }),
			["<C-e>"] = cmp.mapping({
				i = cmp.mapping.abort(),
				c = cmp.mapping.close(),
			}),
			-- Accept currently selected item. If none selected, `select` first item.
			-- Set `select` to `false` to only confirm explicitly selected items.
			["<CR>"] = cmp.mapping.confirm({ select = false }),
			["<Tab>"] = cmp.mapping(function(fallback)
				if cmp.visible() then
					cmp.select_next_item()
				elseif luasnip.expandable() then
					luasnip.expand()
				elseif luasnip.expand_or_jumpable() then
					luasnip.expand_or_jump()
				elseif check_backspace() then
					fallback()
				else
					fallback()
				end
			end, {
				"i",
				"s",
			}),
			["<S-Tab>"] = cmp.mapping(function(fallback)
				if cmp.visible() then
					cmp.select_prev_item()
				elseif luasnip.jumpable(-1) then
					luasnip.jump(-1)
				else
					fallback()
				end
			end, {
				"i",
				"s",
			}),
		}),
		formatting = {
			fields = { "kind", "abbr", "menu" },
			format = function(entry, vim_item)
				vim_item.kind = kind_icons[vim_item.kind]
				vim_item.menu = ({
					nvim_lsp = "",
					nvim_lua = "",
					luasnip = "",
					buffer = "",
					path = "",
					emoji = "",
				})[entry.source.name]
				return vim_item
			end,
		},
		sources = {
			{ name = "nvim_lsp" },
			{ name = "nvim_lsp_signature_help" },
			{ name = "nvim_lua" },
			{ name = "luasnip" },
			{ name = "buffer" },
			{ name = "path" },
		},
		sorting = {
			comparators = {
				cmp.config.compare.offset,
				cmp.config.compare.exact,
				-- cmp.config.compare.scopes,
				cmp.config.compare.score,
				cmp.config.compare.recently_used,
				cmp.config.compare.locality,
				-- use compare_kind_low_snippets to deprioritize snippets
				-- cmp.config.compare.kind,
				compare_kind_low_snippets,
				-- cmp.config.compare.sort_text,
				cmp.config.compare.length,
				cmp.config.compare.order,
			},
		},
		confirm_opts = {
			behavior = cmp.ConfirmBehavior.Replace,
			select = false,
		},
		window = {
			completion = cmp.config.window.bordered(),
			documentation = cmp.config.window.bordered(),
		},
		experimental = {
			ghost_text = true,
		},
	})
end

return M
