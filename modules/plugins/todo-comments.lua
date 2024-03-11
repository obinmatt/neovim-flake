require("todo-comments").setup({})

local keymap = vim.keymap
local opts = { noremap = true, silent = true }

opts.desc = "Next todo comment"
keymap.set("n", "]t", function()
	require("todo-comments").jump_next()
end, opts)

opts.desc = "Previous todo comment"
keymap.set("n", "[t", function()
	require("todo-comments").jump_prev()
end, opts)

opts.desc = "Telescope todo"
keymap.set("n", "<leader>ft", "<cmd>TodoTelescope<cr>", opts)

opts.desc = "Telescope todo/fix/fixme"
keymap.set("n", "<leader>ft", "<cmd>TodoTelescope keywords=TODO,FIX,FIXME<cr>", opts)
