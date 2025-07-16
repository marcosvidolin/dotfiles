local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		"--branch=stable", -- latest stable release
		lazypath,
	})
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({ { import = "gverse.plugins" }, { import = "gverse.plugins.lsp" } }, {
	install = {
		-- check the ´`colorscheme.lua` to configure the default by adding the `vim.cmd([[colorscheme oxocarbon]])`
		-- you can also change the colorscheme on vim using `:colorscheme´` + <tab> to see the options
		colorscheme = { "modus", "oxocarbon", "catppuccin" },
	},
	checker = {
		enabled = true,
		notify = false,
	},
	change_detection = {
		notify = false,
	},
})

require("dapui").setup()
require("nvim-dap-virtual-text").setup()
require("dap-go").setup()
