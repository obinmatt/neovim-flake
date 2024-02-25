local telescope = require("telescope")

telescope.setup({
	defaults = {
		path_display = { "truncate" },
		mappings = {
			n = {
				["db"] = "delete_buffer",
				["q"] = "close",
			},
		},
	},
	pickers = {
		diagnostics = {
			theme = "dropdown",
		},
	},
	file_ignore_patterns = {
		".git/",
		"node_modules/",
	},
})

telescope.load_extension("fzf")
