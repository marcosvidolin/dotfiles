local function get_visual_selection()
  local _, ls, cs = unpack(vim.fn.getpos("'<"))
  local _, le, ce = unpack(vim.fn.getpos("'>"))

  -- normalize indexes
  if ls > le or (ls == le and cs > ce) then
    ls, le = le, ls
    cs, ce = ce, cs
  end

  local lines = vim.fn.getline(ls, le)

  -- adjust for inclusive/exclusive selection
  local last_line = vim.fn.getline(le)
  local last_col = #last_line
  if ce > last_col then
    ce = last_col
  end

  lines[1] = string.sub(lines[1], cs)
  lines[#lines] = string.sub(lines[#lines], 1, ce)

  return table.concat(lines, "\n"), { ls = ls, cs = cs, le = le, ce = ce }
end

local function replace_selection(new_text, pos)
  local ls, cs, le, ce = pos.ls, pos.cs, pos.le, pos.ce

  -- check line length to avoid out-of-range errors
  local line = vim.api.nvim_get_current_line()
  local max_col = #line
  if ce > max_col then
    ce = max_col
  end

  -- delete old selection
  vim.api.nvim_buf_set_text(0, ls - 1, cs - 1, le - 1, ce, {})

  -- insert new content
  local new_lines = vim.split(new_text, "\n")
  vim.api.nvim_buf_set_text(0, ls - 1, cs - 1, ls - 1, cs - 1, new_lines)
end

-- base64 helpers using the system `base64` binary to match shell behavior
local function b64_encode(data)
  -- -b 0 avoids line wrapping on macOS/BSD base64
  local output = vim.fn.system({ "base64", "-b", "0" }, data)
  if vim.v.shell_error ~= 0 then
    return data
  end
  -- strip trailing newline the CLI adds
  return (output:gsub("%s+$", ""))
end

local function b64_decode(data)
  local output = vim.fn.system({ "base64", "-d" }, data)
  if vim.v.shell_error ~= 0 then
    return data
  end
  return (output:gsub("%s+$", ""))
end

local function is_base64(str)
  if str == "" or (#str % 4 ~= 0) then
    return false
  end
  if str:find("[^A-Za-z0-9+/=\n\r]") then
    return false
  end

  local ok, decoded = pcall(b64_decode, str)
  return ok and decoded ~= nil and decoded ~= ""
end

local function process_value(value, mode)
  if mode == "encode" then
    if is_base64(value) then
      return value
    end
    return b64_encode(value)
  else
    if not is_base64(value) then
      return value
    end
    return b64_decode(value)
  end
end

local function handle_lines(text, mode)
  local lines = vim.split(text, "\n")
  for idx, line in ipairs(lines) do
    -- capture YAML-ish "key: value" and only transform the value portion
    local prefix, value = line:match("^([%s%-]*.-:%s*)(.*)$")
    if prefix then
      lines[idx] = prefix .. process_value(value, mode)
    else
      lines[idx] = process_value(line, mode)
    end
  end
  return table.concat(lines, "\n")
end

-- ENCODE (no newline added)
vim.api.nvim_create_user_command("B64", function()
  local text, pos = get_visual_selection()

  local result = handle_lines(text, "encode")
  replace_selection(result, pos)
end, { range = true })

-- DECODE
vim.api.nvim_create_user_command("B64d", function()
  local text, pos = get_visual_selection()

  local result = handle_lines(text, "decode")
  replace_selection(result, pos)
end, { range = true })
