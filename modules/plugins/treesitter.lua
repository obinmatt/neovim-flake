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
	-- enable autotagging (nvim-ts-autotag plugin)
	autotag = {
		enable = true,
	},
})

-- nvim-ts-context-commentstring plugin for commenting tsx and jsx
require("ts_context_commentstring").setup({})
