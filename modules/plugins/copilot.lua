require("copilot").setup({
	suggestion = {
		auto_trigger = true,
		keymap = {
			accept = "<C-l>",
		},
	},
	panel = { enabled = false },
	filetypes = {
		markdown = true,
		help = true,
	},
	server_opts_overrides = {
		settings = {
			telemetry = {
				telemetryLevel = "off",
			},
		},
	},
})
