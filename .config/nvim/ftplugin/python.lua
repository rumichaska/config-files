-- PYTHON

-- VARIABLES LOCALES

local opts = { noremap = true, silent = true, buffer = 0 }
local keymap = vim.keymap.set

-- OPCIONES LOCALES

-- Código

-- Ejecutar código en terminal
-- keymap("n", "<Leader>L", ":1TermExec cmd='python3 %:p:.'<CR>")

-- Comentario de sección
keymap("n", "gch", "73i-<Esc>0:normal gcc<CR>2l<S-R>", opts)

-- Terminal --

-- Lanzar consola de PYTHON
keymap("n", "<Leader>tr", ":IronRepl<CR>", opts)

-- Mapeos para ipython
vim.api.nvim_create_autocmd({ "TermOpen" }, {
    pattern = "term://*",
    callback = function()
        keymap("n", "<Leader>tr", ":IronHide python<CR>", opts)
    end,
    group = vim.api.nvim_create_augroup("term_ipython", { clear = true })
})
