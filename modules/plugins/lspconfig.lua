local lspconfig = require("lspconfig")
local cmp_nvim_lsp = require("cmp_nvim_lsp")

-- this function will run when an LSP connects to a buffer
local on_attach = function(_, bufnr)
	local function buf_set_keymap(...)
		vim.api.nvim_buf_set_keymap(bufnr, ...)
	end
	local function buf_set_option(...)
		vim.api.nvim_buf_set_option(bufnr, ...)
	end

	buf_set_option("formatexpr", "v:lua.vim.lsp.formatexpr()")
	buf_set_option("omnifunc", "v:lua.vim.lsp.omnifunc")
	buf_set_option("tagfunc", "v:lua.vim.lsp.tagfunc")

	local opts = { noremap = true, silent = true }

	opts.desc = "Show documentation for what is under cursor"
	buf_set_keymap("n", "K", "<cmd>lua vim.lsp.buf.hover()<cr>", opts)

	opts.desc = "Show available code actions"
	buf_set_keymap("n", "<space>ca", "<cmd>lua vim.lsp.buf.code_action()<cr>", opts)

	opts.desc = "Show LSP implementations"
	buf_set_keymap("n", "<space>li", "<cmd>lua require('telescope.builtin').lsp_implementations()<cr>", opts)

	opts.desc = "Show LSP type definitions"
	buf_set_keymap("n", "<space>lt", "<cmd>lua require('telescope.builtin').lsp_type_definitions()<cr>", opts)

	opts.desc = "Show LSP definitions"
	buf_set_keymap("n", "<space>ld", "<cmd>lua require('telescope.builtin').lsp_definitions()<cr>", opts)

	opts.desc = "Show LSP diagnostics"
	buf_set_keymap("n", "<space>lD", "<cmd>lua require('telescope.builtin').diagnostics()<cr>", opts)

	opts.desc = "Show LSP references"
	buf_set_keymap("n", "<space>lr", "<cmd>lua require('telescope.builtin').lsp_references()<cr>", opts)

	opts.desc = "Toggle LSP rename"
	buf_set_keymap("n", "<space>lR", "<cmd>lua vim.lsp.buf.rename()<cr>", opts)

	opts.desc = "Go to previous diagnostic"
	buf_set_keymap("n", "[d", "<cmd>lua vim.diagnostic.goto_prev()<cr>", opts)

	opts.desc = "Go to next diagnostic"
	buf_set_keymap("n", "]d", "<cmd>lua vim.diagnostic.goto_next()<cr>", opts)
end

-- broadcast that nvim-cmp supports additional completion capabilities
local capabilities =
	vim.tbl_extend("keep", vim.lsp.protocol.make_client_capabilities(), cmp_nvim_lsp.default_capabilities())

-- configure lua server
lspconfig.lua_ls.setup({
	on_attach = on_attach,
	capabilities = capabilities,
	single_file_support = true,
	settings = {
		Lua = {
			runtime = { version = "LuaJIT" },
			-- get the language server to recognize the 'vim' global
			diagnostics = { globals = { "vim", "string", "require" } },
			workspace = { checkThirdParty = false },
			telemetry = { enable = false },
			completion = { enable = true, callSnippet = "Replace" },
		},
	},
})

-- configure nix server
lspconfig.nil_ls.setup({
	on_attach = on_attach,
	capabilities = capabilities,
})

-- function to organize imports using tsserver
local function organizeImports()
	local params = {
		command = "_typescript.organizeImports",
		arguments = { vim.api.nvim_buf_get_name(0) },
	}
	vim.lsp.buf.execute_command(params)
end

-- configure typescript server
lspconfig.tsserver.setup({
	on_attach = on_attach,
	capabilities = capabilities,
	single_file_support = false,
	settings = {
		typescript = {
			completions = {
				completeFunctionCalls = true,
			},
		},
	},
	commands = {
		OrganizeImports = {
			organizeImports,
			description = "Organize Imports",
		},
	},
})
