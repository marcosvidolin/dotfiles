local dap = require("dap")
local dapgo = require("dap-go")
local dapui = require("dapui")
local envmod = require("gverse.core.env")

-- Open/close DAP UI automatically
dap.listeners.after.event_initialized["dapui_config"] = function()
  dapui.open()
end
dap.listeners.before.event_terminated["dapui_config"] = function()
  dapui.close()
end
dap.listeners.before.event_exited["dapui_config"] = function()
  dapui.close()
end

-- Delve adapter (server mode)
dap.adapters.delve = {
  type = "server",
  port = "${port}",
  executable = {
    command = "dlv",
    args = { "dap", "-l", "127.0.0.1:${port}" },
  },
}

local function load_launch_json()
  local path = vim.fn.getcwd() .. "/.vscode/launch.json"
  if vim.fn.filereadable(path) ~= 1 then
    return false
  end

  local content = vim.fn.readfile(path)
  local ok, data = pcall(vim.fn.json_decode, table.concat(content, "\n"))
  if not ok or type(data) ~= "table" or type(data.configurations) ~= "table" then
    return false
  end

  dap.configurations.go = {}

  for _, cfg in ipairs(data.configurations) do
    if cfg.type == "go" then
      cfg.type = "delve"
      cfg.cwd = cfg.cwd or "${workspaceFolder}"

      local env = envmod.load_env_from_cwd()

      local env_file = cfg.envFile
      if type(env_file) == "string" then
        env_file = env_file:gsub("%${workspaceFolder}", vim.fn.getcwd())
      elseif type(env_file) == "table" and type(env_file[1]) == "string" then
        env_file = env_file[1]:gsub("%${workspaceFolder}", vim.fn.getcwd())
      else
        env_file = nil
      end

      if env_file and vim.fn.filereadable(env_file) == 1 then
        env = vim.tbl_extend("force", env, envmod.load_env_file(env_file))
      end

      cfg.env = vim.tbl_extend("force", cfg.env or {}, env)
      cfg.envFile = nil

      table.insert(dap.configurations.go, cfg)
    end
  end

  return #dap.configurations.go > 0
end

local function setup_project_dap()
  local has_json = load_launch_json()
  if not has_json then
    dapgo.setup()
  end
end

setup_project_dap()
vim.api.nvim_create_autocmd("DirChanged", { callback = setup_project_dap })
