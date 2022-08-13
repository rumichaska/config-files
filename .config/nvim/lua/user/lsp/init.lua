-- CONFIGURACIÓN GLOBAL DE LSP

-- Cargar configuración personalizada de `setup`
require("user.lsp.custom_config")

-- Definiendo variable local para personalización de `handlers`
local lsp_handlers = require("user.lsp.handlers")

-- CONFIGURACIÓN LOCAL DE LSP CON LSP-INSTALLER

-- Control de mensaje de errores por falta de lsp-installer
local installer_status_ok, lsp_installer = pcall(require, "nvim-lsp-installer")
if not installer_status_ok then
    return
end

-- Configuración de LSP por lenguaje
lsp_installer.on_server_ready(function(server)
    -- Configuración de 'handlers' personalizados
    local opts = {
        on_attach = lsp_handlers.on_attach,
        capabilities = lsp_handlers.capabilities,
        flags = {
            debounce_text_changes = 150,
        },
    }

    -- Configuración de cada lenguaje

    -- LSP Lua: sumneko_lua
    if server.name == "sumneko_lua" then
        local sumneko_opts = require("user.lsp.settings.sumneko_lua")
        opts = vim.tbl_deep_extend("force", sumneko_opts, opts)
    end

    -- LSP R: r_language_server
    if server.name == "r_language_server" then
        local r_lang_opts = require("user.lsp.settings.r_language_lua")
        opts = vim.tbl_deep_extend("force", r_lang_opts, opts)
    end

    -- LSP Python: pyright
    if server.name == "pyright" then
        local pyright_opts = require("user.lsp.settings.pyright_lua")
        opts = vim.tbl_deep_extend("force", pyright_opts, opts)
    end

    -- This setup() function is exactly the same as lspconfig's setup function.
    -- Refer to https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md
    server:setup(opts)
end)

-- CONFIGURACIÓN GLOBAL DE LSP DE FORMA MANUAL (opcional cuando no funciona
-- bien el rlanguageserver local)

-- -- Control de mensaje de errores por falta de lsp
-- local status_ok, nvim_lsp = pcall(require, "lspconfig")
-- if not status_ok then
--     return
-- end
-- -- LSP R: r_language_server
-- nvim_lsp.r_language_server.setup({
--     on_attach = lsp_handlers.on_attach,
--     capabilities = lsp_handlers.capabilities,
--     flags = {
--         debounce_text_changes = 150,
--     },
--     -- Configuración adicional
--     settings = {
--         r = {
--             lsp = {
--                 diagnostics = true,
--                 rich_documentation = false,
--             },
--         },
-- 	},
-- })
