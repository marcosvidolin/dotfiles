-- Neovim 0.12 Treesitter compatibility guard.
--
-- Some third-party query/predicate code (notably in older nvim-treesitter commits)
-- may call `vim.treesitter.get_node_text()` with a value that isn't a TSNode,
-- which can crash with "attempt to call method 'range' (a nil value)".
--
-- This keeps the editor stable by returning "" on those inputs.

local ok_ts, ts = pcall(function()
  return vim.treesitter
end)

if not ok_ts or type(ts) ~= "table" or type(ts.get_node_text) ~= "function" then
  return
end

local orig_get_node_text = ts.get_node_text

ts.get_node_text = function(node, bufnr, opts)
  if node == nil then
    return ""
  end

  -- Fast-path: if the value can't possibly be a TSNode, don't even try.
  local t = type(node)
  if t ~= "userdata" and t ~= "table" then
    return ""
  end

  local ok, res = pcall(orig_get_node_text, node, bufnr, opts)
  if ok then
    return res
  end

  return ""
end

