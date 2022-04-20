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
    shell = vim.o.shell, -- shell por defecto (linux)
    -- shell = "pwsh.exe",
    -- Información relevante cuando direction = "float"
    float_opts = {
        border = "curved",
        winblend = 0,
        highlights = {
            border = "Normal",
            background = "Normal",
        },
    },
})

-- Mapeo
function _G.set_terminal_keymaps()
  local opts = { noremap = true }
  -- vim.api.nvim_buf_set_keymap(0, "t", "jk", [[<C-\><C-n>]], opts)
  vim.api.nvim_buf_set_keymap(0, "t", "<esc>", [[<C-\><C-n>]], opts)
  vim.api.nvim_buf_set_keymap(0, "t", "<C-h>", [[<C-\><C-n><C-W>h]], opts)
  vim.api.nvim_buf_set_keymap(0, "t", "<C-j>", [[<C-\><C-n><C-W>j]], opts)
  vim.api.nvim_buf_set_keymap(0, "t", "<C-k>", [[<C-\><C-n><C-W>k]], opts)
  vim.api.nvim_buf_set_keymap(0, "t", "<C-l>", [[<C-\><C-n><C-W>l]], opts)
end

-- Mapeo personalizado cuando se usa toggleterm
vim.cmd("autocmd! TermOpen term://* lua set_terminal_keymaps()")

-- Funciones para abrir terminales personalizados
local Terminal = require("toggleterm.terminal").Terminal

-- Terminal personalizado : R
local r = Terminal:new({
    cmd = "R",
    dir = vim.fn.getcwd(),
    hidden = true,
    count = 1,
})

function _R_TOGGLE()
	r:toggle()
end

-- Terminal personalizado : Python
local python = Terminal:new({
    cmd = "python3",
    hidden = true,
    count = 2,
})

function _PYTHON_TOGGLE()
	python:toggle()
end

-- Terminal personalizado : lazygit
local lazygit = Terminal:new({ cmd = "lazygit", hidden = true })
function _LAZYGIT_TOGGLE()
	lazygit:toggle()
end
