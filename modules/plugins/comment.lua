local ts_context_commentstring = require("ts_context_commentstring.integrations.comment_nvim")

require("Comment").setup({
	-- for commenting tsx and jsx files
	pre_hook = ts_context_commentstring.create_pre_hook(),
})
