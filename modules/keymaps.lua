-- ensure leader is mapped
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- diagnostics
local diagnostic_goto = function(next, severity)
	local go = next and vim.diagnostic.goto_next or vim.diagnostic.goto_prev
	severity = severity and vim.diagnostic.severity[severity] or nil
	return function()
		go({ severity = severity })
	end
end
vim.keymap.set("n", "<leader>cd", vim.diagnostic.open_float, { desc = "Line diagnostics" })
vim.keymap.set("n", "]d", diagnostic_goto(true), { desc = "Next diagnostic" })
vim.keymap.set("n", "[d", diagnostic_goto(false), { desc = "Prev diagnostic" })
vim.keymap.set("n", "]e", diagnostic_goto(true, "ERROR"), { desc = "Next error" })
vim.keymap.set("n", "[e", diagnostic_goto(false, "ERROR"), { desc = "Prev error" })
vim.keymap.set("n", "]w", diagnostic_goto(true, "WARN"), { desc = "Next warning" })
vim.keymap.set("n", "[w", diagnostic_goto(false, "WARN"), { desc = "Prev warning" })

-- windows
vim.keymap.set("n", "<leader>-", "<C-W>s", { desc = "Split window below", remap = true })
vim.keymap.set("n", "<leader>|", "<C-W>v", { desc = "Split window right", remap = true })
vim.keymap.set("n", "<leader>wd", "<C-W>c", { desc = "Delete window", remap = true })
vim.keymap.set("n", "<C-h>", "<C-w>h", { desc = "Go to left window", remap = true })
vim.keymap.set("n", "<C-j>", "<C-w>j", { desc = "Go to lower window", remap = true })
vim.keymap.set("n", "<C-k>", "<C-w>k", { desc = "Go to upper window", remap = true })
vim.keymap.set("n", "<C-l>", "<C-w>l", { desc = "Go to right window", remap = true })

-- https://github.com/mhinz/vim-galore#saner-behavior-of-n-and-n
vim.keymap.set("n", "n", "'Nn'[v:searchforward].'zv'", { expr = true, desc = "Next search result" })
vim.keymap.set("x", "n", "'Nn'[v:searchforward]", { expr = true, desc = "Next search result" })
vim.keymap.set("o", "n", "'Nn'[v:searchforward]", { expr = true, desc = "Next search result" })
vim.keymap.set("n", "N", "'nN'[v:searchforward].'zv'", { expr = true, desc = "Prev search result" })
vim.keymap.set("x", "N", "'nN'[v:searchforward]", { expr = true, desc = "Prev search result" })
vim.keymap.set("o", "N", "'nN'[v:searchforward]", { expr = true, desc = "Prev search result" })

-- misc
vim.keymap.set("n", "<C-a>", "gg<S-v>G", { desc = "Select all in current buffer" })
vim.keymap.set("n", "<leader>u", vim.cmd.UndotreeToggle, { desc = "Open undotree" })
vim.keymap.set("n", "<leader>sk", "<cmd>%!jq --sort-keys --indent 4<cr>", { desc = "Sort JSON jeys" })
