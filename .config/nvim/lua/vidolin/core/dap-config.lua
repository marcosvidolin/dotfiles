local dap = require("dap")
-- local dapui = require("dapui")
--
-- -- UI
-- dapui.setup()
-- dap.listeners.after.event_initialized["dapui"] = dapui.open
-- dap.listeners.before.event_terminated["dapui"] = dapui.close
-- dap.listeners.before.event_exited["dapui"] = dapui.close
--
-- -- Delve (server mode)
-- dap.adapters.delve = {
--   type = "server",
--   port = "${port}",
--   executable = {
--     command = "dlv",
--     args = { "dap", "-l", "127.0.0.1:${port}" },
--   },
-- }
--
-- Load .env manually
-- local function load_env()
--   local path = vim.fn.getcwd() .. "/.env"
--   local env = {}
--   if vim.fn.filereadable(path) ~= 1 then
--     return env
--   end
--   for line in io.lines(path) do
--     local k, v = line:match("^([^=#]+)=(.-)$")
--     if k then
--       env[k:gsub("%s+", "")] = v:gsub("%s+$", "")
--     end
--   end
--   return env
-- end
local function load_env()
  local root = vim.fn.getcwd()
  local env = {}
  local files = {}

  -- Scan directory for .env* files
  local dir = vim.loop.fs_scandir(root)
  if not dir then
    print("⚠️ Could not open directory: " .. root)
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

  -- Sort files so .env is loaded first
  table.sort(files)

  if #files == 0 then
    print("⚠️ No .env files found in " .. root)
    return env
  end

  print("📦 Loading environment files:")
  for _, filename in ipairs(files) do
    local fullpath = root .. "/" .. filename
    if vim.fn.filereadable(fullpath) == 1 then
      print("   → " .. filename)
      for line in io.lines(fullpath) do
        -- ignore comments and empty lines
        if not line:match("^%s*#") and line:match("%S") then
          local k, v = line:match("^%s*([^=#]+)%s*=%s*(.-)%s*$")
          if k then
            env[k] = v
          end
        end
      end
    end
  end

  print("✅ Loaded " .. tostring(#files) .. " env file(s)")
  return env
end

load_env()

-- Load launch.json
-- local function load_configs()
--   local path = vim.fn.getcwd() .. "/.vscode/launch.json"
--   if vim.fn.filereadable(path) ~= 1 then
--     return
--   end
--   local data = vim.fn.json_decode(table.concat(vim.fn.readfile(path), "\n"))
--   dap.configurations.go = {}
--   for _, c in ipairs(data.configurations or {}) do
--     if c.type == "go" then
--       -- c.type = "delve"
--       c.request = "launch"
--       c.cwd = "${workspaceFolder"
--       c.env = vim.tbl_extend("force", c.env or {}, load_env())
--       table.insert(dap.configurations.go, c)
--     end
--   end
-- end

-- load_configs()
--
-- -- Auto-run first config with F5
-- vim.keymap.set("n", "<F5>", function()
--   local configs = dap.configurations.go
--   if not configs or #configs == 0 then
--     print("No Go debug config")
--     return
--   end
--   dap.run(configs[1])
-- end)
--
-- -- local dap = require("dap")
-- -- local dapgo = require("dap-go")
-- -- -- local dapui = require("dapui")
-- --
-- -- -- dapui.setup()
-- -- -- dap.listeners.after.event_initialized["dapui_config"] = function()
-- -- --   dapui.open()
-- -- -- end
-- -- -- dap.listeners.before.event_terminated["dapui_config"] = function()
-- -- --   dapui.close()
-- -- -- end
-- -- -- dap.listeners.before.event_exited["dapui_config"] = function()
-- -- --   dapui.close()
-- -- -- end
-- --
-- -- -- ===================================================================
-- -- -- 2. DELVE ADAPTER: SERVER MODE (required for envFile!)
-- -- -- ===================================================================
-- -- dap.adapters.delve = {
-- --   type = "server",
-- --   port = "${port}",
-- --   executable = {
-- --     command = "dlv",
-- --     args = { "dap", "-l", "127.0.0.1:${port}" },
-- --     -- Optional: detach = true to keep dlv running
-- --   },
-- -- }
-- --
-- -- -- ===================================================================
-- -- -- 3. HELPER: Load .env file manually (fallback if Delve fails)
-- -- -- ===================================================================
-- -- local function load_env_file(path)
-- --   local env = {}
-- --   local file = io.open(path, "r")
-- --   if not file then
-- --     return env
-- --   end
-- --
-- --   for line in file:lines() do
-- --     local key, value = line:match("^([^=#]+)=(.+)$")
-- --     if key and value then
-- --       -- Trim whitespace
-- --       key = key:match("^%s*(.-)%s*$")
-- --       value = value:match("^%s*(.-)%s*$")
-- --       env[key] = value
-- --     end
-- --   end
-- --   file:close()
-- --   return env
-- -- end
-- --
-- -- -- ===================================================================
-- -- -- 4. LOAD launch.json + ENHANCE with .env
-- -- -- ===================================================================
-- -- local function load_launch_json()
-- --   local path = vim.fn.getcwd() .. "/.vscode/launch.json"
-- --   if vim.fn.filereadable(path) ~= 1 then
-- --     return false
-- --   end
-- --
-- --   local content = vim.fn.readfile(path)
-- --   local ok, data = pcall(vim.fn.json_decode, table.concat(content, "\n"))
-- --   if not ok or type(data) ~= "table" or not data.configurations then
-- --     return false
-- --   end
-- --
-- --   dap.configurations.go = {}
-- --
-- --   for _, cfg in ipairs(data.configurations) do
-- --     if cfg.type == "go" then
-- --       cfg.type = "delve"
-- --
-- --       -- Ensure cwd is project root
-- --       cfg.cwd = cfg.cwd or "${workspaceFolder}"
-- --
-- --       -- Try to resolve envFile
-- --       local env_file = cfg.envFile
-- --       if type(env_file) == "string" then
-- --         env_file = env_file:gsub("%${workspaceFolder}", vim.fn.getcwd())
-- --       elseif type(env_file) == "table" then
-- --         env_file = env_file[1]:gsub("%${workspaceFolder}", vim.fn.getcwd())
-- --       end
-- --
-- --       -- Load .env manually and inject into `env`
-- --       if env_file and vim.fn.filereadable(env_file) == 1 then
-- --         local file_env = load_env_file(env_file)
-- --         cfg.env = vim.tbl_extend("force", cfg.env or {}, file_env)
-- --         print("[DAP] Loaded .env from: " .. env_file)
-- --       else
-- --         print("[DAP] WARNING: .env not found: " .. (env_file or "nil"))
-- --       end
-- --
-- --       -- Remove envFile (Delve might not support it in all versions)
-- --       cfg.envFile = nil
-- --
-- --       table.insert(dap.configurations.go, cfg)
-- --     end
-- --   end
-- --
-- --   if #dap.configurations.go > 0 then
-- --     print(string.format("[DAP] Loaded %d Go config(s)", #dap.configurations.go))
-- --     return true
-- --   end
-- --   return false
-- -- end
-- --
-- -- -- ===================================================================
-- -- -- 5. SETUP PROJECT
-- -- -- ===================================================================
-- -- local function setup_project_dap()
-- --   local has_json = load_launch_json()
-- --   if not has_json then
-- --     dapgo.setup()
-- --   end
-- -- end
-- --
-- -- setup_project_dap()
-- -- vim.api.nvim_create_autocmd("DirChanged", { callback = setup_project_dap })
-- --
-- -- -- ===================================================================
-- -- -- 6. KEYMAPS
-- -- -- ===================================================================
-- -- -- vim.keymap.set("n", "<F5>", dap.continue, { desc = "DAP: Continue" })
-- -- -- vim.keymap.set("n", "<leader>b", dap.toggle_breakpoint, { desc = "DAP: Breakpoint" })
