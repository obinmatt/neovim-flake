require("solarized-osaka").setup({
	transparent = true, -- Enable this to disable setting the background color
	styles = {
		comments = { italic = true },
		keywords = { italic = false },
		-- Background styles. Can be "dark", "transparent" or "normal"
		sidebars = "transparent",
		floats = "transparent",
	},
})

vim.cmd("colorscheme solarized-osaka")
