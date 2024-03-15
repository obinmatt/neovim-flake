require("gitsigns").setup({
	signs = {
		add = { text = "+" },
		change = { text = "~" },
		delete = { text = "_" },
		topdelete = { text = "‾" },
		changedelete = { text = "~" },
	},
	current_line_blame = true,
	on_attach = function(buffer)
		local gs = package.loaded.gitsigns

		local map = function(keys, func, desc)
			vim.keymap.set("n", keys, func, { buffer = buffer, noremap = true, silent = true, desc = desc })
		end

        -- stylua: ignore start
        map("]h", gs.next_hunk, "Next Hunk")
        map("[h", gs.prev_hunk, "Prev Hunk")
        map("<leader>ghr", gs.reset_buffer, "Reset Buffer")
        map("<leader>ghp", gs.preview_hunk_inline, "Preview Hunk Inline")
        map("<leader>ghd", gs.diffthis, "Diff This")
        map("<leader>ghD", function() gs.diffthis("~") end, "Diff This ~")
	end,
})
