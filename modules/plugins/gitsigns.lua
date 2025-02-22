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
			vim.keymap.set("n", keys, func, { buffer = buffer, desc = desc })
		end

		-- stylua: ignore start
		map("]h", function()
			if vim.wo.diff then
				vim.cmd.normal({ "]c", bang = true })
			else
				gs.nav_hunk("next")
			end
		end, "Next hunk")
		map("[h", function()
			if vim.wo.diff then
				vim.cmd.normal({ "[c", bang = true })
			else
				gs.nav_hunk("prev")
			end
		end, "Prev hunk")
		map("<leader>ghr", gs.reset_hunk, "Reset Hunk")
		map("<leader>ghR", gs.reset_buffer, "Reset buffer")
		map("<leader>ghp", gs.preview_hunk_inline, "Preview hunk inline")
		map("<leader>ghb", function() gs.blame_line({ full = true }) end, "Blame line")
		map("<leader>ghB", function() gs.blame() end, "Blame buffer")
		map("<leader>ghd", gs.diffthis, "Diff this")
		map("<leader>ghD", function() gs.diffthis("~") end, "Diff this ~")
	end,
})
