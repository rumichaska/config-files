-- Control de mensaje de errores por falta de treesitter
local status_ok, configs = pcall(require, "nvim-treesitter.configs")
if not status_ok then
	return
end
--
-- Parsers con soporte
local ts_parser = {
    "bash",
    "comment",
    "css",
    "help",
    "html",
    "lua",
    "make",
    "markdown",
    "markdown_inline",
    "python",
    "r",
    "scss",
    "yaml",
}

-- Configuración de treesitter
configs.setup({
    -- Configuración de treesitter, modificar según lenguajes
    ensure_installed = ts_parser,   -- Solo instalar lenguajes con soporte
    sync_install = false,           -- Sincronización solo lenguajes con soporte
    ignore_install = {},            -- Lista de `parsers` a ignorar en instalación
    highlight = {
        enable = true,              -- `false` deshabilitará la extensión
    },
    indent = {
        enable = true,
    },
    incremental_selection = {
        enable = true,
        keymaps = {
            init_selection = "<c-space>",
            node_incremental = "<c-space>",
            scope_incremental = "<c-s>",
            node_decremental = "<c-backspace>",
        },
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
