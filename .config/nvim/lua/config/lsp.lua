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

local autoformat_enabled = true

vim.api.nvim_create_autocmd("LspAttach", {
  group = Util.augroup("lsp_init"),
  callback = function(args)
    local buffer = args.buf
    local client = vim.lsp.get_client_by_id(args.data.client_id)
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
    map("K", vim.lsp.buf.hover, "Documentation")
    map("<C-s>", vim.lsp.buf.signature_help, "Signature help")
    map("<Leader>cd", function() vim.diagnostic.open_float() end, "Line diagnostic")
    map("<Leader>cf", vim.lsp.buf.format, "Format code", { "n", "v" })
    if not client then return end

    ---@diagnostic disable-next-line: missing-parameter, param-type-mismatch
    if client.supports_method("textDocument/formatting") then
      map("<Leader>tf", function()
          local msg = require("lazy.core.util")
          autoformat_enabled = not autoformat_enabled
          local status = autoformat_enabled and "Enabled" or "Disabled"
          msg.warn(status .. " format on save")
        end,
        "Toggle autoformat"
      )
      vim.api.nvim_create_autocmd("BufWritePre", {
        buffer = buffer,
        group = Util.augroup("lsp_format_on_save"),
        desc = "Format on save",
        callback = function(event)
          if not autoformat_enabled then return end
          vim.lsp.buf.format({ bufnr = event.buf, id = client.id, async = false })
        end,
      })
    end
    ---@diagnostic disable-next-line: missing-parameter, param-type-mismatch
    if client.supports_method("textDocument/inlayHint") then
      map("<Leader>th", function()
          local msg = require("lazy.core.util")
          local is_enabled = vim.lsp.inlay_hint.is_enabled({ bufnr = buffer })
          vim.lsp.inlay_hint.enable(not is_enabled, { bufnr = buffer })
          if not is_enabled then
            msg.warn("Enabled inlay hint")
          else
            msg.warn("Disabled inlay hint")
          end
        end,
        "Toggle inlay hint"
      )
    end
  end,
  desc = "LSP: On attach configuration",
})
