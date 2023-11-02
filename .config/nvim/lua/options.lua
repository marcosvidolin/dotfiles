-- Go Language
-- -----------
vim.cmd("let g:go_disable_autoinstall = 1")
vim.cmd("let g:go_fmt_autosave = 0")
vim.cmd("let g:go_metalinter_autosave = 1")


-- disable creating swap file
vim.opt.swapfile = false

vim.opt.tabstop = 4       -- number of columns occupied by a tab 
vim.opt.softtabstop = 4   -- see multiple spaces as tabstops so <BS> does the right thing
vim.opt.expandtab = true  -- converts tabs to white space
vim.opt.shiftwidth = 4    -- width for autoindents

vim.o.encoding = "UTF-8"

-- Set highlight on search
vim.o.hlsearch = true

-- Make line numbers default
vim.wo.number = true
vim.o.relativenumber = true

-- Disable mouse mode
vim.o.mouse = 'a'

-- Enable break indent
vim.o.breakindent = true

-- Save undo history
vim.o.undofile = true

-- Case insensitive searching UNLESS /C or capital in search
vim.o.ignorecase = true
vim.o.smartcase = true

-- Decrease update time
vim.o.updatetime = 250
vim.wo.signcolumn = 'yes'

-- Set colorscheme
--vim.cmd [[colorscheme onedark]]
vim.cmd.colorscheme "catppuccin"
vim.o.syntax = "ON"                -- str:  Allow syntax highlighting
vim.o.termguicolors = true         -- bool: If term supports ui color then enable

--vim.cmd()
vim.opt.clipboard = 'unnamedplus'

-- Set completeopt to have a better completion experience
vim.o.completeopt = 'menuone,noselect'

-- Concealer for Neorg
vim.o.conceallevel=2

-- [[ Basic Keymaps ]]
-- Set <space> as the leader key
-- See `:help mapleader`
--  NOTE: Must happen before plugins are required (otherwise wrong leader will be used)
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

