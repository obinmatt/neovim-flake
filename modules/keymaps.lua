-- ensure leader is mapped
vim.g.mapleader = " "
vim.g.maplocalleader = " "

local keymap = vim.keymap
local opts = { noremap = true, silent = true }

opts.desc = "Move highlighted line down"
keymap.set("v", "J", ":m '>+1<cr>gv=gv", opts)

opts.desc = "Move highlighted line up"
keymap.set("v", "K", ":m '<-2<cr>gv=gv", opts)

opts.desc = "Keep search word centered"
keymap.set("n", "n", "nzzzv", opts)
keymap.set("n", "N", "Nzzzv", opts)

opts.desc = "Split window horizontally"
keymap.set("n", "<leader>ss", ":split<cr>", opts)

opts.desc = "Split window vertically"
keymap.set("n", "<leader>sv", ":vsplit<cr>", opts)

opts.desc = "Rename word under cursor"
keymap.set("n", "<leader>s", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]], opts)

opts.desc = "Sort JSON jeys using jq"
keymap.set("n", "<leader>sk", "<cmd>%!jq --sort-keys --indent 4<cr>", opts)

opts.desc = "Toggle lazygit"
keymap.set("n", "<leader>gg", "<cmd>LazyGit<cr>", opts)

opts.desc = "Toggle undotree"
keymap.set("n", "<leader>u", vim.cmd.UndotreeToggle, opts)

opts.desc = "Toggle oil"
keymap.set("n", "<leader>o", "<cmd>Oil<cr>", opts)

opts.desc = "Show diagnostic error messages"
keymap.set("n", "<leader>e", vim.diagnostic.open_float, opts)

opts.desc = "Open diagnostic quickfix list"
keymap.set("n", "<leader>q", vim.diagnostic.setloclist, opts)

opts.desc = "Go to previous diagnostic message"
keymap.set("n", "[d", vim.diagnostic.goto_prev, opts)

opts.desc = "Go to next diagnostic message"
keymap.set("n", "]d", vim.diagnostic.goto_next, opts)

opts.desc = "Select all in current buffer"
keymap.set("n", "<C-a>", "gg<S-v>G", opts)

opts.desc = "Move focus to the left window"
keymap.set("n", "<C-h>", "<C-w><C-h>", opts)

opts.desc = "Move focus to the right window"
keymap.set("n", "<C-l>", "<C-w><C-l>", opts)

opts.desc = "Move focus to the lower window"
keymap.set("n", "<C-j>", "<C-w><C-j>", opts)

opts.desc = "Move focus to the upper window"
keymap.set("n", "<C-k>", "<C-w><C-k>", opts)
