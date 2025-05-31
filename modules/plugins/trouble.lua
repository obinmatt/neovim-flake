require("trouble").setup({ focus = true })

local map = function(keys, func, desc)
	vim.keymap.set("n", keys, func, { desc = desc })
end

-- stylua: ignore start
map("<leader>xx", "<cmd>Trouble diagnostics toggle<cr>", "Diagnostics (trouble)")
map("<leader>xX", "<cmd>Trouble diagnostics toggle filter.buf=0<cr>", "Buffer diagnostics (trouble)")
map("<leader>cs", "<cmd>Trouble symbols toggle focus=false<cr>", "Symbols (trouble)")
map("<leader>cl", "<cmd>Trouble lsp toggle focus=false win.position=right<cr>", "LSP definitions / references / ... (trouble)")
map("<leader>xL", "<cmd>Trouble loclist toggle<cr>", "Location list (trouble)")
map("<leader>xQ", "<cmd>Trouble qflist toggle<cr>", "Quickfix list (trouble)")
