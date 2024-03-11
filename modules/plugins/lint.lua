require("lint").linters_by_ft = {
	javascript = { "biomejs", "eslint_d" },
	javascriptreact = { "biomejs", "eslint_d" },
	typescript = { "biomejs", "eslint_d" },
	typescriptreact = { "biomejs", "eslint_d" },
	html = { { "biomejs", "eslint_d" } },
	css = { { "biomejs", "eslint_d" } },
	json = { { "biomejs", "eslint_d" } },
}

vim.api.nvim_create_autocmd({ "BufWritePost", "BufReadPost", "InsertLeave" }, {
	group = vim.api.nvim_create_augroup("nvim-lint", { clear = true }),
	callback = function()
		require("lint").try_lint()
	end,
})
