local cmp = require("cmp")
local luasnip = require("luasnip")
local lspkind = require("lspkind")

local winhighlight = {
	winhighlight = "Normal:NormalFloat,FloatBorder:FloatBorder,CursorLine:PmenuSel",
}

require("luasnip.loaders.from_vscode").lazy_load()
luasnip.config.setup({})

cmp.setup({
	enabled = function()
		local context = require("cmp.config.context")
		local buftype = vim.api.nvim_buf_get_option(0, "buftype")
		-- prevent completions in prompts like telescope prompt
		if buftype == "prompt" then
			return false
		end
		-- prevent completions in comments
		return not context.in_treesitter_capture("comment") and not context.in_syntax_group("Comment")
	end,
	completion = {
		completeopt = "menu,menuone,noselect",
	},
	window = {
		completion = cmp.config.window.bordered(winhighlight),
		documentation = cmp.config.window.bordered(winhighlight),
	},
	snippet = {
		expand = function(args)
			luasnip.lsp_expand(args.body)
		end,
	},
	mapping = cmp.mapping.preset.insert({
		["<C-n>"] = cmp.mapping.select_next_item(),
		["<C-p>"] = cmp.mapping.select_prev_item(),
		["<C-y>"] = cmp.mapping.confirm({ select = true }),
		["<C-Space>"] = cmp.mapping.complete({}),
		["<C-l>"] = cmp.mapping(function()
			if luasnip.expand_or_locally_jumpable() then
				luasnip.expand_or_jump()
			end
		end, { "i", "s" }),
		["<C-h>"] = cmp.mapping(function()
			if luasnip.locally_jumpable(-1) then
				luasnip.jump(-1)
			end
		end, { "i", "s" }),
	}),
	sources = cmp.config.sources({
		{ name = "nvim_lsp" },
		{ name = "luasnip", max_item_count = 3 },
		{ name = "buffer", max_item_count = 5 },
		{ name = "path", max_item_count = 3 },
	}),
	formatting = {
		format = lspkind.cmp_format({
			mode = "symbol_text",
		}),
	},
})
