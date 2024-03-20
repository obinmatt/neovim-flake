local telescope = require("telescope")
local builtin = require("telescope.builtin")
local actions = require("telescope.actions")

telescope.setup({
	defaults = {
		path_display = { "truncate" },
		mappings = {
			n = {
				["q"] = "close",
			},
		},
	},
	pickers = {
		buffers = {
			sort_lastused = true,
			initial_mode = "normal",
			mappings = {
				["n"] = {
					["dd"] = actions.delete_buffer + actions.move_to_top,
				},
			},
		},
		diagnostics = {
			theme = "ivy",
			initial_mode = "normal",
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

pcall(require("telescope").load_extension, "fzf")
pcall(require("telescope").load_extension, "ui-select")

local map = function(keys, func, desc)
	vim.keymap.set("n", keys, func, { noremap = true, silent = true, desc = desc })
end

map("<leader>fb", builtin.buffers, "Telescope buffers")
map("<leader>fd", builtin.lsp_document_symbols, "Telescope document symbols")
map("<leader>ff", builtin.find_files, "Telescope find files")
map("<leader>fg", builtin.live_grep, "Telescope live grep")
map("<leader>fk", builtin.keymaps, "Telescope keymaps")
map("<leader>/", function()
	builtin.current_buffer_fuzzy_find(require("telescope.themes").get_dropdown({
		previewer = false,
	}))
end, "Telescope search current buffer")
