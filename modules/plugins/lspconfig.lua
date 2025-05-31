local lspconfig = require("lspconfig")
local snacks = require("snacks")

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
			[vim.diagnostic.severity.HINT] = " ",
		},
	},
	float = { border = "single" },
})

-- default to 'off' to prevent slowdowns with typescript
vim.lsp.set_log_level("off")

vim.api.nvim_create_autocmd("LspAttach", {
	group = vim.api.nvim_create_augroup("lsp-attach", { clear = true }),
	callback = function(event)
		local map = function(keys, func, desc)
			vim.keymap.set("n", keys, func, { buffer = event.buf, desc = desc })
		end

		map("K", vim.lsp.buf.hover, "Hover")
		map("gd", snacks.picker.lsp_definitions, "Goto definition")
		map("gr", snacks.picker.lsp_references, "References")
		map("gI", snacks.picker.lsp_implementations, "Goto Implementation")
		map("gy", snacks.picker.lsp_type_definitions, "Goto T[y]pe Definition")
		map("<leader>ca", vim.lsp.buf.code_action, "Code action")
		map("<leader>cr", vim.lsp.buf.rename, "Rename")
		map("<leader>cR", vim.lsp.buf.rename, "Rename file")

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

		-- resolves a difference between neovim nightly (version 0.11) and stable (version 0.10)
		local function client_supports_method(client, method, bufnr)
			if vim.fn.has("nvim-0.11") == 1 then
				return client:supports_method(method, bufnr)
			else
				return client.supports_method(method, { bufnr = bufnr })
			end
		end

		if client and client_supports_method(client, vim.lsp.protocol.Methods.textDocument_inlayHint, event.buf) then
			map("<leader>th", function()
				vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled({ bufnr = event.buf }))
			end, "Toggle inlay hints")
		end
	end,
})

local capabilities = require("blink.cmp").get_lsp_capabilities()

lspconfig.lua_ls.setup({
	capabilities = capabilities,
	settings = {
		Lua = {
			workspace = {
				checkThirdParty = false,
				library = {
					"${3rd}/luv/library",
					unpack(vim.api.nvim_get_runtime_file("", true)),
				},
			},
			completion = { callSnippet = "Replace" },
			telemetry = { enable = false },
			hint = { enable = true },
		},
	},
})

lspconfig.nil_ls.setup({ capabilities = capabilities })

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
		typescript = vtslsLang,
		javascript = vtslsLang,
	},
	commands = {
		OrganizeImports = {
			function()
				vim.lsp.buf_request(0, "workspace/executeCommand", {
					command = "typescript.organizeImports",
					arguments = { vim.api.nvim_buf_get_name(0) },
				}, function(err)
					if err then
						vim.notify("Failed to organize imports: " .. err.message, vim.log.levels.ERROR)
					else
						vim.notify("Imports organized successfully", vim.log.levels.INFO)
					end
				end)
			end,
			description = "Organize imports",
		},
	},
})
