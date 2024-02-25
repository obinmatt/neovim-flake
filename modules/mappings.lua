-- ensure leader is mapped
vim.g.mapleader = " "

local keymap = vim.keymap
local opts = { noremap = true, silent = true }
local builtin = require("telescope.builtin")

opts.desc = "Move highlighted line down"
keymap.set("v", "J", ":m '>+1<cr>gv=gv", opts)

opts.desc = "Move highlighted line up"
keymap.set("v", "K", ":m '<-2<cr>gv=gv", opts)

opts.desc = "Select all"
keymap.set("n", "<C-a>", "gg<S-v>G", opts)

opts.desc = "Split window horizontally"
keymap.set("n", "ss", ":split<cr>", opts)

opts.desc = "Split window vertically"
keymap.set("n", "sv", ":vplit<cr>", opts)

opts.desc = "Keep search word centered"
keymap.set("n", "n", "nzzzv", opts)
keymap.set("n", "N", "Nzzzv", opts)

opts.desc = "Rename word"
keymap.set("n", "<leader>s", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]], opts)

opts.desc = "Sort JSON jeys"
keymap.set("n", "<leader>sk", "<cmd>%!jq --sort-keys --indent 4<cr>", opts)

opts.desc = "Toggle lazygit"
keymap.set("n", "<leader>lg", "<cmd>LazyGit<cr>", opts)

opts.desc = "Toggle undotree"
keymap.set("n", "<leader>u", vim.cmd.UndotreeToggle, opts)

opts.desc = "Toggle oil"
keymap.set("n", "<leader>o", "<cmd>Oil<cr>", opts)

opts.desc = "Telescope find files"
keymap.set("n", "<leader>ff", builtin.find_files, opts)

opts.desc = "Telescope live grep"
keymap.set("n", "<leader>fg", builtin.live_grep, opts)

opts.desc = "Telescope search current buffer"
keymap.set("n", "<leader>fs", builtin.current_buffer_fuzzy_find, opts)

opts.desc = "Telescope buffers"
keymap.set("n", "<leader>fb", builtin.buffers, opts)

opts.desc = "Telescope document symbols"
keymap.set("n", "<leader>fd", builtin.lsp_document_symbols, opts)
