-- Definiendo variable local
local M = {}

-- Definiendo función para sombreado de dependencias
local lsp_highlight_document = function(client, bufnr)
    -- Establecer `autocommands` condicional en función a `server_capabilities`
    if client.server_capabilities.documentHighlightProvider then
        local lsp_hl_au = vim.api.nvim_create_augroup("lsp_document_highlight", {
            clear = false
        })
        vim.api.nvim_clear_autocmds({
            group = lsp_hl_au,
            buffer = bufnr,
        })
        vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
            group = lsp_hl_au,
            buffer = bufnr,
            callback = vim.lsp.buf.document_highlight
        })
        vim.api.nvim_create_autocmd({ "CursorMoved" }, {
            group = lsp_hl_au,
            buffer = bufnr,
            callback = vim.lsp.buf.clear_references
        })
    end
end

-- Definiendo función para mapeo
local lsp_keymaps = function(bufnr)
    local opts = { noremap = true, silent = true, buffer = bufnr }
    local keymap = vim.keymap.set
    -- Diagnostic
    keymap("n", "gl", vim.diagnostic.open_float, opts)
    keymap("n", "<Leader>dk", function()
        vim.diagnostic.goto_prev({ border = "rounded" })
    end, opts)
    keymap("n", "<Leader>dj", function()
        vim.diagnostic.goto_next({ border = "rounded" })
    end, opts)
    keymap("n", "<leader>dq", vim.diagnostic.setloclist, opts)
    -- Format
    keymap({ "n", "v" }, "gf", function()
        -- vim.lsp.buf.format()
        vim.lsp.buf.format({ async = true })
    end, opts)
    -- keymap("v", "gf", ":lua vim.lsp.buf.range_formatting()<CR>", opts)
    -- Documentation
    keymap("n", "gD", vim.lsp.buf.declaration, opts)
    keymap("n", "gd", vim.lsp.buf.definition, opts)
    keymap("n", "gi", vim.lsp.buf.implementation, opts)
    keymap("n", "gr", vim.lsp.buf.references, opts)
    keymap("n", "K", vim.lsp.buf.hover, opts)
    keymap("n", "gK", vim.lsp.buf.signature_help, opts)
    keymap("n", "<leader>rn", vim.lsp.buf.rename, opts)
    keymap("n", "<leader>ca", vim.lsp.buf.code_action, opts)
end

-- Definiendo función on_attach
M.on_attach = function(client, bufnr)
    lsp_keymaps(bufnr)
    lsp_highlight_document(client, bufnr)
end

-- Definiendo variable local para `capabilities` con cmp-nvim-lsp
local capabilities = vim.lsp.protocol.make_client_capabilities()

local status_ok, cmp_nvim_lsp = pcall(require, "cmp_nvim_lsp")
if not status_ok then
    return
end

-- Definiendo función `capabilities`
-- M.capabilities = cmp_nvim_lsp.update_capabilities(capabilities)
M.capabilities = cmp_nvim_lsp.default_capabilities(capabilities)

return M
