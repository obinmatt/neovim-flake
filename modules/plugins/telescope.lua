local telescope = require("telescope")

telescope.setup({
	defaults = {
		path_display = { "truncate" },
		mappings = {
			n = {
				["dd"] = "delete_buffer",
				["q"] = "close",
			},
		},
	},
	pickers = {
		buffers = {
			initial_mode = "normal",
		},
		diagnostics = {
			theme = "ivy",
			initial_mode = "normal",
			layout_config = {
				preview_cutoff = 9999,
			},
		},
	},
	file_ignore_patterns = {
		".git/",
		"node_modules/",
	},
})

telescope.load_extension("fzf")

local keymap = vim.keymap
local opts = { noremap = true, silent = true }
local builtin = require("telescope.builtin")

opts.desc = "Telescope find files"
keymap.set("n", "<leader>ff", builtin.find_files, opts)

opts.desc = "Telescope live grep"
keymap.set("n", "<leader>fg", builtin.live_grep, opts)

opts.desc = "Telescope search current buffer"
keymap.set("n", "<leader>fs", builtin.current_buffer_fuzzy_find, opts)

opts.desc = "Telescope buffers"
keymap.set("n", "<leader>fb", builtin.buffers, opts)

opts.desc = "Telescope document symbols"
keymap.set("n", "<leader>fd", builtin.lsp_document_symbols, opts)
