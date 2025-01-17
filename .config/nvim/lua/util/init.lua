local M = {}

-- function M.on_attach(on_attach)
--   vim.api.nvim_create_autocmd("LspAttach", {
--     callback = function(args)
--       local buffer = args.buf
--       local client = vim.lsp.get_client_by_id(args.data.client_id)
--       on_attach(client, buffer)
--     end,
--   })
-- end

-- Check if plugin is present and enabled
function M.has(plugin)
  return require("lazy.core.config").spec.plugins[plugin] ~= nil
end

-- Get plugin opts as a table
function M.opts(name)
  local plugin = require("lazy.core.config").plugins[name]
  if not plugin then
    return {}
  end
  local Plugin = require("lazy.core.plugin")
  return Plugin.values(plugin, "opts", false)
end

-- Get foreground color from highlight group
function M.fg(name)
  local hl = vim.api.nvim_get_hl and vim.api.nvim_get_hl(0, { name = name })
  local fg = hl and hl.fg
  return fg and { fg = string.format("#%06x", fg) }
end

-- Returns the root directory based on:
-- * lsp workspace folders
-- * lsp root_dir
-- * root pattern of filename of the current buffer
-- * root pattern of cwd
M.root_patterns = { ".git", "lua" }

function M.get_root()
  local path = vim.api.nvim_buf_get_name(0)
  path = path ~= "" and vim.uv.fs_realpath(path) or nil
  local roots = {}
  if path then
    for _, client in pairs(vim.lsp.get_clients({ bufnr = 0 })) do
      local workspace = client.config.workspace_folders
      local paths = workspace and vim.tbl_map(function(ws)
        return vim.uri_to_fname(ws.uri)
      end, workspace) or client.config.root_dir and { client.config.root_dir } or {}
      for _, p in ipairs(paths) do
        local r = vim.uv.fs_realpath(p)
        if path:find(r, 1, true) then
          roots[#roots + 1] = r
        end
      end
    end
  end
  table.sort(roots, function(a, b)
    return #a > #b
  end)
  local root = roots[1]
  if not root then
    path = path and vim.fs.dirname(path) or vim.uv.cwd()
    root = vim.fs.find(M.root_patterns, { path = path, upward = true })[1]
    root = root and vim.fs.dirname(root) or vim.uv.cwd()
  end
  return root
end

-- Opens a floating terminal (interactive by default)
local terminals = {}
function M.float_term(cmd, opts)
  opts = vim.tbl_deep_extend("force", {
    ft = "floaterm",
    size = { width = 0.8, height = 0.9 },
  }, opts or {}, { persistent = true })

  local termkey = vim.inspect({ cmd = cmd or "shell", cwd = opts.cwd, env = opts.env, count = vim.v.count1 })

  if terminals[termkey] and terminals[termkey]:buf_valid() then
    terminals[termkey]:toggle()
  else
    terminals[termkey] = require("lazy.util").float_term(cmd, opts)
    local buf = terminals[termkey].buf
    vim.b[buf].lazyterm_cmd = cmd
    if opts.esc_esc == false then
      vim.keymap.set("t", "<Esc>", "<Esc>", { buffer = buf, nowait = true })
    end
    if opts.ctrl_hjkl == false then
      vim.keymap.set("t", "<C-h>", "<C-h>", { buffer = buf, nowait = true })
      vim.keymap.set("t", "<C-j>", "<C-j>", { buffer = buf, nowait = true })
      vim.keymap.set("t", "<C-k>", "<C-k>", { buffer = buf, nowait = true })
      vim.keymap.set("t", "<C-l>", "<C-l>", { buffer = buf, nowait = true })
    end

    vim.api.nvim_create_autocmd("BufEnter", {
      buffer = buf,
      callback = function()
        vim.cmd.startinsert()
      end,
    })
  end

  return terminals[termkey]
end

-- Toggle UI components
function M.toggle(option, silent, values)
  local Util = require("lazy.core.util")
  if values then
    if vim.opt_local[option]:get() == values[1] then
      vim.opt_local[option] = values[2]
    else
      vim.opt_local[option] = values[1]
    end
    return Util.info("Set " .. option .. " to " .. vim.opt_local[option]:get(), { title = "Option" })
  end
  vim.opt_local[option] = not vim.opt_local[option]:get()
  if not silent then
    if vim.opt_local[option]:get() then
      Util.warn("Enabled " .. option, { title = "Option" })
    else
      Util.warn("Disabled " .. option, { title = "Option" })
    end
  end
end

-- Toggle language for spelling en|es
function M.language()
  local Util = require("lazy.core.util")
  if vim.opt_local["spelllang"]:get()[1] == "en" then
    vim.opt_local["spelllang"] = "es"
    Util.warn("Enabled spanish language", { title = "Language" })
  elseif vim.opt_local["spelllang"]:get()[1] == "es" then
    vim.opt_local["spelllang"] = "en"
    Util.warn("Enabled english language", { title = "Language" })
  end
end

-- Toggle line numbers
local nu = { number = true, relativenumber = true }
function M.toggle_number()
  local Util = require("lazy.core.util")
  if vim.opt_local.number:get() or vim.opt_local.relativenumber:get() then
    nu = { number = vim.opt_local.number:get(), relativenumber = vim.opt_local.relativenumber:get() }
    vim.opt_local.number = false
    vim.opt_local.relativenumber = false
    Util.warn("Disabled line numbers", { title = "Option" })
  else
    vim.opt_local.number = nu.number
    vim.opt_local.relativenumber = nu.relativenumber
    Util.warn("Enabled line numbers", { title = "Option" })
  end
end

-- Toggle diagnostics
function M.toggle_diagnostics()
  local Util = require("lazy.core.util")
  local enabled = vim.diagnostic.is_enabled()
  if not enabled then
    vim.diagnostic.enable()
    Util.info("Enabled diagnostics", { title = "Diagnostics" })
  else
    vim.diagnostic.enable(false)
    Util.warn("Disabled diagnostics", { title = "Diagnostics" })
  end
end

return M
