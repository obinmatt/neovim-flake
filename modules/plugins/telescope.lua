local telescope = require("telescope")
local builtin = require("telescope.builtin")
local actions = require("telescope.actions")

telescope.setup({
	defaults = {
		winblend = 0,
		mappings = {
			n = {
				["q"] = "close",
			},
		},
	},
	pickers = {
		buffers = {
			sort_lastused = true,
			mappings = {
				["n"] = {
					["dd"] = actions.delete_buffer + actions.move_to_top,
				},
			},
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
	extensions = {
		["ui-select"] = {
			require("telescope.themes").get_dropdown(),
		},
	},
})

-- enable telescope extensions, if they are installed
pcall(require("telescope").load_extension, "fzf")
pcall(require("telescope").load_extension, "ui-select")

-- set telescope keymaps
local keymap = vim.keymap
local opts = { noremap = true, silent = true }

opts.desc = "Telescope find files"
keymap.set("n", "<leader>ff", builtin.find_files, opts)

opts.desc = "Telescope live grep"
keymap.set("n", "<leader>fg", builtin.live_grep, opts)

opts.desc = "Telescope search current buffer"
keymap.set("n", "<leader>fs", function()
	builtin.current_buffer_fuzzy_find(require("telescope.themes").get_dropdown({
		previewer = false,
	}))
end, opts)

opts.desc = "Telescope buffers"
keymap.set("n", "<leader>fb", builtin.buffers, opts)

opts.desc = "Telescope document symbols"
keymap.set("n", "<leader>fd", builtin.lsp_document_symbols, opts)
