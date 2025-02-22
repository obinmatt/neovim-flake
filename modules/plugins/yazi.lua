require("yazi").setup({ open_for_directories = true })

vim.keymap.set({ "n", "v" }, "<leader>y", "<cmd>Yazi<cr>", { desc = "File explorer" })
