-- enable line numbers
vim.opt.number = true
vim.opt.relativenumber = true

-- no need as its shown in the status line
vim.opt.showmode = false

-- share clipboard with system
vim.opt.clipboard = "unnamedplus"

-- enable breakindent
vim.opt.breakindent = true

-- keep undo history
vim.opt.undofile = true
vim.opt.undodir = os.getenv("HOME") .. "/.vim/undodir"

-- set tab to be spaces of 4 characters
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.softtabstop = 4

-- smarter tab behaviour
vim.opt.expandtab = true
vim.opt.smarttab = true

-- auto indent to same level as previous line
vim.opt.autoindent = true
vim.opt.smartindent = true

-- case-insensitive searching UNLESS \C or capital in search
vim.opt.ignorecase = true
vim.opt.smartcase = true

-- keep signcolumn on by default
vim.opt.signcolumn = "yes"

-- decrease update time
vim.opt.updatetime = 250
vim.opt.timeoutlen = 300

-- configure how window splits should be opened
vim.opt.splitright = true
vim.opt.splitbelow = true
vim.opt.splitkeep = "cursor"

-- sets how the editor will display certain whitespace characters
vim.opt.list = true
vim.opt.listchars = { tab = "» ", trail = "·", nbsp = "␣" }

-- preview substitutions live
vim.opt.inccommand = "split"

-- show which line your cursor is on
vim.opt.cursorline = true

-- minimal number of screen lines to keep above and below the cursor
vim.opt.scrolloff = 10

-- spellchecking
vim.opt.spell = true
vim.opt.spelllang = "en"
vim.opt.spelloptions = "camel"

-- disable line wrapping
vim.opt.wrap = false

-- when finding files search down into subfolders
vim.opt.path:append({ "**" })

-- cmd line completion
vim.opt.wildmenu = true
vim.opt.wildmode = "list:longest"

-- backup file during edit, delete after
vim.opt.backup = false
vim.opt.writebackup = true

-- auto load files when changed outside of editor
vim.opt.autoread = true

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
