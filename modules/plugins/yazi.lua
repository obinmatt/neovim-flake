require("yazi").setup({ open_for_directories = true })

vim.keymap.set({ "n", "v" }, "<leader>e", "<cmd>Yazi<cr>", { desc = "File explorer" })
