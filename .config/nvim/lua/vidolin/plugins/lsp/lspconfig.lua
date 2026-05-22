return {
	"neovim/nvim-lspconfig",
	event = { "BufReadPre", "BufNewFile" },
	dependencies = {
		"hrsh7th/cmp-nvim-lsp",
		{ "antosha417/nvim-lsp-file-operations", config = true },
	},
	config = function()
		local cmp_nvim_lsp = require("cmp_nvim_lsp")

		-- keymaps for LSP
		local keymap = vim.keymap
		local opts = { noremap = true, silent = true }

		local on_attach = function(_, bufnr)
			opts.buffer = bufnr

			opts.desc = "Show LSP references"
			keymap.set("n", "gR", "<cmd>Telescope lsp_references<CR>", opts)

			opts.desc = "Go to declaration"
			keymap.set("n", "gD", vim.lsp.buf.declaration, opts)

			opts.desc = "Show LSP definitions"
			keymap.set("n", "gd", "<cmd>Telescope lsp_definitions<CR>", opts)

			opts.desc = "Show LSP implementations"
			keymap.set("n", "gi", "<cmd>Telescope lsp_implementations<CR>", opts)

			opts.desc = "Show LSP type definitions"
			keymap.set("n", "gt", "<cmd>Telescope lsp_type_definitions<CR>", opts)

			opts.desc = "See available code actions"
			keymap.set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, opts)

			opts.desc = "Smart rename"
			keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)

			opts.desc = "Show buffer diagnostics"
			keymap.set("n", "<leader>D", "<cmd>Telescope diagnostics bufnr=0<CR>", opts)

			opts.desc = "Show line diagnostics"
			keymap.set("n", "<leader>d", vim.diagnostic.open_float, opts)

			opts.desc = "Go to previous diagnostic"
			keymap.set("n", "[d", vim.diagnostic.goto_prev, opts)

			opts.desc = "Go to next diagnostic"
			keymap.set("n", "]d", vim.diagnostic.goto_next, opts)

			opts.desc = "Show documentation under cursor"
			keymap.set("n", "K", vim.lsp.buf.hover, opts)

			opts.desc = "Restart LSP"
			keymap.set("n", "<leader>rs", ":LspRestart<CR>", opts)
		end

		local capabilities = cmp_nvim_lsp.default_capabilities()

		-- diagnostic signs
		local signs = { Error = " ", Warn = " ", Hint = "󰠠 ", Info = " " }
		for type, icon in pairs(signs) do
			local hl = "DiagnosticSign" .. type
			vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" })
		end

		-- define servers
		vim.lsp.config["gopls"] = {
			capabilities = capabilities,
			on_attach = on_attach,
			settings = {
				gopls = {
					analyses = { unusedparams = true },
					staticcheck = true,
				},
			},
		}

		vim.lsp.config["terraformls"] = {
			capabilities = capabilities,
			on_attach = on_attach,
		}

		vim.lsp.config["html"] = {
			capabilities = capabilities,
			on_attach = on_attach,
		}

		vim.lsp.config["cssls"] = {
			capabilities = capabilities,
			on_attach = on_attach,
		}

		vim.lsp.config["pyright"] = {
			capabilities = capabilities,
			on_attach = on_attach,
		}

		vim.lsp.config["ts_ls"] = {
			capabilities = capabilities,
			on_attach = on_attach,
		}

		vim.lsp.config["lua_ls"] = {
			capabilities = capabilities,
			on_attach = on_attach,
			settings = {
				Lua = {
					diagnostics = {
						globals = { "vim" },
					},
					workspace = {
						library = {
							[vim.fn.expand("$VIMRUNTIME/lua")] = true,
							[vim.fn.stdpath("config") .. "/lua"] = true,
						},
					},
				},
			},
		}

		-- autostart helper
		local function enable_lsp_autostart(server, filetypes)
			vim.api.nvim_create_autocmd("FileType", {
				pattern = filetypes,
				callback = function(args)
					vim.lsp.start(vim.lsp.config[server], { bufnr = args.buf })
				end,
			})
		end

		-- autostart each server
		enable_lsp_autostart("gopls", { "go", "gomod", "gowork" })
		enable_lsp_autostart("terraformls", { "terraform" })
		enable_lsp_autostart("html", { "html" })
		enable_lsp_autostart("cssls", { "css", "scss", "less" })
		enable_lsp_autostart("pyright", { "python" })
		enable_lsp_autostart("ts_ls", { "typescript", "typescriptreact", "javascript", "javascriptreact" })
		enable_lsp_autostart("lua_ls", { "lua" })
	end,
}
