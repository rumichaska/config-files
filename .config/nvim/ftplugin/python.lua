-- PYTHON

-- VARIABLES LOCALES

local opts = { noremap = true, silent = true, buffer = 0 }
local keymap = vim.keymap.set

-- OPCIONES LOCALES

-- KEYMAPS

-- Lanzar consola de PYTHON
keymap("n", "<Leader>tp", ":lua _PYTHON_TOGGLE()<CR>", opts)

-- Enviar código a consola de python3
keymap("n", "<Leader>l", ":ToggleTermSendCurrentLine 20<CR>j0")
keymap("v", "<Leader>l", ":ToggleTermSendVisualLines 20<CR>")
keymap("v", "<Leader>l", ":ToggleTermSendVisualSelection 20<CR>")

-- Ejecutar código en terminal
keymap("n", "<Leader>L", ":1TermExec cmd='python3 %:p:.'<CR>")

-- Comentario de sección
keymap("n", "gch", "73i-<Esc>0:normal gcc<CR>2l<S-R>", opts)
