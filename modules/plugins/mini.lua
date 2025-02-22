require("mini.ai").setup({})
require("mini.pairs").setup({})
require("mini.surround").setup({})

require("mini.move").setup({
	mappings = {
		-- visual mode
		left = "H",
		right = "L",
		down = "J",
		up = "K",

		-- normal mode
		line_left = "H",
		line_right = "L",
		line_down = "J",
		line_up = "K",
	},
})

require("mini.comment").setup({
	options = {
		custom_commentstring = function()
			return require("ts_context_commentstring.internal").calculate_commentstring() or vim.bo.commentstring
		end,
	},
})

local hipatterns = require("mini.hipatterns")
hipatterns.setup({
	highlighters = {
		-- highlight hex color strings (`#rrggbb`) using that color
		hex_color = hipatterns.gen_highlighter.hex_color(),
	},
})
