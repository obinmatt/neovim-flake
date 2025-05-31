require("conform").setup({
	notify_on_error = true,
	format_on_save = {
		timeout_ms = 1000,
		lsp_format = "fallback",
		stop_after_first = true,
	},
	formatters_by_ft = {
		javascript = { "prettierd", "prettier" },
		javascriptreact = { "prettierd", "prettier" },
		typescript = { "prettierd", "prettier" },
		typescriptreact = { "prettierd", "prettier" },
		html = { "prettierd", "prettier" },
		css = { "prettierd", "prettier" },
		json = { "prettierd", "prettier" },
		nix = { "alejandra" },
		lua = { "stylua" },
	},
})
