local snacks = require("snacks")

snacks.setup({
	bigfile = { enabled = true },
	dashboard = {
		enabled = true,
		sections = {
			{ section = "header" },
			{ section = "keys", gap = 1, padding = 1 },
		},
	},
	indent = { enabled = true },
	input = { enabled = true },
	notifier = {
		enabled = true,
		timeout = 3000,
	},
	picker = {
		enabled = true,
		matcher = { frecency = true },
	},
	scope = { enabled = true },
	scroll = { enabled = true },
	lazygit = { enabled = true },
	zen = { enabled = true },
})

local map = function(keys, func, desc)
	vim.keymap.set("n", keys, func, { desc = desc })
end

-- stylua: ignore start
map("<leader>ff", snacks.picker.files, "Find files (cwd)")
map("<leader>fF", function() snacks.picker.files({ cwd = vim.fn.expand('%:p:h') }) end, "Find files (buffer dir)")
map("<leader>fr", snacks.picker.recent, "Find recent")
map("<leader>fg", snacks.picker.grep, "Find grep (cwd)")
map("<leader>fG", function() snacks.picker.grep({ cwd = vim.fn.expand('%:p:h') }) end, "Find grep (buffer dir)")
map("<leader>gg", snacks.lazygit.open, "Lazygit")
map("<leader>z", snacks.zen.zen, "Zen mode")
map("<leader><leader>", function()
	snacks.picker.buffers({
		-- start in normal mode
		on_show = function()
			vim.cmd.stopinsert()
		end,
	})
end, "Buffers")
