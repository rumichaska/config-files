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
    direction = "horizontal",
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
        local keymap = vim.keymap.set
        local opts = { noremap = true, silent = true, buffer = term.bufnr }
        keymap("n", "<Leader>tr", ":lua _R_TOGGLE()<CR>", opts)
        keymap("t", "<M-M>", " %>% ", opts)
        keymap("t", "<M-I>", " %in% ", opts)
        keymap("t", "<M-->", " <- ", opts)
    end,
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
    on_open = function(term)
        vim.cmd("startinsert!")
        local keymap = vim.keymap.set
        local opts = { noremap = true, silent = true, buffer = term.bufnr }
        keymap("n", "<Leader>tp", ":lua _PYTHON_TOGGLE()<CR>", opts)
    end,
})

function _PYTHON_TOGGLE()
    python:toggle()
end
