require("fzf-lua").setup({})

local map = function(keys, func, desc)
	vim.keymap.set("n", keys, func, { noremap = true, silent = true, desc = desc })
end

map("<leader><leader>", require("fzf-lua").buffers, "Buffers")
map("<leader>fd", require("fzf-lua").lsp_document_symbols, "Document symbols")
map("<leader>ff", require("fzf-lua").files, "Find files")
map("<leader>fg", require("fzf-lua").live_grep, "Live grep")
map("<leader>fk", require("fzf-lua").keymaps, "Keymaps")
