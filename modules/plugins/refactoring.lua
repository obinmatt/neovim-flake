require("refactoring").setup({ show_success_message = true })

-- load refactoring Telescope extension
require("telescope").load_extension("refactoring")
local telescopeRefactors = function()
	require("telescope").extensions.refactoring.refactors()
end

vim.keymap.set(
	{ "n", "x" },
	"<leader>rr",
	telescopeRefactors,
	{ noremap = true, silent = true, desc = "Toggle refactoring" }
)
