-- Configuración de LSP R language
return {
    root_dir = function()
        -- Patrón de búsqueda de directorio de trabajo
        return vim.fs.dirname(vim.fs.find({ ".git", "*.Rproj" }, { upward = true })[1])
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
