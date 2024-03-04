require("modules.plugins.telescope")
require("modules.plugins.treesitter")
require("modules.plugins.lspconfig")
require("modules.plugins.completion")
require("modules.plugins.increname")
require("modules.plugins.illuminate")
require("modules.plugins.gitsigns")
require("modules.plugins.conform")
require("modules.plugins.colorizer")
require("modules.plugins.spectre")
require("modules.plugins.fidget")
require("modules.plugins.flash")
require("modules.plugins.ibl")
require("modules.plugins.mini")

-- plugins without extensive config
require("oil").setup({})
require("dressing").setup({})
require("which-key").register({})
require("todo-comments").setup({})
require("ts_context_commentstring").setup({
	enable_autocmd = false,
})
