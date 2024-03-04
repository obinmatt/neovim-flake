vim.api.nvim_create_autocmd("FileType", {
	pattern = {
		"help",
		"notify",
		"undotree",
		"toggleterm",
		"oil_preview",
		"oil",
	},
	callback = function()
		vim.b.miniindentscope_disable = true
	end,
})
