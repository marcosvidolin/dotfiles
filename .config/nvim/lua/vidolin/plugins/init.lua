-- load general plugins that no needs configuration
return {
    'tpope/vim-fugitive',
    'fatih/vim-go',
    "nvim-lua/plenary.nvim", -- lua functions that many plugins use
    "christoomey/vim-tmux-navigator", -- tmux & split window navigation
    "inkarkat/vim-ReplaceWithRegister", -- replace with register contents using motion (gr + motion)
    "charlespascoe/vim-go-syntax", -- syntax highlighting
    { "junegunn/fzf", build = "./install --bin" },
    {
      "norcalli/nvim-colorizer.lua",
      config = function ()
        require'colorizer'.setup()
      end
    }
}
