return {
	-- Highlight, edit, and navigate code
	"nvim-treesitter/nvim-treesitter",
	dependencies = {
		"nvim-treesitter/nvim-treesitter-textobjects",
	},
	build = function()
		pcall(require("nvim-treesitter.install").update({ with_sync = true }))
	end,
	config = function()
		require("nvim-treesitter.configs").setup({
			-- NOTE: `context_commentstring` (nvim-treesitter module) is deprecated.
			-- Comment.nvim integration is configured via `ts_context_commentstring`.
		})
	end,
}
