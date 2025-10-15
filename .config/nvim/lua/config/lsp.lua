-- Utilities
local Util = require("util")

-- Diagnostics

local diagnostics = {
  underline = true,
  update_in_insert = false,
  virtual_text = false,
  severity_sort = true,
  float = true
}
vim.diagnostic.config(vim.deepcopy(diagnostics))

-- LSP

vim.api.nvim_create_autocmd("LspAttach", {
  group = Util.augroup("aucmd_lsp"),
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
    map("K", function() vim.lsp.buf.hover() end, "Documentation")
    map("<C-s>", function() vim.lsp.buf.signature_help() end, "Signature help")
    map("<Leader>cd", function() vim.diagnostic.open_float() end, "Line diagnostic")
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
        group = Util.augroup("lsp_format_on_save"),
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
