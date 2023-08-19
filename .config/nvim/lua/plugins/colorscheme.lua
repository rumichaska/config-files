return {
    -- Tokyonight
    {
        "folke/tokyonight.nvim",
        enabled = false,
        lazy = false,
        priority = 1000,
        opts = {
            style = "night",
            styles = {
                comments = { italic = true },
                keywords = { italic = false, bold = true },
                functions = { italic = true, bold = true },
                variables = {},
            },
            sidebars = { "terminal", "help" },
            lualine_bold = true,
            on_highlights = function(hl, c)
                hl.CursorLineNr = {
                    fg = c.yellow,
                    bold = true,
                }
            end,
        },
        config = function(_, opts)
            require("tokyonight").setup(opts)
            vim.cmd.colorscheme("tokyonight")
        end,
    },

    -- Catppuccin
    {
        "catppuccin/nvim",
        lazy = false,
        priority = 1000,
        opts = {
            flavour = "mocha",
            custom_highlights = function(colors)
                return {
                    CursorLineNr = { fg = colors.yellow, bold = true },
                }
            end,
        },
        config = function(_, opts)
            require("catppuccin").setup(opts)
            vim.cmd.colorscheme("catppuccin")
        end,
    },
}
