-- Control de mensaje de errores por falta de toggleterm
local status_ok, toggleterm = pcall(require, "toggleterm")
if not status_ok then
    return
end

-- Configuración de toggleterm
toggleterm.setup({
    -- Función para el tamaño según horizontal o vertical
    size = function(term)
        if term.direction == "horizontal" then
            return 20
        elseif term.direction == "vertical" then
            return vim.o.columns * 0.4 -- 40% del ancho de la ventana del terminal
        end
    end,
    open_mapping = [[<C-\>]], -- Depende de la configuración del teclado
    hide_numbers = true,
    direction = "float",
    shell = vim.o.shell,
    -- Información relevante cuando direction = "float"
    float_opts = {
        border = "curved",
        winblend = 3,
    },
    winbar = {},
})
