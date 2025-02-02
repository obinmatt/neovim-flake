require("luasnip.loaders.from_vscode").lazy_load()
require("luasnip").config.setup({})

require("blink.cmp").setup({
	keymap = { preset = "default" },
	appearance = {
		use_nvim_cmp_as_default = false,
		nerd_font_variant = "mono",
	},
	snippets = {
		preset = "luasnip",
		expand = function(snippet)
			require("luasnip").lsp_expand(snippet)
		end,
	},
	completion = {
		accept = {
			-- experimental auto-brackets support
			auto_brackets = { enabled = true },
		},
		menu = {
			draw = { treesitter = { "lsp" } },
			border = "single",
		},
		documentation = {
			auto_show = true,
			auto_show_delay_ms = 200,
			window = { border = "single" },
		},
	},
	sources = {
		default = { "lsp", "path", "snippets", "buffer" },
		cmdline = {},
	},
})
