vim.opt.title = true
vim.opt.colorcolumn = "80"

vim.opt.nu = true
vim.opt.relativenumber = true

vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4

vim.opt.smarttab = true
vim.opt.expandtab = true

vim.opt.autoindent = true
vim.opt.smartindent = true

vim.opt.wrap = false
vim.opt.backspace = { "start", "eol", "indent" }

vim.opt.swapfile = false
vim.opt.backup = false

-- keep undo history
vim.opt.undodir = os.getenv("HOME") .. "/.vim/undodir"
vim.opt.undofile = true

vim.opt.hlsearch = false
vim.opt.incsearch = true

vim.opt.termguicolors = true
vim.opt.updatetime = 50

vim.opt.scrolloff = 8
vim.opt.signcolumn = "yes"
vim.opt.isfname:append("@-@")

vim.opt.spell = true
vim.opt.spelllang = "en"
vim.opt.spelloptions = "camel"

vim.opt.splitbelow = true
vim.opt.splitright = true
vim.opt.splitkeep = "cursor"

-- share with system
vim.opt.clipboard = "unnamedplus"

-- color scheme
require("catppuccin").setup({
	flavour = "mocha",
	transparent_background = true,
	styles = {
		conditionals = {},
	},
	integrations = {
		notify = true,
	},
})

vim.cmd("colorscheme catppuccin")
