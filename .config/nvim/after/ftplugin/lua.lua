-- Settings
vim.opt_local.shiftwidth = 2

-- Functions and variables
local map = function(mode, lhs, rhs, desc)
  desc = desc or ""
  vim.keymap.set(mode, lhs, rhs, { buffer = 0, desc = "Lua: " .. desc })
end

-- Keymaps
map("n", "<LocalLeader><Space>x", "<Cmd>source %<CR>", "Source currente file")
map("n", "<LocalLeader>x", ":.lua<CR>", "Execute currente line")
map("v", "<LocalLeader>x", ":lua<CR>", "Execute currente line")
