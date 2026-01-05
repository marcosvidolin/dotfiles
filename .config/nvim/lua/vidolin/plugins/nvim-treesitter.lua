return {
	-- Highlight, edit, and navigate code
	"nvim-treesitter/nvim-treesitter",
	dependencies = {
		"nvim-treesitter/nvim-treesitter-textobjects",
	},
	build = function()
		pcall(require("nvim-treesitter.install").update({ with_sync = true }))
	end,
}
