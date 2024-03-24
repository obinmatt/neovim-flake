-- ensure leader is mapped
vim.g.mapleader = " "
vim.g.maplocalleader = " "

local mapn = function(keys, func, desc)
	vim.keymap.set("n", keys, func, { noremap = true, silent = true, desc = desc })
end

local mapv = function(keys, func, desc)
	vim.keymap.set("v", keys, func, { noremap = true, silent = true, desc = desc })
end

mapn("<leader>o", "<cmd>Oil<cr>", "Toggle oil")
mapn("<leader>a", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]], "Rename word under cursor")
mapn("<leader>ss", "<cmd>split<cr>", "Split window horizontally")
mapn("<leader>sv", "<cmd>vsplit<cr>", "Split window vertically")
mapn("<leader>sk", "<cmd>%!jq --sort-keys --indent 4<cr>", "Sort JSON jeys using jq")
mapn("<leader>gg", "<cmd>LazyGit<cr>", "Toggle lazygit")
mapn("<leader>n", "<cmd>Neogen<cr>", "Toggle neogen")
mapn("<leader>u", vim.cmd.UndotreeToggle, "Toggle undotree")
mapn("<leader>e", vim.diagnostic.open_float, "Show diagnostic error messages")
mapn("<leader>q", vim.diagnostic.setloclist, "Open diagnostic quickfix list")
mapn("<C-a>", "gg<S-v>G", "Select all in current buffer")
mapn("<C-h>", "<C-w><C-h>", "Move focus to the left window")
mapn("<C-l>", "<C-w><C-l>", "Move focus to the right window")
mapn("<C-j>", "<C-w><C-j>", "Move focus to the lower window")
mapn("<C-k>", "<C-w><C-k>", "Move focus to the upper window")
mapn("[d", vim.diagnostic.goto_prev, "Go to previous diagnostic message")
mapn("]d", vim.diagnostic.goto_next, "Go to next diagnostic message")
mapn("n", "nzzzv", "Keep search word centered")
mapn("N", "Nzzzv", "Keep search word centered")

mapv("J", ":m '>+1<cr>gv=gv", "Move highlighted line down")
mapv("K", ":m '<-2<cr>gv=gv", "Move highlighted line up")
