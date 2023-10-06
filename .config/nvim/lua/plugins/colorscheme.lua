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
            term_colors = true,
            custom_highlights = function(colors)
                return {
                    CursorLineNr = { bold = true },
                    FloatBorder = { bg = colors.mantle },
                    TelescopeNormal = { link = "NormalFloat" },
                    NoiceSplit = { link = "Normal" },
                    TroubleNormal = { link = "Normal" },
                }
            end,
            integrations = {
                cmp = true,
                gitsigns = true,
                illuminate = true,
                indent_blankline = { enabled = true },
                lsp_trouble = true,
                mason = true,
                mini = true,
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
                    custom_bg = "lualine",
                },
                neotree = true,
                noice = true,
                notify = true,
                nvimtree = false,
                semantic_tokens = true,
                telescope = true,
                treesitter = true,
                which_key = true,
            },
        },
        config = function(_, opts)
            require("catppuccin").setup(opts)
            vim.cmd.colorscheme("catppuccin")
        end,
    },
}
