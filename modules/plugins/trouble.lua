require("trouble").setup({ focus = true })

local map = function(keys, func, desc)
	vim.keymap.set("n", keys, func, { desc = desc })
end

-- stylua: ignore start
map("<leader>xx", "<cmd>Trouble diagnostics toggle<cr>", "Diagnostics (Trouble)")
map("<leader>xX", "<cmd>Trouble diagnostics toggle filter.buf=0<cr>", "Buffer Diagnostics (Trouble)")
map("<leader>cs", "<cmd>Trouble symbols toggle focus=false<cr>", "Symbols (Trouble)")
map("<leader>cl", "<cmd>Trouble lsp toggle focus=false win.position=right<cr>", "LSP Definitions / references / ... (Trouble)")
map("<leader>xL", "<cmd>Trouble loclist toggle<cr>", "Location List (Trouble)")
map("<leader>xQ", "<cmd>Trouble qflist toggle<cr>", "Quickfix List (Trouble)")
