return {
      "numToStr/Comment.nvim", -- "gc" to comment visual regions/lines
      lazy = false,
      dependencies = {
        -- Fixes commenting in mixed-syntax buffers (tsx/jsx/vue/svelte, etc.)
        "JoosepAlviste/nvim-ts-context-commentstring",
      },
      config = function()
        local ok, integration = pcall(require, "ts_context_commentstring.integrations.comment_nvim")
        local ts_pre_hook = ok and integration.create_pre_hook() or nil

        pcall(function()
          require("ts_context_commentstring").setup({
            enable_autocmd = false,
          })
        end)

        require("Comment").setup({
          pre_hook = function(ctx)
            -- YAML doesn't need context-aware commentstrings; ensure it always works.
            if vim.bo.filetype == "yaml" then
              if vim.bo.commentstring == "" then
                vim.bo.commentstring = "# %s"
              end
              return vim.bo.commentstring
            end

            return ts_pre_hook and ts_pre_hook(ctx) or nil
          end,
        })
      end,
}
