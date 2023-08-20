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
                    FloatBorder = { bg = colors.mantle },
                    TelescopeNormal = { link = "NormalFloat" },
                }
            end,
            integrations = {
                indent_blankline = {
                    enabled = true,
                    colored_indent_levels = false,
                },
                mason = true,
                mini = true,
                neotree = true,
                noice = true,
                native_lsp = {
                    enabled = true,
                    virtual_text = {
                        errors = { "italic" },
                        hints = { "italic" },
                        warnings = { "italic" },
                        information = { "italic" },
                    },
                    underlines = {
                        errors = { "undercurl" },
                        hints = { "undercurl" },
                        warnings = { "undercurl" },
                        information = { "undercurl" },
                    },
                    inlay_hints = {
                        background = true,
                    },
                },
                navic = {
                    enabled = true,
                    custom_bg = "NONE",
                },
                notify = true,
                nvimtree = false,
                lsp_trouble = true,
                which_key = true,
                illuminate = true,
            },
        },
        config = function(_, opts)
            require("catppuccin").setup(opts)
            vim.cmd.colorscheme("catppuccin")
        end,
    },
}
