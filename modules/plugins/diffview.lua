local map = function(keys, func, desc)
	vim.keymap.set("n", keys, func, { desc = desc })
end

-- stylua: ignore start
map("<leader>gdv", "<cmd>DiffviewOpen<cr>", "Diffview")
map("<leader>gdc", "<cmd>DiffviewClose<cr>", "Close diffview")
map("<leader>gdt", "<cmd>DiffviewToggleFiles<cr>", "Toggle diffview files")
map("<leader>gdr", "<cmd>DiffviewRefresh<cr>", "Refresh diffview")
