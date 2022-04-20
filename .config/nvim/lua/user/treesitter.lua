-- Control de mensaje de errores por falta de treesitter
local status_ok, configs = pcall(require, "nvim-treesitter.configs")
if not status_ok then
	return
end

-- Configuración de treesitter
configs.setup({
    -- Configuración de treesitter, modificar según lenguajes
    ensure_installed = "maintained",    -- Solo instalar lenguajes con soporte
    sync_install = false,               -- Sincronización solo lenguajes con soporte
    ignore_install = {},                -- Lista de `parsers` a ignorar en instalación
    highlight = {
        enable = true,                  -- `false` deshabilitará la extensión
        disable = {},
        additional_vim_regex_highlighting = true,
    },
    indent = {
        enable = true,
        disable = { "yaml" }
    },
    -- Agregando configuración complementaria de nvim-ts-rainbow
    rainbow = {
        enable = true,
        -- disable = { "jsx", "cpp" },  -- Listado de lenguajes a omitir
        extended_mode = true,
        max_file_lines = nil,
        -- colors = {},                 -- Tabla con colores HEX
        -- termcolors = {},             -- Tabla con nombre de colores
    },
    -- Agregando configuración para comentarios según lenguajes
    context_commentstring = {
        enable = true,
        enable_autocmd = false,
    },
})
