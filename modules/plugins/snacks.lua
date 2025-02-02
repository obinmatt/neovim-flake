local snacks = require("snacks")

snacks.setup({
	indent = { enabled = true },
	input = { enabled = true },
	notifier = { enabled = true },
	scope = { enabled = true },
	scroll = { enabled = true },
	toggle = { enabled = true },
	bigfile = { enabled = true },
	lazygit = { enabled = true },
	dashboard = {
		enabled = true,
		sections = {
			{ section = "header" },
			{ section = "keys", gap = 1, padding = 1 },
		},
	},
})

vim.keymap.set("n", "<leader>gg", snacks.lazygit.open, { noremap = true, silent = true, desc = "Toggle Lazygit" })
