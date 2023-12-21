return {
    {
      "nvim-telescope/telescope.nvim",
      branch = "0.1.x",
      dependencies = {
        "nvim-lua/plenary.nvim",
        { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
        "nvim-tree/nvim-web-devicons",
      },
      config = function()
        local telescope = require("telescope")
        local actions = require("telescope.actions")

        telescope.setup({
          defaults = {
            path_display = { "truncate" },
            mappings = {
              i = {
                ["<C-k>"] = actions.move_selection_previous, -- move to prev result
                ["<C-j>"] = actions.move_selection_next, -- move to next result
                ["<C-q>"] = actions.send_selected_to_qflist + actions.open_qflist,
              },
            },
          },
        })

        telescope.load_extension("fzf")

        -- set keymaps
        local keymap = vim.keymap -- for conciseness

        keymap.set("n", "<leader>ff", "<cmd>Telescope find_files<cr>", { desc = "Fuzzy find files in cwd" })
        keymap.set("n", "<leader>fr", "<cmd>Telescope oldfiles<cr>", { desc = "Fuzzy find recent files" })
        keymap.set("n", "<leader>fg", "<cmd>Telescope live_grep<cr>", { desc = "Find string in cwd" })
        keymap.set("n", "<leader>fc", "<cmd>Telescope grep_string<cr>", { desc = "Find string under cursor in cwd" })
        keymap.set("n", "<leader>fgb", "<cmd>Telescope git_branches<cr>", { desc = "Fuzzy find git branches" })
        keymap.set("n", "<leader>fgs", "<cmd>Telescope git_status<cr>", { desc = "Fuzzy find git changes" })
      end,
  },
  {
    'nvim-telescope/telescope-ui-select.nvim',
    config = function ()
        require("telescope").setup {
          extensions = {
            ["ui-select"] = {
              require("telescope.themes").get_dropdown {
              }
            }
          }
        }
        -- To get ui-select loaded and working with telescope, you need to call
        -- load_extension, somewhere after setup function:
        require("telescope").load_extension("ui-select")
    end
  }
}
