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
	picker = {
		enabled = true,
		matcher = { frecency = true },
	},
})

local mapn = function(keys, func, desc)
	vim.keymap.set("n", keys, func, { noremap = true, silent = true, desc = desc })
end

mapn("<leader>gg", snacks.lazygit.open, "Toggle Lazygit")
mapn("<leader>ff", snacks.picker.files, "Find Files")
mapn("<leader>fg", snacks.picker.grep, "Grep")
mapn("<leader><leader>", function()
	snacks.picker.buffers({
		-- start in normal mode
		on_show = function()
			vim.cmd.stopinsert()
		end,
	})
end, "Buffers")
