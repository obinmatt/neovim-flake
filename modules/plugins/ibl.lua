require("ibl").setup({
	indent = {
		char = "│",
		tab_char = "│",
	},
	scope = { enabled = false },
	exclude = {
		filetypes = {
			"help",
			"notify",
			"undotree",
			"toggleterm",
			"oil_preview",
			"oil",
		},
	},
})
