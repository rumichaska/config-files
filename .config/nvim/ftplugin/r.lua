-- R LANGUAGE

-- VARIABLES LOCALES

local opts = { noremap = true, silent = true, buffer = 0 }
local keymap = vim.keymap.set

-- OPCIONES LOCALES

-- Código

-- Atajos para operadores de R %>% %in% <-
keymap("i", "<M-M>", "<Esc>:normal! a %>%<CR>a ", opts)
keymap("i", "<M-I>", "<Esc>:normal! a %in%<CR>a ", opts)
keymap("i", "<M-->", "<Esc>:normal! a <-<CR>a ", opts)

-- Enviar .R a consola, similar a Ctrl+Shift+S
-- keymap("n", "<Leader>L", ":10TermExec cmd='source(\"%:p:.\")'<CR>")
keymap("n", "<Leader>L", ":call luaeval(\"require('iron').core.send(_A[1], _A[2])\", [&ft, \"source('\".expand('%').\"')\"])<CR>")

-- Enviar .Rmd a consola, similar a Ctrl+Shift+K
-- keymap("n", "<Leader>K", ":10TermExec cmd='rmarkdown::render(\"%:p:.\")'<CR>")
keymap("n", "<Leader>K", ":call luaeval(\"require('iron').core.send(_A[1], _A[2])\", [&ft, \"rmarkdown::render('\".expand('%').\"')\"])<CR>")

-- Comentario de sección tipo RStudio Ctrl+Shift+R
keymap("n", "gch", "73i-<Esc>0:normal gcc<CR>2l<S-R>", opts)

-- Terminal --

-- Lanzar consola de R
keymap("n", "<Leader>tr", ":IronRepl<CR>", opts)

-- Mapeos para radian
vim.api.nvim_create_autocmd({ "TermOpen" }, {
    pattern = "term://*",
    callback = function()
        keymap("n", "<Leader>tr", ":IronHide r<CR>", opts)
        keymap("t", "<M-M>", " %>% ", opts)
        keymap("t", "<M-I>", " %in% ", opts)
        keymap("t", "<M-->", " <- ", opts)
    end,
    group = vim.api.nvim_create_augroup("term_radian", { clear = true })
})
