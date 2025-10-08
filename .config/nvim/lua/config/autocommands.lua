-- Autocommands

-- Utilities
local Util = require("util")

vim.api.nvim_create_autocmd("TextYankPost", {
  group = Util.augroup("aucmd_highlight_yank"),
  desc = "Highlight when yanking (copying) text",
  callback = function()
    vim.highlight.on_yank()
  end,
})

vim.api.nvim_create_autocmd("BufReadPost", {
  group = Util.augroup("aucmd_last_loc"),
  desc = "Go to last location when opening a buffer",
  callback = function(event)
    local exclude = { "gitcommit" }
    local buf = event.buf
    if vim.tbl_contains(exclude, vim.bo[buf].filetype) then
      return
    end
    local mark = vim.api.nvim_buf_get_mark(buf, '"')
    local lcount = vim.api.nvim_buf_line_count(buf)
    if mark[1] > 0 and mark[1] <= lcount then
      pcall(vim.api.nvim_win_set_cursor, 0, mark)
    end
  end,
})

-- By filetypes

vim.api.nvim_create_autocmd("Filetype", {
  group = Util.augroup("aucmd_close_q"),
  pattern = { "help", "qf", "checkhealth" },
  desc = "Close with q",
  callback = function(event)
    local buf = event.buf
    vim.bo[buf].buflisted = false
    vim.schedule(function()
      vim.keymap.set("n", "q", function()
        vim.cmd("close")
        pcall(vim.api.nvim_buf_delete, buf, { force = true })
      end, { buffer = buf, desc = "Quit buffer" })
    end)
  end,
})

vim.api.nvim_create_autocmd("FileType", {
  group = Util.augroup("aucmd_wrap_spell"),
  pattern = { "text", "plaintex", "gitcommit", "markdown" },
  desc = "Wrap and check spell",
  callback = function()
    vim.opt_local.wrap = true
    vim.opt_local.spell = false
  end,
})

vim.api.nvim_create_autocmd("FileType", {
  group = Util.augroup("aucmd_indent_scope"),
  pattern = { "iron", "lazy", "mason" },
  desc = "Disable `mini.indentscope` by filetype",
  callback = function(event)
    vim.b[event.buf].miniindentscope_disable = true
  end,
})

-- Split window

vim.api.nvim_create_autocmd("VimResized", {
  group = Util.augroup("aucmd_resize_splits"),
  desc = "Resize splits if window got resized",
  callback = function()
    local current_tab = vim.fn.tabpagenr()
    vim.cmd("tabdo wincmd =")
    vim.cmd("tabnext " .. current_tab)
  end,
})
