-- Control de mensaje de errores por falta de indent_blankline
local status_ok, indent_blankline = pcall(require, "indent_blankline")
if not status_ok then
    return
end

-- Configuración de indent_blankline
indent_blankline.setup({
    -- char_blankline = "┆",
    use_treesitter = true,
    -- max_indent_increase = 1,
    -- show_first_indent_level = true,
    -- show_trailing_blankline_indent = true,
    -- show_end_of_line = true,
    -- filetype_exclude = {
    --     "lspinfo",
    --     "packer",
    --     "checkhealth",
    --     "help",
    --     "man",
    --     "",
    -- },
    -- buftype_exclude = {
    --     "terminal",
    --     "nofile",
    --     "quickfix",
    --     "prompt",
    -- },
    show_current_context = true,
    -- context_char_blankline = "┆",
    -- context_patterns = {
    --     "class",
    --     "^func",
    --     "method",
    --     "^if",
    --     "while",
    --     "for",
    --     "with",
    --     "try",
    --     "except",
    --     "arguments",
    --     "argument_list",
    --     "object",
    --     "dictionary",
    --     "element",
    --     "table",
    --     "tuple",
    --     "do_block",
    -- },
    use_treesitter_scope = true,
})
