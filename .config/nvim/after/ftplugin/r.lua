-- Settings
vim.opt_local.colorcolumn = "100"
vim.opt_local.shiftwidth = 4

-- Functions and variables
local map = function(mode, lhs, rhs, desc)
  desc = desc or ""
  vim.keymap.set(mode, lhs, rhs, { buffer = 0, desc = "R: " .. desc })
end
local source = 'source("' .. vim.fn.expand("%") .. '")'
local function augroup(name)
  return vim.api.nvim_create_augroup("R_" .. name, { clear = true })
end

-- Keymaps
map("i", "<C-S-m>", "<Esc>:normal! a |><CR>a ", "Base pipe operator")
map("i", "<C-S-i>", "<Esc>:normal! a %in%<CR>a ", "`%in%` operator")
map("i", "<M-->", "<Esc>:normal! a <-<CR>a ", "Asign operator")
map("n", "<LocalLeader>ts", "<Cmd>IronSend " .. source .. "<CR>", "Source file")
-- map("n", "<LocalLeader>tv", "<cmd>IronSend httpgd::hgd_url()<CR>", "Plot Viewer")
map("n", "<LocalLeader>tr", "<Cmd>IronRepl<CR>", "Open/Hide console")

-- Autocommands
vim.api.nvim_create_autocmd("TermOpen", {
  group = augroup("console"),
  desc = "R console",
  callback = function(event)
    if vim.bo[event.buf].filetype ~= "lazyterm" then
      map("n", "<LocalLeader>tr", "<cmd>IronHide r<CR>", "Open/Hide console")
      map("t", "<C-S-m>", " |> ", "Base pipe operator")
      map("t", "<C-S-i>", " %in% ", "`%in%`, operator")
      map("t", "<M-->", " <- ", "Asign operator")
      -- set filetype as "REPL"
      vim.opt_local.filetype = "REPL"
    end
  end,
})
