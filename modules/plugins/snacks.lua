local snacks = require("snacks")

snacks.setup({
	indent = { enabled = true },
	input = { enabled = true },
	notifier = { enabled = true },
	scope = { enabled = true },
	scroll = { enabled = true },
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

local map = function(keys, func, desc)
	vim.keymap.set("n", keys, func, { desc = desc })
end

map("<leader>gg", snacks.lazygit.open, "Toggle lazygit")
map("<leader>ff", snacks.picker.files, "Find files")
map("<leader>fg", snacks.picker.files, "Find grep")
map("<leader><leader>", function()
	snacks.picker.buffers({
		-- start in normal mode
		on_show = function()
			vim.cmd.stopinsert()
		end,
	})
end, "Buffers")
