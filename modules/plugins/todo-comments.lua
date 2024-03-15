require("todo-comments").setup({})

local map = function(keys, func, desc)
	vim.keymap.set("n", keys, func, { noremap = true, silent = true, desc = desc })
end

-- stylua: ignore start
map("]t", function() require("todo-comments").jump_next() end, "Next todo comment")
map("[t", function() require("todo-comments").jump_prev() end, "Previous todo comment")
map("<leader>ft", "<cmd>TodoTelescope<cr>", "Telescope todo")
map("<leader>fT", "<cmd>TodoTelescope keywords=TODO,FIX,FIXME<cr>", "Telescope todo/fix/fixme")
