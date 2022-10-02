-- Autocommands personalizados

-- Globales

-- Cerrar ventanas de apoyo (help, lsp, etc.)
vim.api.nvim_create_autocmd({ "Filetype" }, {
    pattern = {
        "qf",
        "help",
        "man",
        "lspinfo",
    },
    callback = function()
        local opts = { noremap = true, silent = true, buffer = 0 }
        local keymap = vim.keymap.set
        keymap("n", "q", ":clo<CR>", opts)
    end,
    group = vim.api.nvim_create_augroup("CloseInfoBuffer", { clear = true })
})
