-- Neovim LSP compatibility shims for 0.12+.
--
-- This file intentionally avoids hard dependencies on any plugin. It only
-- smooths over API transitions that some plugins haven't adopted yet.

if type(vim) ~= "table" or type(vim.lsp) ~= "table" then
  return
end

-- 1) `vim.lsp.util.make_position_params` now requires `position_encoding`.
-- Some plugins still call it with only `winnr` (or no args), which triggers a warning.
do
  local util = vim.lsp.util
  if type(util) == "table" and type(util.make_position_params) == "function" then
    local orig = util.make_position_params

    ---Infer an encoding from attached clients for a buffer.
    ---@param bufnr integer
    ---@return string
    local function infer_position_encoding(bufnr)
      local clients = {}
      if type(vim.lsp.get_clients) == "function" then
        clients = vim.lsp.get_clients({ bufnr = bufnr })
      elseif type(vim.lsp.get_active_clients) == "function" then
        clients = vim.lsp.get_active_clients({ bufnr = bufnr })
      end

      local c = clients and clients[1] or nil
      return (c and (c.offset_encoding or c.position_encoding)) or "utf-16"
    end

    util.make_position_params = function(winnr, position_encoding, ...)
      if position_encoding == nil then
        local win = (type(winnr) == "number" and winnr) or vim.api.nvim_get_current_win()
        local bufnr = vim.api.nvim_win_get_buf(win)
        position_encoding = infer_position_encoding(bufnr)
      end
      return orig(winnr, position_encoding, ...)
    end
  end
end

-- 2) Silence the single deprecation that noisy plugins still trigger:
-- calling `client.supports_method(...)` instead of `client:supports_method(...)`.
-- (We keep other deprecation warnings intact.)
do
  if type(vim.deprecate) == "function" then
    local orig = vim.deprecate
    vim.deprecate = function(name, alternative, version, plugin, backtrace)
      if name == "client.supports_method" then
        return
      end
      return orig(name, alternative, version, plugin, backtrace)
    end
  end
end

