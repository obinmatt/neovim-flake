require("nvim-treesitter.configs").setup({
	modules = {},
	sync_install = false,
	auto_install = false,
	ensure_installed = {},
	ignore_install = { "all" },
	highlight = { enable = true },
	indent = { enable = true },
})

require("ts_context_commentstring").setup({
	enable_autocmd = false,
})

require("nvim-ts-autotag").setup()
