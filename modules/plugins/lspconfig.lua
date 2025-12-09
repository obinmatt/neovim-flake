-- default to 'off' to prevent slowdowns with typescript
vim.lsp.set_log_level("off")

vim.diagnostic.config({
	underline = true,
	update_in_insert = false,
	virtual_text = {
		spacing = 4,
		source = "if_many",
		prefix = "●",
	},
	severity_sort = true,
	signs = {
		text = {
			[vim.diagnostic.severity.ERROR] = " ",
			[vim.diagnostic.severity.WARN] = " ",
			[vim.diagnostic.severity.INFO] = " ",
			[vim.diagnostic.severity.HINT] = "",
		},
	},
	float = { border = "single" },
})

vim.api.nvim_create_autocmd("LspAttach", {
	group = vim.api.nvim_create_augroup("lsp-attach", { clear = true }),
	callback = function(event)
		local map = function(keys, func, desc)
			vim.keymap.set("n", keys, func, { buffer = event.buf, desc = desc })
		end

		map("K", vim.lsp.buf.hover, "Hover")
		map("gd", require("snacks").picker.lsp_definitions, "Goto definition")
		map("gr", require("snacks").picker.lsp_references, "References")
		map("gI", require("snacks").picker.lsp_implementations, "Goto implementation")
		map("gy", require("snacks").picker.lsp_type_definitions, "Goto type definition")
		map("<leader>ca", vim.lsp.buf.code_action, "Code action")
		map("<leader>cr", vim.lsp.buf.rename, "Rename")
		map("<leader>cR", vim.lsp.buf.rename, "Rename file")
		map("<leader>co", function()
			vim.lsp.buf.code_action({
				apply = true,
				context = {
					only = { "source.organizeImports" },
					diagnostics = {},
				},
			})
		end, "Organize imports")

		local client = vim.lsp.get_client_by_id(event.data.client_id)

		-- modify the config to achieve a single border
		local single_border_handler = function(err, result, ctx, config)
			config.border = "single"
			vim.lsp.handlers.default_handler(err, result, ctx, config)
		end
		if client and client.server_capabilities.hover_provider then
			client.handlers["textDocument/hover"] = single_border_handler
		end
		if client and client.server_capabilities.signature_help_provider then
			client.handlers["textDocument/signatureHelp"] = single_border_handler
		end

		if client and client:supports_method(vim.lsp.protocol.Methods.textDocument_inlayHint, event.buf) then
			map("<leader>th", function()
				vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled({ bufnr = event.buf }))
			end, "Toggle inlay hints")
		end
	end,
})

local capabilities = require("blink.cmp").get_lsp_capabilities()

vim.lsp.config("lua_ls", {
	capabilities = capabilities,
	settings = {
		Lua = {
			workspace = { checkThirdParty = false },
			completion = { callSnippet = "Replace" },
			telemetry = { enable = false },
			hint = { enable = true },
		},
	},
})
vim.lsp.enable("lua_ls")

vim.lsp.config("nil_ls", { capabilities = capabilities })
vim.lsp.enable("nil_ls")

local vtslsLang = {
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

vim.lsp.config("vtsls", {
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
		typescript = vtslsLang,
		javascript = vtslsLang,
	},
})
vim.lsp.enable("vtsls")
