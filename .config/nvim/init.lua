-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
    vim.fn.system({
        "git",
        "clone",
        "--filter=blob:none",
        "https://github.com/folke/lazy.nvim.git",
        "--branch=stable",
        lazypath,
    })
end
vim.opt.rtp:prepend(lazypath)

-- Add lazy.nvim config
require("lazy").setup("plugins", {
    defaults = { lazy = true, version = false },
    install = { colorscheme = { "catppuccin" } },
    ui = {
        size = { width = 0.8, height = 0.9 },
        border = "rounded",
        icons = {
            cmd = " ",
            start = "󰼛 ",
        },
    },
    checker = { enabled = true, notify = false, frequency = 86400 },
    performance = {
        rtp = {
            disabled_plugins = {
                "gzip",
                "matchit",
                "netrwPlugin",
                "tarPlugin",
                "tohtml",
                "tutor",
                "zipPlugin",
            },
        },
    },
})

-- Load autocmds and keymaps
-- NOTE: This function loads config.autocmds and config.keymaps, its important
-- that this setup load after lazy (config.options)
require("config").setup()
