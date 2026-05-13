-- Utilities
local Util = require("util")

-- Diagnostics

vim.diagnostic.config({
  severity_sort = true,
  signs = {
    text = {
      [vim.diagnostic.severity.ERROR] = Util.icons["error"],
      [vim.diagnostic.severity.WARN] = Util.icons["warn"],
      [vim.diagnostic.severity.INFO] = Util.icons["info"],
      [vim.diagnostic.severity.HINT] = Util.icons["hint"],
    },
  },
})

-- LSP

vim.api.nvim_create_autocmd("LspAttach", {
  group = Util.augroup("lsp_init"),
  callback = function(args)
    local buffer = args.buf
    local client_id = args.data.client_id
    local client = vim.lsp.get_client_by_id(client_id)

    if not client then return end

    local telescope = require("telescope.builtin")
    local map = function(keys, func, desc, mode)
      mode = mode or "n"
      vim.keymap.set(mode, keys, func, { buf = buffer, desc = "LSP: " .. desc })
    end
    map("grd", telescope.lsp_definitions, "Goto definition")
    map("grt", telescope.lsp_type_definitions, "Goto type definition")
    map("grr", telescope.lsp_references, "Goto references")
    map("gri", telescope.lsp_implementations, "Goto implementation")
    map("grn", vim.lsp.buf.rename, "Rename")
    map("gra", vim.lsp.buf.code_action, "Code action", { "n", "x" })
    map("gO", telescope.lsp_document_symbols, "Open document symbols")
    map("gW", telescope.lsp_dynamic_workspace_symbols, "Open workspace symbols")
    map("K", vim.lsp.buf.hover, "Open documentation")
    map("<C-s>", vim.lsp.buf.signature_help, "Open signature help")
    map("<Leader>cd", vim.diagnostic.open_float, "Open line diagnostic")
    -- LSP formatting
    map("<Leader>cf", vim.lsp.buf.format, "Format code", { "n", "x" })

    -- LSP documentColor
    if client:supports_method("textDocument/documentColor") then
      vim.lsp.document_color.enable(true, { bufnr = buffer })
      map("<Leader>tc", function()
        vim.lsp.document_color.enable(not vim.lsp.document_color.is_enabled({ bufnr = buffer }), { bufnr = buffer })
      end, "Toggle document color")
    end

    -- LSP foldingRange
    if client:supports_method("textDocument/foldingRange") then
      local win = vim.api.nvim_get_current_win()
      -- LSP over treesitter
      vim.wo[win][0].foldexpr = "v:lua.vim.lsp.foldexpr()"
    end

    -- LSP documentHighlight
    if client:supports_method("textDocument/documentHighlight") then
      vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
        buf = buffer,
        group = Util.augroup("lsp_document_highglight"),
        callback = function()
          vim.lsp.buf.document_highlight()
        end
      })
      vim.api.nvim_create_autocmd("CursorMoved", {
        buf = buffer,
        group = Util.augroup("lsp_highlight_clear"),
        callback = function()
          vim.lsp.buf.clear_references()
        end
      })
    end

    -- LSP inlayHint
    if client:supports_method("textDocument/inlayHint") then
      vim.lsp.inlay_hint.enable(false, { bufnr = buffer })
      map("<Leader>th", function()
          vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled({bufnr = buffer}), { bufnr = buffer })
        end,
        "Toggle inlay hint"
      )
    end
  end,
  desc = "LSP: On attach configuration",
})
