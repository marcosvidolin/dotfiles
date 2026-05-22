# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Overview

Personal Neovim configuration named `vidolin`. Entry point is `init.lua`, which bootstraps `vidolin.core` (settings, keymaps, misc) then `vidolin.lazy` (plugin manager). Plugin manager is **lazy.nvim** (stable branch), auto-installed on first launch.

Leader key: `<Space>`

## Architecture

```
init.lua                          # Requires core + lazy
lua/vidolin/
  lazy.lua                        # lazy.nvim bootstrap; imports vidolin.plugins + vidolin.plugins.lsp
  core/
    init.lua                      # Requires all core modules in order
    options.lua                   # vim.opt settings (tabs, search, clipboard, folding)
    keymaps.lua                   # Global keymaps (leader, splits, buffers, DAP, git, FTerm)
    lsp_compat.lua                # Shims for nvim 0.12+ LSP API changes; suppress deprecation noise
    treesitter_compat.lua         # Treesitter compatibility shims
    filetypes.lua                 # Custom filetype mappings (.gotmpl, .tfvars, docker-compose)
    env.lua                       # Utility: loads .env* files from cwd into a Lua table
    dap-config.lua                # DAP adapters + .vscode/launch.json loader (merges .env files)
    misc.lua                      # Autocmds (yank highlight, go fmt); B64 / B64d user commands
    vidolin.lua                   # Additional personal tweaks
  plugins/
    init.lua                      # Catch-all plugin specs
    colorscheme.lua               # oxocarbon / catppuccin (active) / modus; swap via vim.cmd
    lsp/
      mason.lua                   # Mason + mason-lspconfig; installs LSP servers + formatters/linters
      lspconfig.lua               # vim.lsp.config per-server setup + FileType autocmd autostart
      none-ls.lua                 # null-ls: stylua, prettier, sql-formatter; <leader>gf to format
      lsp-signature.lua           # Signature help on insert
    dap.lua                       # nvim-dap + dap-ui + dap-go + dap-virtual-text
    telescope.lua                 # Fuzzy finder + keymaps
    nvim-treesitter.lua           # Treesitter parsers
    nvim-cmp.lua                  # Completion engine
    nvim-tree.lua                 # File explorer; <C-z> / <leader>ee
    gitsigns.lua                  # Hunk navigation + blame
    fterm.lua                     # Floating terminal (<leader>tt)
    trouble.lua                   # Diagnostics list (<leader>xx)
    avante.lua                    # AI assistant (currently disabled / commented out)
    ...                           # Other plugins (surround, autopairs, which-key, etc.)
```

## Key design decisions

**LSP wiring**: servers are configured via `vim.lsp.config[name]` (nvim 0.11+ native API), not `lspconfig.setup()`. Each server is started with a `FileType` autocmd in `lspconfig.lua`. Mason handles binary installation separately.

**DAP + env loading**: `dap-config.lua` reads `.vscode/launch.json` when present and merges all `.env*` files from cwd into the debug env via `vidolin.core.env`. Falls back to `dap-go` defaults when no launch.json exists. Reloads on `DirChanged`.

**Formatting**: `none-ls.nvim` (null-ls fork) provides formatting via `<leader>gf`. Active formatters: stylua (Lua), prettier (JS/TS/CSS/HTML), sql-formatter.

**LSP compat shims** (`lsp_compat.lua`): patches `vim.lsp.util.make_position_params` to auto-infer `position_encoding` and silences the `client.supports_method` deprecation warning — needed because some plugins haven't adopted the nvim 0.12 API yet.

## Installed LSP servers (via Mason)

`ts_ls`, `html`, `cssls`, `lua_ls`, `pyright`, `gopls`, `terraformls`, `dockerls`, `docker_compose_language_service`, `bashls`, `golangci_lint_ls`

## Installed tools (via Mason)

Formatters: `prettier`, `stylua`, `isort`, `black`, `sql-formatter`  
Linters: `pylint`, `eslint_d`, `tflint`

## Adding a new plugin

Create `lua/vidolin/plugins/myplugin.lua` returning a lazy.nvim spec table. It will be auto-imported by the `{ import = "vidolin.plugins" }` line in `lazy.lua`. For LSP-related plugins, put them in `lua/vidolin/plugins/lsp/`.

## Adding a new LSP server

1. Add server name to `mason_lspconfig.ensure_installed` in `mason.lua`.
2. Add `vim.lsp.config["servername"]` block in `lspconfig.lua`.
3. Call `enable_lsp_autostart("servername", { "filetype" })` in the same file.

## Colorscheme

Active: `catppuccin-macchiato` (set in `colorscheme.lua`). To switch, comment/uncomment `vim.cmd([[colorscheme ...]])` in that file. Available: `oxocarbon`, `modus`.

## Notable user commands

| Command | Description |
|---------|-------------|
| `:B64` | Base64-encode visual selection (preserves `key: value` prefixes) |
| `:B64d` | Base64-decode visual selection |
| `:Mason` | Open Mason UI to manage LSP servers / tools |
| `:Lazy` | Open lazy.nvim UI to update/manage plugins |
| `:LspRestart` | Restart attached LSP clients (`<leader>rs`) |
| `:checkhealth` | Diagnose nvim health (python/ruby/perl providers disabled intentionally) |
