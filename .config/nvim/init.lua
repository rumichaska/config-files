-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
    vim.fn.system({
        "git",
        "clone",
        "--filter=blob:none",
        "https://github.com/folke/lazy.nvim.git",
        "--branch=stable", -- latest stable release
        lazypath,
    })
end
vim.opt.rtp:prepend(lazypath)

-- Add lazy.nvim and options
-- NOTE: plugins.core load config.options with init function
require("lazy").setup("plugins", {
    defaults = { lazy = true, version = false },
    install = { colorscheme = { "tokyonight", "habamax" } },
    checker = { enabled = true },
    performance = {
        rtp = {
            disabled_plugins = {
                "gzip",
                "matchit",
                "matchparen",
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
-- NOTE: this function loads config.autocmds and config.keymaps, its important
-- that this setup load after lazy (config.options)
require("config").setup()
