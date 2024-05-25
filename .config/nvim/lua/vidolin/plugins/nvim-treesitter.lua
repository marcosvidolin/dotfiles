return {
  -- Highlight, edit, and navigate code
  "nvim-treesitter/nvim-treesitter",
  dependencies = {
    "nvim-treesitter/nvim-treesitter-textobjects",
  },
  opts = {
    auto_install = true,
    autotag = {
      enable = true,
      filetypes = {
        "html",
        "javascript",
        "typescript",
        "svelte",
        "vue",
        "tsx",
        "jsx",
        "rescript",
        "css",
        "lua",
        "xml",
        "php",
        "markdown",
      },
    },
    indent = { enable = true },
    ensure_installed = {
      -- defaults
      "vim",
      "lua",
      "vimdoc",

      -- web dev
      "html",
      "css",
      "javascript",
      "typescript",
      "tsx",
      "astro",
      "vue",
      "svelte",
      "markdown",
      "markdown_inline",
      "json",
      "scss",
      "yaml",
    },
  },
  build = function()
    pcall(require("nvim-treesitter.install").update({ with_sync = true }))
  end,
}
