require("refactoring").setup({})

-- prompt for a refactor to apply when the remap is triggered
vim.keymap.set({ "n", "x" }, "<leader>r", function()
	require("refactoring").select_refactor({ prefer_ex_cmd = true })
end, { desc = "Refactor" })
