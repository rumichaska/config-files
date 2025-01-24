-- Settings
vim.opt_local.colorcolumn = "80"
vim.opt_local.shiftwidth = 4

-- Functions and variables
local map = function(mode, lhs, rhs, desc)
  desc = desc or ""
  vim.keymap.set(mode, lhs, rhs, { buffer = 0, desc = "Python: " .. desc })
end
local source = vim.fn.expand("%:p:.")
local function augroup(name)
  return vim.api.nvim_create_augroup("Python_" .. name, { clear = true })
end

-- Keymaps
map("n", "<M-s>", ":!python3 " .. source .. "<CR>", "Run source file")
map("n", "<LocalLeader>tr", "<cmd>IronRepl<CR>", "Toggle console")

-- Autocommands
vim.api.nvim_create_autocmd("TermOpen", {
  group = augroup("ipython"),
  desc = "Python console",
  callback = function(event)
    if vim.bo[event.buf].filetype == "iron" then
      map("n", "<LocalLeader>tr", "<cmd>IronHide python<CR>", "Toggle console")
    end
  end,
})
