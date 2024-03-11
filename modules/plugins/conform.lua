require("conform").setup({
	notify_on_error = true,
	format_on_save = {
		timeout_ms = 500,
		lsp_fallback = true,
	},
	formatters_by_ft = {
		javascript = { { "biome", "prettier" } },
		javascriptreact = { { "biome", "prettier" } },
		typescript = { { "biome", "prettier" } },
		typescriptreact = { { "biome", "prettier" } },
		html = { { "biome", "prettier" } },
		css = { { "biome", "prettier" } },
		json = { { "biome", "prettier" } },
		nix = { "alejandra" },
		lua = { "stylua" },
	},
})
