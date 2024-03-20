require("nvim-treesitter.configs").setup({
	ensure_installed = {},
	sync_install = false,
	auto_install = false,
	ignore_install = { "all" },
	highlight = {
		enable = true,
	},
	indent = {
		enable = true,
	},
})

require("ts_context_commentstring").setup({
	enable_autocmd = false,
})
