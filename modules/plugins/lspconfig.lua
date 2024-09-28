local lspconfig = require("lspconfig")

vim.api.nvim_create_autocmd("LspAttach", {
	group = vim.api.nvim_create_augroup("lsp-attach", { clear = true }),
	callback = function(event)
		local map = function(keys, func, desc)
			vim.keymap.set("n", keys, func, { buffer = event.buf, noremap = true, silent = true, desc = desc })
		end

		map("K", vim.lsp.buf.hover, "Hover Documentation")
		map("<leader>ca", vim.lsp.buf.code_action, "[C]ode [a]ction")
		map("<leader>li", require("telescope.builtin").lsp_implementations, "[L]SP [i]mplementations")
		map("<leader>lt", require("telescope.builtin").lsp_type_definitions, "[L]SP [t]ype definitions")
		map("<leader>ld", require("telescope.builtin").lsp_definitions, "[L]SP [d]efinitions")
		map("<leader>lD", require("telescope.builtin").diagnostics, "[L]SP [D]iagnostics")
		map("<leader>lr", require("telescope.builtin").lsp_references, "[L]SP [r]eferences")
		map("<leader>lR", vim.lsp.buf.rename, "[L]SP [R]ename")

		local client = vim.lsp.get_client_by_id(event.data.client_id)
		if client and client.server_capabilities.documentHighlightProvider then
			vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
				buffer = event.buf,
				callback = vim.lsp.buf.document_highlight,
			})

			vim.api.nvim_create_autocmd({ "CursorMoved", "CursorMovedI" }, {
				buffer = event.buf,
				callback = vim.lsp.buf.clear_references,
			})
		end
	end,
})

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = vim.tbl_deep_extend("force", capabilities, require("cmp_nvim_lsp").default_capabilities())

lspconfig.lua_ls.setup({
	capabilities = capabilities,
	settings = {
		Lua = {
			runtime = { version = "LuaJIT" },
			workspace = {
				checkThirdParty = false,
				library = {
					"${3rd}/luv/library",
					unpack(vim.api.nvim_get_runtime_file("", true)),
				},
			},
			telemetry = { enable = false },
			completion = { callSnippet = "Replace" },
		},
	},
})

lspconfig.nil_ls.setup({ capabilities = capabilities })

local inlayHintsSettings = {
	includeInlayEnumMemberValueHints = true,
	includeInlayFunctionLikeReturnTypeHints = true,
	includeInlayFunctionParameterTypeHints = true,
	includeInlayParameterNameHints = "literals",
	includeInlayParameterNameHintsWhenArgumentMatchesName = false,
	includeInlayPropertyDeclarationTypeHints = true,
	includeInlayVariableTypeHints = false,
	includeInlayVariableTypeHintsWhenTypeMatchesName = false,
}

local function organizeImports()
	local params = {
		command = "_typescript.organizeImports",
		arguments = { vim.api.nvim_buf_get_name(0) },
	}
	vim.lsp.buf.execute_command(params)
end

lspconfig.ts_ls.setup({
	capabilities = capabilities,
	single_file_support = false,
	settings = {
		typescript = { inlayHints = inlayHintsSettings },
		javascript = { inlayHints = inlayHintsSettings },
		completions = { completeFunctionCalls = true },
	},
	commands = {
		OrganizeImports = {
			organizeImports,
			description = "Organize Imports",
		},
	},
})

lspconfig.eslint.setup({ capabilities = capabilities })
lspconfig.jsonls.setup({ capabilities = capabilities })
