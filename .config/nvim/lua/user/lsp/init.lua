-- Control de mensaje de errores por falta de lsp
local status_ok, nvim_lsp = pcall(require, "lspconfig")
if not status_ok then
    return
end

-- Definiendo variable local para personalización de `setup`
require("user.lsp.custom_config")

-- Definiendo variable local para personalización de `handlers`
local lsp_handlers = require("user.lsp.handlers")

-- CONFIGURACIÓN GLOBAL DE LSP DE FORMA MANUAL

-- LSP R: r_language_server
nvim_lsp.r_language_server.setup({
    on_attach = lsp_handlers.on_attach,
    capabilities = lsp_handlers.capabilities,
    flags = {
        debounce_text_changes = 150,
    },
    -- Configuración adicional
    settings = {
        r = {
            lsp = {
                diagnostics = true,
            },
        },
	},
})

-- CONFIGURACIÓN LOCAL DE LSP CON LSP-INSTALLER

-- Control de mensaje de errores por falta de lsp-installer
local installer_status_ok, lsp_installer = pcall(require, "nvim-lsp-installer")
if not installer_status_ok then
    return
end

-- Register a handler that will be called for all installed servers.
-- Alternatively, you may also register handlers on specific server instances instead (see example below).
lsp_installer.on_server_ready(function(server)
    local opts = {
        on_attach = lsp_handlers.on_attach,
        capabilities = lsp_handlers.capabilities,
        flags = {
            debounce_text_changes = 150,
        },
    }

    -- LSP Lua: sumneko_lua
    if server.name == "sumneko_lua" then
        local sumneko_opts = require("user.lsp.settings.sumneko_lua")
        opts = vim.tbl_deep_extend("force", sumneko_opts, opts)
    end

    -- LSP R: r_language_server (probar, no funciona tan bien)
    -- if server.name == "r_language_server" then
    --     local r_lang_opts = require("user.lsp.settings.r_language_lua")
    --     opts = vim.tbl_deep_extend("force", r_lang_opts, opts)
    -- end

    -- This setup() function is exactly the same as lspconfig's setup function.
	-- Refer to https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md
    server:setup(opts)
end)
