-- set leader key to space
vim.g.mapleader = " "

local keymap = vim.keymap -- for conciseness

---------------------
-- General Keymaps -------------------
--
-- use jk to exit insert mode
keymap.set("i", "jk", "<ESC>", { desc = "Exit insert mode with jk" })

-- clear search highlights
keymap.set("n", "<leader>nh", ":nohl<CR>", { desc = "Clear search highlights" })

-- delete single character without copying into register
-- keymap.set("n", "x", '"_x')

-- increment/decrement numbers
keymap.set("n", "<leader>+", "<C-a>", { desc = "Increment number" }) -- increment
keymap.set("n", "<leader>-", "<C-x>", { desc = "Decrement number" }) -- decrement

-- window management
keymap.set("n", "<C-W>,", ":vertical resize -10<CR>", {noremap=true})
keymap.set("n", "<C-W>.", ":vertical resize +10<CR>", {noremap=true})

keymap.set("n", "<leader>sv", "<C-w>v", { desc = "Split window vertically" }) -- split window vertically
keymap.set("n", "<leader>sh", "<C-w>s", { desc = "Split window horizontally" }) -- split window horizontally
keymap.set("n", "<leader>se", "<C-w>=", { desc = "Make splits equal size" }) -- make split windows equal width & height
keymap.set("n", "<leader>sx", "<cmd>close<CR>", { desc = "Close current split" }) -- close current split window

keymap.set("n", "<leader>to", "<cmd>tabnew<CR>", { desc = "Open new tab" }) -- open new tab
keymap.set("n", "<leader>tx", "<cmd>tabclose<CR>", { desc = "Close current tab" }) -- close current tab
keymap.set("n", "<leader>tn", "<cmd>tabn<CR>", { desc = "Go to next tab" }) --  go to next tab
keymap.set("n", "<leader>tp", "<cmd>tabp<CR>", { desc = "Go to previous tab" }) --  go to previous tab
keymap.set("n", "<leader>tf", "<cmd>tabnew %<CR>", { desc = "Open current buffer in new tab" }) --  move current buffer to new tab

keymap.set("n", "<C-z>", ":NvimTreeToggle<CR>", {noremap=true})

-- buffers
keymap.set("n", "tk", ":bnext<enter>", {noremap=false})
keymap.set("n", "tj", ":bprev<enter>", {noremap=false})
keymap.set("n", "th", ":bfirst<enter>", {noremap=false})
keymap.set("n", "tl", ":blast<enter>", {noremap=false})
keymap.set("n", "td", ":bdelete<enter>", {noremap=false})

-- Debugger
keymap.set("n", "<leader>du", ":DapUiToggle<CR>", {noremap=true, desc = "DapUiToggle"})
keymap.set("n", "<leader>db", ":DapToggleBreakpoint<CR>", {noremap=true, desc = "DapToggleBreakpoint"})
keymap.set("n", "<leader>dc", ":DapContinue<CR>", {noremap=true, desc = "DapContinue"})
keymap.set("n", "<leader>dr", ":lua require('dapui').open({reset = true})<CR>", {noremap=true, desc = "Dap UI Reset"})
keymap.set("n", "<leader>ds", ":DapStop<CR>", {noremap=true, desc = "DapStop"})
keymap.set("n", "<leader>dt", ":DapTerminate<CR>", {noremap=true, desc = "DapTerminate"})
keymap.set("n", "<leader>dso", ":DapStepOver<CR>", {noremap=true, desc = "DapStepOver"})

-- Git
keymap.set("n", "<leader>gc", ":Git commit -m \"", {noremap=false})
keymap.set("n", "<leader>gp", ":Git push -u origin HEAD<CR>", {noremap=false})
--
-- Fterm
vim.api.nvim_set_keymap("n", "<leader>tt", ":lua require('FTerm').toggle()<CR>", {noremap=true})
vim.api.nvim_set_keymap("t", "<leader>tt", '<C-\\><C-n>:lua require("FTerm").toggle()<CR>', {noremap=true})

