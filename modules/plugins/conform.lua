require("conform").setup({
	notify_on_error = true,
	format_on_save = {
		timeout_ms = 500,
		lsp_fallback = true,
	},
	formatters_by_ft = {
		javascript = { { "prettier" } },
		javascriptreact = { { "prettier" } },
		typescript = { { "prettier" } },
		typescriptreact = { { "prettier" } },
		html = { { "prettier" } },
		css = { { "prettier" } },
		json = { { "prettier" } },
		nix = { "alejandra" },
		lua = { "stylua" },
	},
})
