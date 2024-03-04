require("mini.pairs").setup({})
require("mini.surround").setup({})
require("mini.statusline").setup({})

require("mini.comment").setup({
	custom_commentstring = function()
		return require("ts_context_commentstring.internal").calculate_commentstring() or vim.bo.commentstring
	end,
})

require("mini.indentscope").setup({
	symbol = "│",
	options = { try_as_border = true },
})
