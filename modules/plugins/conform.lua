require("conform").setup({
	notify_on_error = true,
	format_on_save = {
		timeout_ms = 500,
		lsp_fallback = true,
	},
	formatters_by_ft = {
		javascript = { { "prettier", "eslint_d" } },
		javascriptreact = { { "prettier", "eslint_d" } },
		typescript = { { "prettier", "eslint_d" } },
		typescriptreact = { { "prettier", "eslint_d" } },
		html = { { "prettier", "eslint_d" } },
		css = { { "prettier", "eslint_d" } },
		json = { { "prettier", "eslint_d" } },
		nix = { "alejandra" },
		lua = { "stylua" },
	},
})

-- organize imports for ts/js files
vim.api.nvim_create_autocmd("BufWritePre", {
	pattern = { "*.ts", "*.tsx", "*.js", "*.jsx" },
	callback = function()
		vim.lsp.buf.execute_command({
			command = "_typescript.organizeImports",
			arguments = { vim.api.nvim_buf_get_name(0) },
			title = "Typescript organize imports",
		})
	end,
})
