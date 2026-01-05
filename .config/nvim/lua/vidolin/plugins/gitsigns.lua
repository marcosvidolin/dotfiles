return {
    "lewis6991/gitsigns.nvim",
    config = function()
        local gitsigns = require("gitsigns")

        gitsigns.setup({
            signs = {
                add = { text = '+' },
                change = { text = '~' },
                delete = { text = '_' },
                topdelete = { text = '‾' },
                changedelete = { text = '~' },
            },
            on_attach = function(bufnr)
                local gs = package.loaded.gitsigns

                local function map(mode, l, r, opts)
                  opts = opts or {}
                  opts.buffer = bufnr
                  vim.keymap.set(mode, l, r, opts)
                end

                -- Navigation
                map('n', ']c', function()
                  if vim.wo.diff then return ']c' end
                  vim.schedule(function() gs.next_hunk() end)
                  return '<Ignore>'
                end, {expr=true})

                map('n', '[c', function()
                  if vim.wo.diff then return '[c' end
                  vim.schedule(function() gs.prev_hunk() end)
                  return '<Ignore>'
                end, {expr=true})

                -- Actions
                local keymap = vim.keymap -- for conciseness
                keymap.set('n', '<leader>gk', gs.prev_hunk, { desc = "Gitsigns prev_hunk" })
                keymap.set('n', '<leader>gj', gs.next_hunk, { desc = "Gitsigns next_hunk" })
                keymap.set('n', '<leader>gl', function() gs.blame_line{full=true} end, { desc = "Gitsigns blame_line" })
                keymap.set('n', '<leader>gd', gs.diffthis, { desc = "Gitsigns diffthis" })
                keymap.set('n', '<leader>gD', function() gs.diffthis('~') end, { desc = "Gitsigns diffthis ~" })

                -- Text object
                map({'o', 'x'}, 'ih', ':<C-U>Gitsigns select_hunk<CR>')
            end
        })
    end
}
