-- Control de mensaje de errores por falta de treesitter
local status_ok, configs = pcall(require, "nvim-treesitter.configs")
if not status_ok then
	return
end
--
-- Parsers con soporte
local ts_parser = {
    "css",
    "lua",
    "markdown",
    "markdown_inline",
    "python",
    "r",
}

-- Configuración de treesitter
configs.setup({
    -- Configuración de treesitter, modificar según lenguajes
    ensure_installed = ts_parser,   -- Solo instalar lenguajes con soporte
    sync_install = false,           -- Sincronización solo lenguajes con soporte
    ignore_install = {},            -- Lista de `parsers` a ignorar en instalación
    highlight = {
        enable = true,              -- `false` deshabilitará la extensión
        additional_vim_regex_highlighting = false,
    },
    indent = {
        enable = true,
    },
    -- Agregando configuración complementaria de nvim-ts-rainbow
    rainbow = {
        enable = true,
        extended_mode = true,
        max_file_lines = nil,
    },
    -- Agregando configuración para comentarios según lenguajes
    context_commentstring = {
        enable = true,
        enable_autocmd = false,
    },
})
