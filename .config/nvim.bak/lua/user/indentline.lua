-- Control de mensaje de errores por falta de indent_blankline
local status_ok, indent_blankline = pcall(require, "indent_blankline")
if not status_ok then
    return
end

-- Configuración de indent_blankline
indent_blankline.setup({
    use_treesitter = true,
    show_current_context = true,
    use_treesitter_scope = true,
})
