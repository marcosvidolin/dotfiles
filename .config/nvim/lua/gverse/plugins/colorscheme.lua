return {
  {
    "nyoom-engineering/oxocarbon.nvim",
    priority = 1000, -- make sure to load this before all the other start plugins
    config = function()
      -- vim.cmd([[colorscheme oxocarbon]])
    end,
  },
  {
    "catppuccin/nvim",
    name = "catppuccin",
    priority = 1000, -- make sure to load this before all the other start plugins
    config = function()
      -- -- load the colorscheme here
      vim.cmd([[colorscheme catppuccin-macchiato]])
      -- vim.cmd("highlight LineNr guifg=#60637d")
      -- vim.cmd('highlight CursorLineNr guifg=#b4befe')
    end,
  },
  {
    "miikanissi/modus-themes.nvim",
    priority = 1000, -- make sure to load this before all the other start plugins
    config = function()
      -- vim.cmd([[colorscheme modus]])
    end,
  },
}
