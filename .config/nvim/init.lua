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
    install = { colorscheme = { "tokyonight", "catppuccin", "habamax" } },
    ui = {
        size = { width = 0.8, height = 0.9 },
        border = "rounded",
        icons = {
            cmd = " ",
            config = " ",
            event = "",
            ft = " ",
            init = " ",
            import = " ",
            keys = " ",
            lazy = "󰒲 ",
            loaded = "●",
            not_loaded = "○",
            plugin = " ",
            runtime = " ",
            require = "󰢱 ",
            source = " ",
            start = "󰼛",
            task = "✔ ",
            list = {
                "●",
                "➜",
                "★",
                "‒",
            },
        },
    },
    checker = { enabled = true },
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
