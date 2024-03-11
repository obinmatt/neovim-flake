require("catppuccin").setup({
	flavour = "mocha",
	transparent_background = true,
	styles = {
		conditionals = {},
	},
	integrations = {
		notify = true,
	},
})

vim.cmd("colorscheme catppuccin")
