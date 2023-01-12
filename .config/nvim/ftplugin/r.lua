-- R LANGUAGE

-- VARIABLES LOCALES

local opts = { noremap = true, silent = true, buffer = 0 }
local keymap = vim.keymap.set
local r = {
    rmd_render = "\"rmarkdown::render('" .. vim.fn.expand("%") .. "')\"",
    source = "source(\"" .. vim.fn.expand("%") .. "\")",
}

-- MAPEOS LOCALES

-- Código

-- Operadores de R %>% %in% <-
keymap("i", "<M-M>", "<Esc>:normal! a %>%<CR>a ", opts)
keymap("i", "<M-I>", "<Esc>:normal! a %in%<CR>a ", opts)
keymap("i", "<M-->", "<Esc>:normal! a <-<CR>a ", opts)

-- Ejecutar código en consola, similar a Ctrl+Shift+S de RStudio
keymap("n", "<Leader>L", ":IronSend " .. r.source .. "<CR>", opts)

-- Renderizar rmarkdown, similar a Ctrl+Shift+K de RStudio
keymap("n", "<Leader>K", ":!R -e " .. r.rmd_render .. "<CR>", opts)

-- Insertar sección, similar Ctrl+Shift+R de RStudio
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
