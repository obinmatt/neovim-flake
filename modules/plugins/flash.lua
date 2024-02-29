require("flash").setup({})

local keymap = vim.keymap
local opts = { noremap = true, silent = true }

opts.desc = "Toggle flash search"
keymap.set("c", "<c-s>", "<cmd>lua require('flash').toggle()<cr>", opts)
