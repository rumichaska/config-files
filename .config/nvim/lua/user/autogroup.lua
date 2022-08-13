-- Autogroups personalizados

-- R language

-- Función para el autogroup personalizado de R
local pandoc_setup = vim.api.nvim_create_augroup("pandoc_setup", {
    clear = true
})

-- Keymaps personalizados de R
vim.api.nvim_create_autocmd("FileType", {
    pattern = { "rmd" },
    command = "set completefunc=pandoc#completion#Complete",
    group = pandoc_setup
})

-- vim.cmd [[
--     augroup r_setup
--         autocmd!
--         autocmd FileType rmd set completefunc=pandoc#completion#Complete
--     augroup END
-- ]]

