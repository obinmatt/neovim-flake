require("modules.plugins.telescope")
require("modules.plugins.treesitter")
require("modules.plugins.lspconfig")
require("modules.plugins.completion")
require("modules.plugins.gitsigns")
require("modules.plugins.conform")
require("modules.plugins.colorizer")
require("modules.plugins.spectre")
require("modules.plugins.flash")
require("modules.plugins.illuminate")
require("modules.plugins.ibl")

-- mini.nvim
require("mini.pairs").setup({})
require("mini.surround").setup({})
require("mini.comment").setup({
	custom_commentstring = function()
		return require("ts_context_commentstring.internal").calculate_commentstring() or vim.bo.commentstring
	end,
})
require("modules.plugins.indentscope")

-- plugins without extensive config
require("oil").setup({})
require("lualine").setup({})
require("which-key").register({})
require("dressing").setup({})
require("todo-comments").setup({})
require("ts_context_commentstring").setup({
	enable_autocmd = false,
})

-- use notify for notifications
vim.notify = require("notify")
