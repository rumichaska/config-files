return {

    -- Better vim.ui
    {
        "stevearc/dressing.nvim",
        init = function()
            ---@diagnostic disable-next-line: duplicate-set-field
            vim.ui.select = function(...)
                require("lazy").load({ plugins = { "dressing.nvim" } })
                return vim.ui.select(...)
            end
            ---@diagnostic disable-next-line: duplicate-set-field
            vim.ui.input = function(...)
                require("lazy").load({ plugins = { "dressing.nvim" } })
                return vim.ui.input(...)
            end
        end,
    },

    -- Buffer
    {
        "b0o/incline.nvim",
        event = "VeryLazy",
        opts = function()
            local devicons = require("nvim-web-devicons")
            local palette = require("catppuccin.palettes").get_palette("mocha")

            return {
                window = {
                    padding = 0,
                    margin = { horizontal = 0 },
                },
                hide = {
                    cursorline = true,
                },
                render = function(props)
                    local filename = vim.fn.fnamemodify(vim.api.nvim_buf_get_name(props.buf), ":t")
                    if filename == "" then
                        filename = "[No Name]"
                    end
                    local ft_icon, ft_color = devicons.get_icon_color(filename)

                    local function get_file_name()
                        local label = {}
                        table.insert(
                            label,
                            { " " .. (vim.bo[props.buf].modified and " " or ""), guifg = palette.maroon }
                        )
                        table.insert(label, { (ft_icon or "") .. " ", guifg = ft_color })
                        table.insert(
                            label,
                            { filename .. " ", gui = vim.bo[props.buf].modified and "bold,italic" or "bold" }
                        )
                        if not props.focused then
                            label["group"] = "BufferInactive"
                        end

                        return label
                    end

                    return { get_file_name() }
                end,
            }
        end,
    },

    -- Statusline
    {
        "nvim-lualine/lualine.nvim",
        event = "VeryLazy",
        opts = function()
            local Util = require("util")
            local icons = require("config").icons

            return {
                options = {
                    theme = "catppuccin",
                    disabled_filetypes = { statusline = { "dashboard", "alpha" } },
                    globalstatus = true,
                    section_separators = "",
                    component_separators = "|",
                },
                sections = {
                    lualine_a = { "mode" },
                    lualine_b = {
                        {
                            "branch",
                            icon = "",
                        },
                    },
                    lualine_c = {
                        {
                            "diagnostics",
                            symbols = {
                                error = icons.diagnostics.Error,
                                warn = icons.diagnostics.Warn,
                                info = icons.diagnostics.Info,
                                hint = icons.diagnostics.Hint,
                            },
                        },
                        {
                            function()
                                return require("util").get_root()
                            end,
                        },
                    },
                    lualine_x = {
                        {
                            -- stylua: ignore
                            function() return require("noice").api.status.command.get() end,
                            cond = function() return package.loaded["noice"] and require("noice").api.status.command.has() end,
                            color = Util.fg("Statement")
                        },
                        {
                            -- stylua: ignore
                            function() return require("noice").api.status.mode.get() end,
                            cond = function() return package.loaded["noice"] and require("noice").api.status.mode.has() end,
                            color = Util.fg("Constant")
                        },
                        {
                            require("lazy.status").updates,
                            cond = require("lazy.status").has_updates,
                            color = Util.fg("Special"),
                        },
                        {
                            "diff",
                            symbols = {
                                added = icons.git.added,
                                modified = icons.git.modified,
                                removed = icons.git.removed,
                            },
                        },
                    },
                    lualine_y = {
                        { "fileformat" },
                        { "encoding" },
                    },
                    lualine_z = {
                        { "progress", padding = { left = 1, right = 0 } },
                        { "location", padding = { left = 0, right = 1 } },
                    },
                },
                extensions = {
                    "lazy",
                    "mason",
                    "neo-tree",
                    "quickfix",
                    "trouble",
                    -- NOTE: iron.nvim
                    -- requires set local filetype to 'ironterm' when open term
                    -- check ftplugin/r.lua for example
                    {
                        sections = {
                            lualine_a = {
                                function()
                                    return "IronREPL #"
                                end,
                            },
                        },
                        filetypes = { "ironterm" },
                    },
                },
            }
        end,
    },

    -- Indent guides
    {
        "lukas-reineke/indent-blankline.nvim",
        main = "ibl",
        event = { "BufReadPost", "BufNewFile" },
        opts = {
            indent = {
                char = "│",
                tab_char = "│",
            },
            scope = { enabled = false },
            exclude = {
                filetypes = {
                    "neo-tree",
                    "Trouble",
                    "lazy",
                    "mason",
                    "lazyterm",
                    "ironterm",
                },
            },
        },
    },

    -- Noice UI
    {
        "folke/noice.nvim",
        event = "VeryLazy",
        opts = {
            cmdline = { view = "cmdline" },
            lsp = {
                override = {
                    ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
                    ["vim.lsp.util.stylize_markdown"] = true,
                    ["cmp.entry.get_documentation"] = true,
                },
                signature = {
                    enabled = true,
                    auto_open = {
                        enabled = false,
                    },
                },
            },
            presets = {
                lsp_doc_border = true, -- rounded border for hover (K)
            },
        },
        -- stylua: ignore
        keys = {
            { "<C-f>", function() if not require("noice.lsp").scroll(4) then return "<C-f>" end end, silent = true, expr = true, desc = "Scroll Forward", mode = {"i", "n", "s"} },
            { "<C-b>", function() if not require("noice.lsp").scroll(-4) then return "<C-b>" end end, silent = true, expr = true, desc = "Scroll Backward", mode = {"i", "n", "s"}},
        },
    },

    -- Color highlighter
    {
        "norcalli/nvim-colorizer.lua",
        event = { "BufReadPost", "BufNewFile" },
        opts = {
            css = { css = true },
            scss = { css = true },
            html = { css = true },
            r = { names = false, rgb_fn = true, hsl_fn = true },
            rmd = { names = false, rgb_fn = true, hsl_fn = true },
            qmd = { names = false, rgb_fn = true, hsl_fn = true },
        },
    },

    -- Sticky scroll
    {
        "nvim-treesitter/nvim-treesitter-context",
        event = { "BufReadPost", "BufNewFile" },
    },

    -- Icons
    { "nvim-tree/nvim-web-devicons" },

    -- UI components
    { "MunifTanjim/nui.nvim" },
}
