require("modules.plugins.lualine")
require("modules.plugins.telescope")
require("modules.plugins.treesitter")
require("modules.plugins.lspconfig")
require("modules.plugins.completion")
require("modules.plugins.autopairs")
require("modules.plugins.conform")
require("modules.plugins.comment")
require("modules.plugins.colorizer")

-- plugins without extensive config
require("oil").setup({})
require("which-key").register({})
require("todo-comments").setup({})
require("dressing").setup({})
require("gitsigns").setup({
	current_line_blame = true,
})

-- use notify for notifications
vim.notify = require("notify")
