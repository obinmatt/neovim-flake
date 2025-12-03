require("copilot").setup({
	suggestion = {
		auto_trigger = true,
		keymap = {
			accept = "<D-l>",
		},
	},
	panel = { enabled = false },
	filetypes = {
		markdown = true,
		help = true,
	},
})
