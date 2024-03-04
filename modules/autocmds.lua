-- disable indentscope for certain file types
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

-- highlight when yanking text
vim.api.nvim_create_autocmd("TextYankPost", {
	desc = "Highlight when yanking (copying) text",
	group = vim.api.nvim_create_augroup("highlight-yank", { clear = true }),
	callback = function()
		vim.highlight.on_yank()
	end,
})
