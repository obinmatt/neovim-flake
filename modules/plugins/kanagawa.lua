require("kanagawa").setup({
	transparent = true,
	keywordStyle = { italic = false },
	overrides = function(colors)
		local theme = colors.theme
		return {
			-- transparent floating windows
			NormalFloat = { bg = "none" },
			NormalDark = { fg = theme.ui.fg_dim, bg = theme.ui.bg_m3 },
			FloatBorder = { bg = "none" },
			FloatTitle = { bg = "none" },
			-- telescope
			TelescopePromptBorder = { bg = theme.ui.bg_dim },
			TelescopeResultsBorder = { bg = theme.ui.bg_dim },
			TelescopePreviewBorder = { bg = theme.ui.bg_dim },
		}
	end,
})

vim.cmd("colorscheme kanagawa")
