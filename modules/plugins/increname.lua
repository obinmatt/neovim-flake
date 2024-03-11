require("inc_rename").setup({
	preview_empty_name = true,
})

vim.keymap.set("n", "<leader>rn", function()
	return ":IncRename " .. vim.fn.expand("<cword>")
end, { noremap = true, silent = true, expr = true, desc = "Toggle IncRename" })
