return {

    -- Measure startuptime
    {
        "dstein64/vim-startuptime",
        cmd = "StartupTime",
        config = function()
            vim.g.startuptime_tries = 10
        end,
    },

    -- Global library
    { "nvim-lua/plenary.nvim", lazy = true },
}
