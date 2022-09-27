-- Control de mensaje de errores por falta de mason
local status_ok, mason = pcall(require, "mason")
if not status_ok then
    return
end

-- Control de mensaje de errores por falta de mason-lspconfig
local status_ok_1, mason_lspconfig = pcall(require, "mason-lspconfig")
if not status_ok_1 then
    return
end

-- Control de mensaje de errores por falta de lspconfig
local lspconfig_status_ok, lspconfig = pcall(require, "lspconfig")
if not lspconfig_status_ok then
    return
end

-- Definiendo variable local para control de LSP
local servers = {
    "julials",
    "pyright",
    "r_language_server",
    "sumneko_lua",
}

-- Configuración de mason
mason.setup({
    ui = {
        border = "rounded",
    }
})

-- Configuración de mason-lspconfig
mason_lspconfig.setup({
    ensure_installed = servers,
    automatic_installation = false,
})

-- Configuración de servidores

-- Definiendo variable local para las opciones del LSP
local opts = {}

-- Función para manejo de LSP
for _, server in pairs(servers) do

    -- Configuración de 'handlers' personalizados
    opts = {
        on_attach = require("user.lsp.handlers").on_attach,
        capabilities = require("user.lsp.handlers").capabilities,
    }

    -- Nombre del servidor
    server = vim.split(server, "@")[1]

    -- Configuración de cada lenguaje

    -- LSP Julia: julials
    if server == "julials" then
        local julials_opts = require("user.lsp.settings.julials_lua")
        opts = vim.tbl_deep_extend("force", julials_opts, opts)
    end

    -- LSP Python: pyright
    if server == "pyright" then
        local pyright_opts = require("user.lsp.settings.pyright_lua")
        opts = vim.tbl_deep_extend("force", pyright_opts, opts)
    end

    -- LSP R: r_language_server
    if server == "r_language_server" then
        local r_lang_opts = require("user.lsp.settings.r_language_lua")
        opts = vim.tbl_deep_extend("force", r_lang_opts, opts)
    end

    -- LSP Lua: sumneko_lua
    if server == "sumneko_lua" then
        local sumneko_opts = require("user.lsp.settings.sumneko_lua")
        opts = vim.tbl_deep_extend("force", sumneko_opts, opts)
    end

    lspconfig[server].setup(opts)
    ::continue::
end
