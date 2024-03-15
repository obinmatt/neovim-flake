require("mini.pairs").setup({})
require("mini.surround").setup({})
require("mini.statusline").setup({})

require("mini.files").setup({
	mappings = {
		go_in = "",
		go_in_plus = "<cr>",
		go_out = "",
		go_out_plus = "-",
	},
})

require("mini.comment").setup({
	options = {
		custom_commentstring = function()
			return require("ts_context_commentstring.internal").calculate_commentstring() or vim.bo.commentstring
		end,
	},
})
