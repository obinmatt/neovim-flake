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
			"toggleterm",
			"oil_preview",
			"oil",
		},
	},
})
