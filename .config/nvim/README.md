# Neovim config (`vidolin`)

Leader key: `<Space>`

## Keymaps & commands

Notes:
- Tables below include **only keymaps/commands explicitly defined in this config**.
- Some plugins (e.g. `nvim-tree`) also enable **their own default mappings** in their buffers.

### tmux quick reference (defaults)

These are **tmux default key bindings** (not configured by this Neovim repo). Your prefix appears to be `Ctrl-b`.

| Context | Keys | Action |
|---|---|---|
| tmux | `Ctrl-b` then `c` | Create new tmux window |
| tmux | `Ctrl-b` then `%` | Split pane left/right |
| tmux | `Ctrl-b` then `"` | Split pane top/bottom |
| tmux | `Ctrl-b` then `z` | Zoom current pane (toggle) — handy “hide/show split” |
| tmux | `Ctrl-b` then `x` | Kill current pane |
| tmux | `Ctrl-b` then `w` | Choose window |
| tmux | `Ctrl-b` then `n` / `p` | Next / previous window |
| tmux | `Ctrl-b` then `d` | Detach (hide tmux session) |

Restore a detached session:

```bash
tmux ls
tmux attach -t <session-name>
```

If you “suspended” a command inside a tmux pane via `Ctrl-z` (shell job control), restore it with:

```bash
fg
```

### General editing

| Mode | Key | Action | Description |
|---|---|---|---|
| Insert | `jk` | `<Esc>` | Exit insert mode |
| Normal | `<leader>nh` | `:nohl<CR>` | Clear search highlights |
| Normal | `<leader>+` | `<C-a>` | Increment number |
| Normal | `<leader>-` | `<C-x>` | Decrement number |

### Windows, tabs, buffers

| Mode | Key | Action | Description |
|---|---|---|---|
| Normal | `<C-w>,` | `:vertical resize -10<CR>` | Resize vertical split smaller |
| Normal | `<C-w>.` | `:vertical resize +10<CR>` | Resize vertical split larger |
| Normal | `<leader>sv` | `<C-w>v` | Split window vertically |
| Normal | `<leader>sh` | `<C-w>s` | Split window horizontally |
| Normal | `<leader>se` | `<C-w>=` | Make splits equal size |
| Normal | `<leader>sx` | `<cmd>close<CR>` | Close current split |
| Normal | `<leader>to` | `<cmd>tabnew<CR>` | Open new tab |
| Normal | `<leader>tx` | `<cmd>tabclose<CR>` | Close current tab |
| Normal | `<leader>tn` | `<cmd>tabn<CR>` | Next tab |
| Normal | `<leader>tp` | `<cmd>tabp<CR>` | Previous tab |
| Normal | `<leader>tf` | `<cmd>tabnew %<CR>` | Open current buffer in new tab |
| Normal | `tk` | `:bnext<CR>` | Next buffer |
| Normal | `tj` | `:bprev<CR>` | Previous buffer |
| Normal | `th` | `:bfirst<CR>` | First buffer |
| Normal | `tl` | `:blast<CR>` | Last buffer |
| Normal | `td` | `:bdelete<CR>` | Delete buffer |

### File explorer (`nvim-tree`)

Global keymaps:

| Mode | Key | Action | Description |
|---|---|---|---|
| Normal | `<C-z>` | `:NvimTreeToggle<CR>` | Toggle file explorer |
| Normal | `<leader>ee` | `:NvimTreeToggle<CR>` | Toggle file explorer |
| Normal | `<leader>ef` | `:NvimTreeFindFileToggle<CR>` | Toggle explorer on current file |
| Normal | `<leader>ec` | `:NvimTreeCollapse<CR>` | Collapse explorer |
| Normal | `<leader>er` | `:NvimTreeRefresh<CR>` | Refresh explorer |

Inside the NvimTree buffer (custom mappings in addition to defaults):

| Mode | Key | Action | Description |
|---|---|---|---|
| Normal | `l` | Open | Open node |
| Normal | `v` | Vertical split | Open in vertical split |
| Normal | `h` | Horizontal split | Open in horizontal split |
| Normal | `?` | Toggle help | Help |

### Search & navigation (`telescope.nvim`)

| Mode | Key | Action | Description |
|---|---|---|---|
| Normal | `<leader>ff` | `:Telescope find_files<CR>` | Find files |
| Normal | `<leader>fr` | `:Telescope oldfiles<CR>` | Recent files |
| Normal | `<leader>fg` | `:Telescope live_grep<CR>` | Live grep (cwd) |
| Normal | `<leader>fc` | `:Telescope grep_string<CR>` | Grep string under cursor (cwd) |
| Normal | `<leader>gb` | `:Telescope git_branches<CR>` | Git branches |
| Normal | `<leader>gs` | `:Telescope git_status<CR>` | Git status/changes |

Telescope prompt (insert-mode mappings):

| Mode | Key | Action | Description |
|---|---|---|---|
| Telescope (insert) | `<C-k>` | Move selection up | Previous result |
| Telescope (insert) | `<C-j>` | Move selection down | Next result |
| Telescope (insert) | `<C-q>` | Send to quickfix + open | Quickfix |

### LSP

These keymaps are set per-buffer when an LSP attaches.

| Mode | Key | Action | Description |
|---|---|---|---|
| Normal | `gR` | `:Telescope lsp_references<CR>` | LSP references |
| Normal | `gD` | `vim.lsp.buf.declaration()` | Go to declaration |
| Normal | `gd` | `:Telescope lsp_definitions<CR>` | LSP definitions |
| Normal | `gi` | `:Telescope lsp_implementations<CR>` | LSP implementations |
| Normal | `gt` | `:Telescope lsp_type_definitions<CR>` | LSP type definitions |
| Normal/Visual | `<leader>ca` | `vim.lsp.buf.code_action()` | Code action |
| Normal | `<leader>rn` | `vim.lsp.buf.rename()` | Rename |
| Normal | `<leader>D` | `:Telescope diagnostics bufnr=0<CR>` | Buffer diagnostics (Telescope) |
| Normal | `<leader>d` | `vim.diagnostic.open_float()` | Line diagnostics float |
| Normal | `[d` | `vim.diagnostic.goto_prev()` | Previous diagnostic |
| Normal | `]d` | `vim.diagnostic.goto_next()` | Next diagnostic |
| Normal | `K` | `vim.lsp.buf.hover()` | Hover docs |
| Normal | `<leader>rs` | `:LspRestart<CR>` | Restart LSP |

Formatting:

| Mode | Key | Action | Description |
|---|---|---|---|
| Normal | `<leader>gf` | `vim.lsp.buf.format()` | Format buffer |

### Diagnostics UI (`trouble.nvim`)

| Mode | Key | Action | Description |
|---|---|---|---|
| Normal | `<leader>xx` | `:Trouble diagnostics toggle<CR>` | Diagnostics |
| Normal | `<leader>xX` | `:Trouble diagnostics toggle filter.buf=0<CR>` | Buffer diagnostics |
| Normal | `<leader>cs` | `:Trouble symbols toggle focus=false<CR>` | Symbols |
| Normal | `<leader>cl` | `:Trouble lsp toggle focus=false win.position=right<CR>` | LSP list (definitions/references/…) |
| Normal | `<leader>xL` | `:Trouble loclist toggle<CR>` | Location list |
| Normal | `<leader>xQ` | `:Trouble qflist toggle<CR>` | Quickfix list |

### Debugging (`nvim-dap`)

| Mode | Key | Action | Description |
|---|---|---|---|
| Normal | `<leader>du` | `:DapUiToggle<CR>` | Toggle DAP UI |
| Normal | `<leader>db` | `:DapToggleBreakpoint<CR>` | Toggle breakpoint |
| Normal | `<leader>dc` | `:DapContinue<CR>` | Continue |
| Normal | `<leader>dr` | `require("dapui").open({ reset = true })` | Reset/open DAP UI |
| Normal | `<leader>ds` | `:DapStop<CR>` | Stop |
| Normal | `<leader>dt` | `:DapTerminate<CR>` | Terminate |
| Normal | `<leader>do` | `:DapStepOver<CR>` | Step over |

### Git (`vim-fugitive` + `gitsigns.nvim`)

Fugitive:

| Mode | Key | Action | Description |
|---|---|---|---|
| Normal | `<leader>gC` | `:Git commit -m "` | Start `git commit -m "…"` |
| Normal | `<leader>gP` | `:Git push -u origin HEAD<CR>` | Push current branch |

Gitsigns:

| Mode | Key | Action | Description |
|---|---|---|---|
| Normal | `[c` | `gitsigns.prev_hunk()` | Previous hunk |
| Normal | `]c` | `gitsigns.next_hunk()` | Next hunk |
| Normal | `<leader>gk` | `gitsigns.prev_hunk()` | Previous hunk |
| Normal | `<leader>gj` | `gitsigns.next_hunk()` | Next hunk |
| Normal | `<leader>gl` | `gitsigns.blame_line({ full = true })` | Blame line |
| Normal | `<leader>gd` | `gitsigns.diffthis()` | Diff this |
| Normal | `<leader>gD` | `gitsigns.diffthis("~")` | Diff this vs `~` |
| Operator/Visual | `ih` | `:Gitsigns select_hunk<CR>` | Hunk textobject |

### Terminal (`FTerm.nvim`)

| Mode | Key | Action | Description |
|---|---|---|---|
| Normal | `<leader>tt` | `require("FTerm").toggle()` | Toggle floating terminal |
| Terminal | `<leader>tt` | Toggle + back to normal mode | Toggle floating terminal |

### Utility commands

| Type | Name | Description | Usage |
|---|---|---|---|
| User command | `:B64` | Base64-encode visual selection (line-wise; preserves `key: value` prefixes) | Visual-select then run `:B64` |
| User command | `:B64d` | Base64-decode visual selection (if value looks base64) | Visual-select then run `:B64d` |

