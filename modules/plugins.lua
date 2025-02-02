require("modules.plugins.colorizer")
require("modules.plugins.completion")
require("modules.plugins.conform")
require("modules.plugins.cyberdream")
require("modules.plugins.fzf-lua")
require("modules.plugins.gitsigns")
require("modules.plugins.indent-blankline")
require("modules.plugins.lint")
require("modules.plugins.lspconfig")
require("modules.plugins.lualine")
require("modules.plugins.mini")
require("modules.plugins.noice")
require("modules.plugins.todo-comments")
require("modules.plugins.treesitter")

-- plugins without extensive config
require("neogen").setup({})
require("which-key").register({})
require("yazi").setup({ open_for_directories = true })
