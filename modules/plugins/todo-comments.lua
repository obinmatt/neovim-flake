require("todo-comments").setup({})

local map = function(keys, func, desc)
	vim.keymap.set("n", keys, func, { desc = desc })
end

-- stylua: ignore start
map("]t", function() require("todo-comments").jump_next() end, "Next todo")
map("[t", function() require("todo-comments").jump_prev() end, "Prev todo")
map("<leader>ft", function() require("snacks").picker.todo_comments() end, "Find todos")
