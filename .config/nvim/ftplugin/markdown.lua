-- MARKDOWN

-- VARIABLES LOCALES

local opts = { noremap = true, silent = true, buffer = 0 }
local keymap = vim.keymap.set

-- OPCIONES LOCALES
vim.opt_local.wrap = true

-- KEYMAPS

-- Movimiento en línea de texto
keymap("n", "k", "gk", opts)
keymap("n", "j", "gj", opts)
