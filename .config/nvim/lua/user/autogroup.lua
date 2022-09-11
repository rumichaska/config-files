-- Autogroups personalizados

-- Globales

-- Markdown wrap
vim.api.nvim_create_autocmd({ "FileType" }, {
    pattern = { "markdown" },
    callback = function()
        vim.opt_local.wrap = true
    end,
})

-- R language

-- Función para el autogroup personalizado de R
local pandoc_setup = vim.api.nvim_create_augroup("pandoc_setup", {
    clear = true
})

-- Keymaps personalizados de R
vim.api.nvim_create_autocmd({ "FileType" }, {
    pattern = { "rmd", "qmd" },
    command = "set completefunc=pandoc#completion#Complete",
    group = pandoc_setup
})
