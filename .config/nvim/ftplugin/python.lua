-- PYTHON

-- VARIABLES LOCALES

local opts = { noremap = true, silent = true, buffer = 0 }
local keymap = vim.keymap.set

-- OPCIONES LOCALES

-- KEYMAPS

-- Lanzar consola de PYTHON
keymap("n", "<Leader>tp", ":lua _PYTHON_TOGGLE()<CR>", opts)

-- Ejecutar código en terminal
keymap("n", "<Leader>L", ":1TermExec cmd='python3 %:p:.'<CR>")
