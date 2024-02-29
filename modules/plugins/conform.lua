require("conform").setup({
	notify_on_error = true,
	format = {
		timeout_ms = 3000,
		async = false,
		quiet = false,
	},
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
