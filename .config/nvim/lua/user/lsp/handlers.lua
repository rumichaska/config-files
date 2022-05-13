-- Definiendo variable local
local M = {}

-- Definiendo función para sombreado de dependencias
local lsp_highlight_document = function(client)
    -- Establecer `autocommands` condicional en función a `server_capabilities`
    -- if client.server_capabilities.documentHighlightProvider then
    if client.server_capabilities.documentHighlightProvider then
        local bufnr = vim.api.nvim_get_current_buf()
        local lsp_hl_au = vim.api.nvim_create_augroup("lsp_document_highlight", {
            clear = false
        })
        vim.api.nvim_clear_autocmds({
            buffer = bufnr,
            group = lsp_hl_au
        })
        vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
            group = lsp_hl_au,
            buffer = bufnr,
            callback = vim.lsp.buf.document_highlight
        })
        vim.api.nvim_create_autocmd("CursorMoved", {
            group = lsp_hl_au,
            buffer = bufnr,
            callback = vim.lsp.buf.clear_references
        })
    end
end

-- Definiendo función para mapeo
local lsp_keymaps = function(bufnr)
    local opts = { noremap = true, silent = true }
    vim.api.nvim_buf_set_keymap(bufnr, "n", "gD", ":lua vim.lsp.buf.declaration()<CR>", opts)
    vim.api.nvim_buf_set_keymap(bufnr, "n", "gd", ":lua vim.lsp.buf.definition()<CR>", opts)
    vim.api.nvim_buf_set_keymap(bufnr, "n", "gi", ":lua vim.lsp.buf.implementation()<CR>", opts)
    vim.api.nvim_buf_set_keymap(bufnr, "n", "gr", ":lua vim.lsp.buf.references()<CR>", opts)
    vim.api.nvim_buf_set_keymap(bufnr, "n", "gl", ":lua vim.diagnostic.open_float()<CR>", opts)
    vim.api.nvim_buf_set_keymap(bufnr, "n", "gf", ":lua vim.lsp.buf.formatting()<CR>", opts)
    vim.api.nvim_buf_set_keymap(bufnr, "n", "K", ":lua vim.lsp.buf.hover()<CR>", opts)
    vim.api.nvim_buf_set_keymap(bufnr, "n", "<C-k>", ":lua vim.lsp.buf.signature_help()<CR>", opts)
    vim.api.nvim_buf_set_keymap(bufnr, "n", "<Leader>dk", ":lua vim.diagnostic.goto_prev({ border = 'rounded' })<CR>", opts)
    vim.api.nvim_buf_set_keymap(bufnr, "n", "<Leader>dj", ":lua vim.diagnostic.goto_next({ border = 'rounded' })<CR>", opts)
    vim.api.nvim_buf_set_keymap(bufnr, "n", "<leader>dq", ":lua vim.diagnostic.setloclist()<CR>", opts)
    vim.api.nvim_buf_set_keymap(bufnr, "n", "<leader>rn", ":lua vim.lsp.buf.rename()<CR>", opts)
    -- vim.api.nvim_buf_set_keymap(bufnr, "n", "<leader>ca", ":lua vim.lsp.buf.code_action()<CR>", opts)
end

-- Definiendo función on_attach
M.on_attach = function(client, bufnr)
    if client.name == "tsserver" then
        client.resolved_capabilities.document_formatting = false
    end
    lsp_keymaps(bufnr)
    lsp_highlight_document(client)
end

-- Definiendo variable local para `capabilities` con cmp-nvim-lsp
local capabilities = vim.lsp.protocol.make_client_capabilities()

local status_ok, cmp_nvim_lsp = pcall(require, "cmp_nvim_lsp")
if not status_ok then
    return
end

-- Definiendo función `capabilities`
M.capabilities = cmp_nvim_lsp.update_capabilities(capabilities)

return M
