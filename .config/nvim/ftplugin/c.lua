-- Settings
vim.opt_local.colorcolumn = "80"
vim.opt_local.shiftwidth = 2

-- Functions and variables
local map = function(mode, lhs, rhs, desc)
  desc = desc or ""
  vim.keymap.set(mode, lhs, rhs, { buf = 0, desc = "C: " .. desc })
end
local source = vim.fn.expand("%")

-- Keymaps
map("n", "<M-s>", ":!gcc -Wall -g " .. source .. " -o " .. source:gsub("(%w+).c", "%1") .. "<CR>", "Compile file")
