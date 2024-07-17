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
		}
	end,
})

vim.cmd("colorscheme kanagawa")
vim.cmd("highlight TelescopeBorder guibg=none")
vim.cmd("highlight TelescopeTitle guibg=none")
