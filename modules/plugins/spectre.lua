require("spectre").setup({})

local keymap = vim.keymap
local opts = { noremap = true, silent = true }

opts.desc = "Replace in files (Spectre)"
keymap.set("n", "<leader>sr", "<cmd>lua require('spectre').open()<cr>", opts)
