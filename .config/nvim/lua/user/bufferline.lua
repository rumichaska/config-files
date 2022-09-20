-- Control de mensaje de errores por falta de bufferline
local status_ok, bufferline = pcall(require, "bufferline")
if not status_ok then
    return
end

-- Configuración de bufferline
bufferline.setup({
    options = {
        numbers = "ordinal",
        close_command = "bdelete! %d",
        right_mouse_command = "vertical sbuffer %d", -- Abre el buffer en una ventana vertical
        left_mouse_command = "buffer %d",
        middle_mouse_command = nil,
        indicator = {
            icon = "▌",
            style = "icon",
        },
        buffer_close_icon = "",
        modified_icon = "●",
        close_icon = "",
        left_trunc_marker = "",
        right_trunc_marker = "",
        max_name_length = 30,
        max_prefix_length = 30,
        tab_size = 22,
        diagnostics = false,
        diagnostics_update_in_insert = false,
        offsets = {
            {
                filetype = "NvimTree",
                text = "Explorador",
            }
        },
        color_icons = true,
        show_buffer_icons = true,
        show_buffer_close_icons = true,
        show_close_icon = true,
        show_tab_indicators = true,
        persist_buffer_sort = true,
        separator_style = "thin", -- | "thick" | "thin" | "slant" | { 'any', 'any' },
        enforce_regular_tabs = true,
        always_show_bufferline = true,
    },
})

