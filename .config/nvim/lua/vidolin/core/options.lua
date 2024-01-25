local opt = vim.opt -- for conciseness

-- Folding / Unfolding (za)
vim.cmd("set foldmethod=indent")
vim.cmd("set foldlevel=20")
vim.cmd("set foldlevelstart=20")

-- Go Language
-- -----------
vim.cmd("let g:go_disable_autoinstall = 1")
vim.cmd("let g:go_fmt_autosave = 0")
vim.cmd("let g:go_metalinter_autosave = 1")

-- line numbers
opt.relativenumber = true -- show relative line numbers
opt.number = true -- shows absolute line number on cursor line (when relative number is on)

-- tabs & indentation
opt.tabstop = 4       -- number of columns occupied by a tab 
opt.softtabstop = 2   -- see multiple spaces as tabstops so <BS> does the right thing
opt.expandtab = true  -- converts tabs to white space
opt.shiftwidth = 2    -- width for autoindents
opt.autoindent = true -- copy indent from current line when starting new one

-- vim.o.syntax = "ON"                -- str:  Allow syntax highlighting
-- vim.o.termguicolors = true         -- bool: If term supports ui color then enable

-- line wrapping
opt.wrap = false -- disable line wrapping

-- search settings
opt.ignorecase = true -- ignore case when searching
opt.smartcase = true -- if you include mixed case in your search, assumes you want case-sensitive

-- cursor line
opt.cursorline = true -- highlight the current cursor line

-- appearance

-- turn on termguicolors for nightfly colorscheme to work
-- (have to use iterm2 or any other true color terminal)
opt.termguicolors = true
opt.background = "dark" -- colorschemes that can be light or dark will be made dark
opt.signcolumn = "yes" -- show sign column so that text doesn't shift

-- backspace
opt.backspace = "indent,eol,start" -- allow backspace on indent, end of line or insert mode start position

-- clipboard
opt.clipboard:append("unnamedplus") -- use system clipboard as default register

-- split windows
opt.splitright = true -- split vertical window to the right
opt.splitbelow = true -- split horizontal window to the bottom

-- turn off swapfile
opt.swapfile = false

-- [[ Basic Keymaps ]]
-- Set <space> as the leader key
-- See `:help mapleader`
--  NOTE: Must happen before plugins are required (otherwise wrong leader will be used)
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

