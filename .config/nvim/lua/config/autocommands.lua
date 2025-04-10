local Util = require("util")

-- Augroup

local function augroup(name)
  return vim.api.nvim_create_augroup("ConfigAutocmd_" .. name, { clear = true })
end

-- Autocommands

-- Utilities

vim.api.nvim_create_autocmd("TextYankPost", {
  group = augroup("highlight_yank"),
  desc = "Highlight when yanking (copying) text",
  callback = function()
    vim.highlight.on_yank()
  end,
})

vim.api.nvim_create_autocmd("BufReadPost", {
  group = augroup("last_loc"),
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
  group = augroup("close_q"),
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
  group = augroup("wrap_spell"),
  pattern = { "text", "plaintex", "gitcommit", "markdown" },
  desc = "Wrap and check spell",
  callback = function()
    vim.opt_local.wrap = true
    vim.opt_local.spell = false
  end,
})

vim.api.nvim_create_autocmd("FileType", {
  group = augroup("indent_scope"),
  pattern = { "iron", "lazy", "mason" },
  desc = "Disable `mini.indentscope` by filetype",
  callback = function(event)
    vim.b[event.buf].miniindentscope_disable = true
  end,
})

-- Split window

vim.api.nvim_create_autocmd("VimResized", {
  group = augroup("resize_splits"),
  desc = "Resize splits if window got resized",
  callback = function()
    local current_tab = vim.fn.tabpagenr()
    vim.cmd("tabdo wincmd =")
    vim.cmd("tabnext " .. current_tab)
  end,
})

-- LSP

vim.api.nvim_create_autocmd("LspAttach", {
  group = augroup("lsp_configuration"),
  callback = function(event)
    local buffer = event.buf
    local client = vim.lsp.get_client_by_id(event.data.client_id)
    local telescope = require("telescope.builtin")
    local autoformat = { enabled = true }
    local map = function(keys, func, desc, mode)
      mode = mode or "n"
      vim.keymap.set(mode, keys, func, { buffer = buffer, desc = "LSP: " .. desc })
    end
    map("gd", telescope.lsp_definitions, "Goto definition")
    map("grn", vim.lsp.buf.rename, "Rename")
    map("gra", vim.lsp.buf.code_action, "Code action", { "n", "x" })
    map("grr", telescope.lsp_references, "Goto references")
    map("gri", telescope.lsp_implementations, "Goto implementation")
    map("gO", telescope.lsp_document_symbols, "Document symbols")
    map("K", function() vim.lsp.buf.hover({ border = "rounded" }) end, "Documentation")
    map("<C-s>", function() vim.lsp.buf.signature_help({ border = "rounded" }) end, "Signature help")
    map("<Leader>cd", function() vim.diagnostic.open_float({ border = "rounded" }) end, "Line diagnostic")
    map("<Leader>cf", vim.lsp.buf.format, "Format code", { "n", "v" })
    if not client then return end
    ---@diagnostic disable-next-line: missing-parameter, param-type-mismatch
    if client.supports_method("textDocument/formatting") then
      map("<Leader>tf", function()
          if autoformat.enabled then
            autoformat.enabled = false
            Util.warn("Disabled format on save")
          else
            autoformat.enabled = not autoformat.enabled
            Util.warn("Enabled format on save")
          end
        end,
        "Toggle autoformat"
      )
      vim.api.nvim_create_autocmd("BUfWritePre", {
        group = augroup("lsp_format_on_save"),
        buffer = buffer,
        desc = "Format on save",
        callback = function()
          if not autoformat.enabled then return end
          vim.lsp.buf.format({ bufnr = buffer, id = client.id })
        end,
      })
    end
    ---@diagnostic disable-next-line: missing-parameter, param-type-mismatch
    if client.supports_method("textDocument/inlayHint") then
      map("<Leader>th", function()
          vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled({ bufnr = buffer }))
          if vim.lsp.inlay_hint.is_enabled() then
            Util.warn("Enabled inlay hint")
          else
            Util.warn("Disabled inlay hint")
          end
        end,
        "Toggle inlay hint"
      )
    end
  end,
})
