return {
	"williamboman/mason.nvim",
	dependencies = {
		"williamboman/mason-lspconfig.nvim",
		"WhoIsSethDaniel/mason-tool-installer.nvim",
	},
	config = function()
		local ok_mason, mason = pcall(require, "mason")
		if not ok_mason then
			return
		end

		local ok_mason_lspconfig, mason_lspconfig = pcall(require, "mason-lspconfig")
		if not ok_mason_lspconfig then
			return
		end

		local ok_mason_tool_installer, mason_tool_installer = pcall(require, "mason-tool-installer")
		if not ok_mason_tool_installer then
			return
		end

		-- enable mason and configure icons
		mason.setup({
			ui = {
				icons = {
					package_installed = "✓",
					package_pending = "➜",
					package_uninstalled = "✗",
				},
			},
		})

		-- LSP servers are specified by lspconfig server name.
		mason_lspconfig.setup({
			ensure_installed = {
				"ts_ls",
				"html",
				"cssls",
				"lua_ls",
				"pyright",
				"gopls",
				"terraformls",
				"dockerls",
				"docker_compose_language_service",
				"bashls",
				"golangci_lint_ls",
			},
			automatic_installation = true,
		})

		mason_tool_installer.setup({
			ensure_installed = {
				"prettier", -- formatter
				"stylua", -- formatter
				"isort", -- formatter
				"black", -- formatter
				"pylint", -- linter
				"eslint_d", -- linter
				"tflint", -- linter
				"sql-formatter",
			},
		})
	end,
}
