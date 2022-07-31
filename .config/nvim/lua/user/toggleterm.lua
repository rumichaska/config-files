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
    shade_filetypes = {},
    shade_terminals = true,
    shading_factor = 1,
    start_in_insert = true,
    insert_mappings = true,
    persist_size = true,
    direction = "horizontal",
    close_on_exit = true,
    shell = vim.o.shell,
    -- Información relevante cuando direction = "float"
    float_opts = {
        border = "curved",
        winblend = 3,
    },
    winbar = {},
})

-- Funciones para abrir terminales personalizados
local Terminal = require("toggleterm.terminal").Terminal

-- Terminal personalizado : R
local r = Terminal:new({
    cmd = "R",
    dir = vim.fn.getcwd(),
    hidden = true,
    count = 10,
    on_open = function(term)
        vim.cmd("startinsert!")
        vim.keymap.set("t", "<M-M>", " %>% ", { noremap = true, silent = true, buffer = term.bufnr })
        vim.keymap.set("t", "<M-I>", " %in% ", { noremap = true, silent = true, buffer = term.bufnr })
        vim.keymap.set("t", "<M-->", " <- ", { noremap = true, silent = true, buffer = term.bufnr })
    end,
    -- on_close = function(term)
    --     vim.cmd("Closing terminal")
    -- end,
})

function _R_TOGGLE()
    r:toggle()
end

-- Terminal personalizado : Python
local python = Terminal:new({
    cmd = "python3",
    dir = vim.fn.getcwd(),
    hidden = true,
    count = 20,
})

function _PYTHON_TOGGLE()
    python:toggle()
end
