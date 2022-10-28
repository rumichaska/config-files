-- R LANGUAGE

-- VARIABLES LOCALES

local opts = { noremap = true, silent = true, buffer = 0 }
local keymap = vim.keymap.set

-- OPCIONES LOCALES

-- KEYMAPS

-- Lanzar consola de R
keymap("n", "<Leader>tr", ":lua _R_TOGGLE()<CR>", opts)

-- Atajos para operadores de R %>% %in% <-
keymap("i", "<M-M>", "<Esc>:normal! a %>%<CR>a ", opts)
keymap("i", "<M-I>", "<Esc>:normal! a %in%<CR>a ", opts)
keymap("i", "<M-->", "<Esc>:normal! a <-<CR>a ", opts)

-- Enviar código a consola, similar a Ctrl+Enter
keymap("n", "<Leader>l", ":ToggleTermSendCurrentLine 10<CR>+")
keymap("v", "<Leader>l", ":ToggleTermSendVisualLines 10<CR>")
keymap("v", "<Leader>l", ":ToggleTermSendVisualSelection 10<CR>")

-- Enviar .R a consola, similar a Ctrl+Shift+S
keymap("n", "<Leader>L", ":10TermExec cmd='source(\"%:p:.\")'<CR>")

-- Enviar .Rmd a consola, similar a Ctrl+Shift+K
keymap("n", "<Leader>K", ":10TermExec cmd='rmarkdown::render(\"%:p:.\")'<CR>")

-- Comentario de sección tipo RStudio Ctrl+Shift+R
keymap("n", "gch", "73i-<Esc>0:normal gcc<CR>2l<S-R>", opts)
