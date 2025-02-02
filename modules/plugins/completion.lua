require("luasnip.loaders.from_vscode").lazy_load()
require("luasnip").config.setup({})

require("blink.cmp").setup({
	keymap = { preset = "default" },
	appearance = {
		use_nvim_cmp_as_default = true,
		nerd_font_variant = "mono",
	},
	snippets = {
		preset = "luasnip",
		expand = function(snippet)
			require("luasnip").lsp_expand(snippet)
		end,
	},
	completion = {
		menu = { border = "single" },
		documentation = {
			auto_show = true,
			window = {
				border = "single",
			},
		},
	},
})
