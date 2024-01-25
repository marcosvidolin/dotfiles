return {
	"windwp/nvim-ts-autotag",
	ft = {
		"javascript",
		"javascriptreact",
		"typescript",
		"typescriptreact",
	},
	dependencies = "nvim-treesitter/nvim-treesitter",
	config = function()
		require("nvim-ts-autotag").setup({
			-- your config
		})
	end,
	lazy = true,
	event = "VeryLazy",
}
