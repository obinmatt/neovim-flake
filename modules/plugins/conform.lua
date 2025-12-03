require("conform").setup({
	notify_on_error = true,
	format_on_save = {
		timeout_ms = 1000,
		lsp_format = "fallback",
	},
	formatters_by_ft = {
		javascript = { "prettierd", "eslint_d" },
		javascriptreact = { "prettierd", "eslint_d" },
		typescript = { "prettierd", "eslint_d" },
		typescriptreact = { "prettierd", "eslint_d" },
		html = { "prettierd" },
		css = { "prettierd" },
		json = { "prettierd" },
		nix = { "alejandra" },
		lua = { "stylua" },
	},
})
