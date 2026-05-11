local M = {}

-- Create autogroup for autocommands
function M.augroup(name)
  return vim.api.nvim_create_augroup("Config_" .. name, { clear = true })
end

-- Generate short path name
-- Example:
-- * /home/.config/nvim -> h/c/n
-- * /media/killa/Trabajo_Externo/CDC -> m/k/t/c
local function short_path_name(path)
  local dirs = {}
  for dir in path:gmatch("[^/]+") do
    local letter = dir:gsub("^%.*", ""):sub(1, 1)
    if letter ~= "" then
      table.insert(dirs, letter:lower())
    end
  end
  return table.concat(dirs, "/")
end

-- Create floating terminal
local terminals = {}
function M.float_term(opts)
  -- Set options
  opts = opts or {}
  local cwd = opts.cwd or vim.uv.cwd()
  local name = opts.name or short_path_name(cwd)
  local width = opts.width or math.floor(vim.o.columns * 0.8)
  local height = opts.height or math.floor(vim.o.lines * 0.8)
  local row = opts.row or math.floor((vim.o.lines - height) / 2)
  local col = opts.col or math.floor((vim.o.columns - width) / 2)
  -- Close existing floating window if exists
  if terminals[name]
      and terminals[name].win
      and vim.api.nvim_win_is_valid(terminals[name].win)
  then
    vim.api.nvim_win_close(terminals[name].win, true)
    terminals[name].win = nil
    return
  end
  -- Set/Store terminal variables
  local term = terminals[name]
  local win
  local buf
  -- Create/open terminal buffer only once
  if not term or not vim.api.nvim_buf_is_valid(term.buf) then
    buf = vim.api.nvim_create_buf(false, true)
    terminals[name] = {
      buf = buf,
      cwd = cwd,
    }
    win = vim.api.nvim_open_win(buf, true, {
      relative = "editor",
      width = width,
      height = height,
      row = row,
      col = col,
      style = "minimal",
    })
    terminals[name].win = win
    vim.fn.jobstart(vim.o.shell, { term = true, cwd = cwd })
    vim.cmd("startinsert!")
  else
    -- Reopen existing buf-terminal
    win = vim.api.nvim_open_win(term.buf, true, {
      relative = "editor",
      width = width,
      height = height,
      row = row,
      col = col,
      style = "minimal",
    })
    terminals[name].win = win
    vim.cmd("startinsert!")
  end
end

-- Returns the root directory based on:
-- * lsp workspace folders
-- * lsp root_dir
-- * root pattern of filename of the current buffer
-- * root pattern of cwd
local root_patterns = { ".git", "lua" }
function M.get_root()
  local path = vim.api.nvim_buf_get_name(0)
  local roots = {}
  if path then
    for _, client in pairs(vim.lsp.get_clients({ bufnr = 0 })) do
      local workspace = client.config.workspace_folders
      local paths = workspace and vim.tbl_map(function(ws)
        return vim.uri_to_fname(ws.uri)
      end, workspace) or client.config.root_dir and { client.config.root_dir } or {}
      for _, p in ipairs(paths) do
        local r = vim.uv.fs_realpath(p)
        ---@diagnostic disable-next-line: param-type-mismatch
        if path:find(r, 1, true) then
          roots[#roots + 1] = r
        end
      end
    end
  end
  table.sort(roots, function(a, b)
    return #a > #b
  end)
  local root = roots[1] -- longest root
  if not root then
    ---@diagnostic disable-next-line: cast-local-type
    path = path and vim.fs.dirname(path) or vim.uv.cwd()
    root = vim.fs.find(root_patterns, { path = path, upward = true })[1]
    root = root and vim.fs.dirname(root) or vim.uv.cwd()
  end
  return root
end

return M
