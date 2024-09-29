require("incline").setup({
	highlight = {
		groups = {
			InclineNormal = { guibg = "#303270", guifg = "#a9b1d6" },
			InclineNormalNC = { guibg = "none", guifg = "#a9b1d6" },
		},
	},
	hide = { cursorline = true },
	render = function(props)
		local filename = vim.fn.fnamemodify(vim.api.nvim_buf_get_name(props.buf), ":t")
		if filename == "" then
			filename = "[No Name]"
		end
		local ft_icon, ft_color = require("nvim-web-devicons").get_icon_color(filename)
		local modified = vim.bo[props.buf].modified
		return {
			ft_icon and { ft_icon, guifg = ft_color, " " } or "",
			filename,
			modified and " ●" or "",
		}
	end,
})
