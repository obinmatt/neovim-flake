local lspconfig = require("lspconfig")
local snacks = require("snacks")

vim.api.nvim_create_autocmd("LspAttach", {
	group = vim.api.nvim_create_augroup("lsp-attach", { clear = true }),
	callback = function(event)
		vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled(), { bufnr = 0 })

		local map = function(keys, func, desc)
			vim.keymap.set("n", keys, func, { buffer = event.buf, noremap = true, silent = true, desc = desc })
		end

		map("K", vim.lsp.buf.hover, "Hover Documentation")
		map("<leader>ca", vim.lsp.buf.code_action, "[C]ode [a]ction")
		map("<leader>li", snacks.picker.lsp_implementations, "[L]SP [i]mplementations")
		map("<leader>lt", snacks.picker.lsp_type_definitions, "[L]SP [t]ype definitions")
		map("<leader>ld", snacks.picker.lsp_definitions, "[L]SP [d]efinitions")
		map("<leader>lD", snacks.picker.diagnostics, "[L]SP [D]iagnostics")
		map("<leader>lr", snacks.picker.lsp_references, "[L]SP [r]eferences")
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

local capabilities = require("blink.cmp").get_lsp_capabilities()

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
			hint = { enable = true },
		},
	},
})

lspconfig.nil_ls.setup({ capabilities = capabilities })

local vtslsLanguage = {
	updateImportsOnFileMove = { enabled = "always" },
	suggest = { completeFunctionCalls = true },
	inlayHints = {
		enumMemberValues = { enabled = true },
		functionLikeReturnTypes = { enabled = true },
		parameterNames = { enabled = "literals" },
		parameterTypes = { enabled = true },
		propertyDeclarationTypes = { enabled = true },
		variableTypes = { enabled = false },
	},
}

lspconfig.vtsls.setup({
	capabilities = capabilities,
	single_file_support = false,
	settings = {
		complete_function_calls = true,
		vtsls = {
			enableMoveToFileCodeAction = true,
			autoUseWorkspaceTsdk = true,
			experimental = {
				maxInlayHintLength = 30,
				completion = { enableServerSideFuzzyMatch = true },
			},
		},
		typescript = vtslsLanguage,
		javascript = vtslsLanguage,
	},
	commands = {
		OrganizeImports = {
			function()
				local params = {
					command = "typescript.organizeImports",
					arguments = { vim.api.nvim_buf_get_name(0) },
				}
				vim.lsp.buf.execute_command(params)
			end,
			description = "Organize Imports",
		},
	},
})
