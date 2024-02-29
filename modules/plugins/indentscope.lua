require("mini.indentscope").setup({
	symbol = "│",
	options = { try_as_border = true },
})

vim.api.nvim_create_autocmd("FileType", {
	pattern = {
		"help",
		"notify",
		"toggleterm",
		"oil_preview",
		"oil",
	},
	callback = function()
		vim.b.miniindentscope_disable = true
	end,
})
