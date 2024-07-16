require("modules.plugins.colorizer")
require("modules.plugins.completion")
require("modules.plugins.conform")
require("modules.plugins.fidget")
require("modules.plugins.gitsigns")
require("modules.plugins.indent-blankline")
require("modules.plugins.lint")
require("modules.plugins.lspconfig")
require("modules.plugins.mini")
require("modules.plugins.solarized-osaka")
require("modules.plugins.telescope")
require("modules.plugins.todo-comments")
require("modules.plugins.treesitter")

-- plugins without extensive config
require("oil").setup({})
require("neogen").setup({})
require("which-key").register({})
