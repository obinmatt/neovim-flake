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

require("treesitter-context").setup({
	max_lines = 3,
})

-- skip backwards compatibility routines and speed up loading
vim.g.skip_ts_context_commentstring_module = true
