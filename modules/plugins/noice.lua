require("noice").setup({
	views = {
		notify = {
			replace = true,
		},
	},
	lsp = {
		progress = { view = "notify" },
		override = {
			["vim.lsp.util.convert_input_to_markdown_lines"] = true,
			["vim.lsp.util.stylize_markdown"] = true,
			["cmp.entry.get_documentation"] = true,
		},
	},
	presets = {
		bottom_search = true,
		command_palette = false,
		long_message_to_split = true,
		inc_rename = true,
		lsp_doc_border = true,
	},
})
