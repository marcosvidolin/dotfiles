local M = {}

local function load_env_file(path)
  local env = {}
  local file = io.open(path, "r")
  if not file then
    return env
  end

  for line in file:lines() do
    -- ignore comments and empty lines
    if not line:match("^%s*#") and line:match("%S") then
      local k, v = line:match("^%s*([^=#]+)%s*=%s*(.-)%s*$")
      if k and v then
        env[k] = v
      end
    end
  end

  file:close()
  return env
end

---Load `.env*` files from current working directory.
---Logs which files were loaded (📦 ...), matching your previous behavior.
---@param opts? { quiet?: boolean }
---@return table<string, string> env
function M.load_env_from_cwd(opts)
  opts = opts or {}

  local root = vim.fn.getcwd()
  local env = {}
  local files = {}

  local dir = vim.loop.fs_scandir(root)
  if not dir then
    if not opts.quiet then
      print("⚠️ Could not open directory: " .. root)
    end
    return env
  end

  while true do
    local name = vim.loop.fs_scandir_next(dir)
    if not name then
      break
    end
    if name:match("^%.env") then
      table.insert(files, name)
    end
  end

  table.sort(files) -- keeps `.env` first

  if #files == 0 then
    if not opts.quiet then
      print("⚠️ No .env files found in " .. root)
    end
    return env
  end

  if not opts.quiet then
    print("📦 Loading environment files:")
  end

  for _, filename in ipairs(files) do
    local fullpath = root .. "/" .. filename
    if vim.fn.filereadable(fullpath) == 1 then
      if not opts.quiet then
        print("   → " .. filename)
      end
      env = vim.tbl_extend("force", env, load_env_file(fullpath))
    end
  end

  if not opts.quiet then
    print("✅ Loaded " .. tostring(#files) .. " env file(s)")
  end

  return env
end

---Load a single env file (no logging).
---@param path string
---@return table<string, string> env
function M.load_env_file(path)
  return load_env_file(path)
end

return M

