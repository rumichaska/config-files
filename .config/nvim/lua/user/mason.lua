-- Control de mensaje de errores por falta de mason
local mason_ok, mason = pcall(require, "mason")
if not mason_ok then
    return
end

-- Control de mensaje de errores por falta de mason-lspconfig
local mason_lspconfig_ok, mason_lspconfig = pcall(require, "mason-lspconfig")
if not mason_lspconfig_ok then
    return
end

-- Control de mensaje de errores por falta de lspconfig
local lspconfig_ok, lspconfig = pcall(require, "lspconfig")
if not lspconfig_ok then
    return
end

-- Control de mensaje de errores por falta de cmp_nvim_lsp
local cmp_nvim_lsp_ok, cmp_nvim_lsp = pcall(require, "cmp_nvim_lsp")
if not cmp_nvim_lsp_ok then
    return
end

-- LSP CONFIG

-- Configuración de capabilities
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = cmp_nvim_lsp.default_capabilities(capabilities)

-- Configuración de on_attach, esta función se ejectura cuando se conecta un LSP
-- a un buffer
local on_attach = function(_, bufnr)
    -- Función local parar mapeo en normal mode
    local nmap = function(keys, func, desc)
        if desc then
            desc = "LSP: " .. desc
        end
        vim.keymap.set("n", keys, func, { buffer = bufnr, desc = desc })
    end
    -- Modificaciones
    nmap("<Leader>rn", vim.lsp.buf.rename, "[R]e[n]ame")
    nmap("<Leader>ca", vim.lsp.buf.code_action, "[C]ode [A]ction")
    -- Utilidades
    nmap("gd", vim.lsp.buf.definition, "[G]oto [D]efinition")
    nmap("gr", require("telescope.builtin").lsp_references, "[G]oto [R]eferences")
    nmap("gI", vim.lsp.buf.implementation, "[G]oto [I]mplementation")
    nmap("<Leader>D", vim.lsp.buf.type_definition, "Type [D]efinition")
    nmap("<Leader>ds", require("telescope.builtin").lsp_document_symbols, "[D]ocument [S]ymbols")
    nmap("<Leader>ws", require("telescope.builtin").lsp_dynamic_workspace_symbols, "[W]orkspace [S]ymbols")
    -- Documentación y diagnóstico
    nmap("K", vim.lsp.buf.hover, "Hover Documentation")
    nmap("gK", vim.lsp.buf.signature_help, "Signature Documentation")
    nmap("gl", vim.diagnostic.open_float, "Show diagnostic")
    -- Lesser used LSP functionality
    nmap("gD", vim.lsp.buf.declaration, "[G]oto [D]eclaration")
    nmap("<leader>wa", vim.lsp.buf.add_workspace_folder, "[W]orkspace [A]dd Folder")
    nmap("<leader>wr", vim.lsp.buf.remove_workspace_folder, "[W]orkspace [R]emove Folder")
    nmap("<leader>wl", function()
        print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
    end, "[W]orkspace [L]ist Folders")
    -- Formato
    vim.keymap.set({ "n", "v" }, "gf", function()
        vim.lsp.buf.format({ async = true })
    end, { buffer = bufnr, desc = "LSP: Format code" })
end

-- Configuración de servidores (LSP)
local servers = {
    cssls = {},
    html = {},
    julials = require("user.lsp.julials_lua"),
    pyright = require("user.lsp.pyright_lua"),
    r_language_server = require("user.lsp.r_language_lua"),
    sumneko_lua = require("user.lsp.sumneko_lua"),
}

-- Setup neovim lua configuration
-- require('neodev').setup()

-- Configuración de mason
mason.setup({
    ui = {
        border = "rounded",
    }
})

-- Instalación de servidores (LSP)
mason_lspconfig.setup {
    ensure_installed = vim.tbl_keys(servers),
    automatic_installation = false,
}

-- Configuración final de los servidores (LSP)

mason_lspconfig.setup_handlers({
    function(server_name)
        local opts = {
            capabilities = capabilities,
            on_attach = on_attach,
        }
        -- Opciones por LSP
        opts = vim.tbl_deep_extend("force", servers[server_name], opts)
        -- Configuración final
        lspconfig[server_name].setup(opts)
    end,
})

-- TODO: Implementar por servidor en mason_lspconfig.setup_handlers()
-- Definiendo función para sombreado de dependencias
-- local lsp_highlight_document = function(client, bufnr)
--     -- Establecer `autocommands` condicional en función a `server_capabilities`
--     if client.server_capabilities.documentHighlightProvider then
--         local lsp_hl_au = vim.api.nvim_create_augroup("lsp_document_highlight", {
--             clear = false
--         })
--         vim.api.nvim_clear_autocmds({
--             group = lsp_hl_au,
--             buffer = bufnr,
--         })
--         vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
--             group = lsp_hl_au,
--             buffer = bufnr,
--             callback = vim.lsp.buf.document_highlight
--         })
--         vim.api.nvim_create_autocmd({ "CursorMoved" }, {
--             group = lsp_hl_au,
--             buffer = bufnr,
--             callback = vim.lsp.buf.clear_references
--         })
--     end
-- end

-- Turn on lsp status information
-- require('fidget').setup()

-- DIAGNOSTIC CONFIG

-- Importación de íconos
local icons = require("user.icons")

-- Definiendo variable local para signos personalizados
local signs = {
    { name = "DiagnosticSignError", text = icons.diagnostics.Error },
    { name = "DiagnosticSignWarn", text = icons.diagnostics.Warning },
    { name = "DiagnosticSignHint", text = icons.diagnostics.Hint },
    { name = "DiagnosticSignInfo", text = icons.diagnostics.Information },
}

for _, sign in ipairs(signs) do
    vim.fn.sign_define(sign.name, { texthl = sign.name, text = sign.text, numhl = "" })
end

-- Definiendo variable local para mensajes de diagnóstico personalizados
local config = {
    -- Deshabilitar texto virtual de error
    virtual_text = false,
    -- Mostrar signos
    signs = {
        active = signs,
    },
    update_in_insert = true,
    underline = false,
    severity_sort = true,
    float = {
        focusable = false,
        style = "minimal",
        border = "rounded",
        source = "always",
        header = "",
        prefix = "",
    },
}

vim.diagnostic.config(config)

-- Handlers personalizados
vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, {
    border = "rounded",
})

vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, {
    border = "rounded",
})
