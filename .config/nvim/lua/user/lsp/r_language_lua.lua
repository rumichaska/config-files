-- Configuración de LSP R language

-- Control de mensaje de errores por falta de lspconfig
local lspconfig_status_ok, util = pcall(require, "lspconfig.util")
if not lspconfig_status_ok then
    return
end

-- Configuración
return {
    root_dir = function(fname)
        -- Patrón de búsqueda de directorio de trabajo
        return util.root_pattern("*.Rproj")(fname) or util.find_git_ancestor(fname) or vim.loop.os_homedir()
    end,
    settings = {
        r = {
            lsp = {
                diagnostics = true,
                rich_documentation = false,
            },
        },
    },
}
