require("mini.pairs").setup({})
require("mini.surround").setup({})

require("mini.comment").setup({
	options = {
		custom_commentstring = function()
			return require("ts_context_commentstring.internal").calculate_commentstring() or vim.bo.commentstring
		end,
	},
})

require("mini.indentscope").setup({
	symbol = "│",
	options = { try_as_border = true },
})

vim.api.nvim_create_autocmd("FileType", {
	group = vim.api.nvim_create_augroup("mini-indentscope", {}),
	pattern = {
		"help",
		"undotree",
		"oil_preview",
		"oil",
	},
	callback = function()
		vim.b.miniindentscope_disable = true
	end,
})
