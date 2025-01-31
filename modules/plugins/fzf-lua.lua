local fzf_lua = require("fzf-lua")
fzf_lua.setup({})

-- register fzf-lua as vim.ui.select interface
fzf_lua.register_ui_select(function(o, items)
	local min_h, max_h = 0.15, 0.70
	local preview = o.kind == "codeaction" and 0.20 or 0
	local h = (#items + 4) / vim.o.lines + preview
	if h < min_h then
		h = min_h
	elseif h > max_h then
		h = max_h
	end
	return { winopts = { height = h, width = 0.60, row = 0.40 } }
end)

local map = function(keys, func, desc)
	vim.keymap.set("n", keys, func, { noremap = true, silent = true, desc = desc })
end

map("<leader><leader>", fzf_lua.buffers, "Buffers")
map("<leader>fd", fzf_lua.lsp_document_symbols, "Document symbols")
map("<leader>ff", fzf_lua.files, "Find files")
map("<leader>fg", fzf_lua.live_grep, "Live grep")
map("<leader>fk", fzf_lua.keymaps, "Keymaps")
