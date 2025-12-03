require("nvim-treesitter.configs").setup({
	modules = {},
	sync_install = false,
	auto_install = false,
	ensure_installed = {},
	ignore_install = { "all" },
	highlight = { enable = true },
	indent = { enable = true },
})

require("nvim-ts-autotag").setup()
require("ts_context_commentstring").setup({
	enable_autocmd = false,
})

vim.keymap.set("n", "[c", function()
	require("treesitter-context").go_to_context(vim.v.count1)
end, { silent = true })
