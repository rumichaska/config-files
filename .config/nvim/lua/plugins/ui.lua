return {

    -- Better `vim.notify()`
    {
        "rcarriga/nvim-notify",
        keys = {
            {
                "<Leader>un",
                function()
                    require("notify").dismiss({ silent = true, pending = true })
                end,
                desc = "Dismiss All Notifications",
            },
        },
        opts = {
            timeout = 3000,
            max_height = function()
                return math.floor(vim.o.lines * 0.75)
            end,
            max_width = function()
                return math.floor(vim.o.columns * 0.75)
            end,
        },
        init = function()
            -- when noice is not enabled, install notify on VeryLazy
            local Util = require("util")
            if not Util.has("noice.nvim") then
                Util.on_very_lazy(function()
                    vim.notify = require("notify")
                end)
            end
        end,
    },

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
                        -- stylua: ignore
                        {
                            function() return require("noice").api.status.command.get() end,
                            cond = function() return package.loaded["noice"] and require("noice").api.status.command.has() end,
                            color = Util.fg("Statement")
                        },
                        -- stylua: ignore
                        {
                            function() return require("noice").api.status.mode.get() end,
                            cond = function() return package.loaded["noice"] and require("noice").api.status.mode.has() end,
                            color = Util.fg("Constant")
                        },
                        -- stylua: ignore
                        -- {
                        --     function() return  "  " .. require("dap").status() end,
                        --     cond = function() return package.loaded["dap"] and require("dap").status ~= "" end,
                        --     color = Util.fg("Debug")
                        -- },
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
                    "notify",
                    "lazyterm",
                    "ironterm",
                },
            },
        },
    },

    -- Noice UI
    {
        "folke/which-key.nvim",
        opts = function(_, opts)
            if require("util").has("noice.nvim") then
                opts.defaults["<Leader>sn"] = { name = "+noice" }
            end
        end,
    },
    {
        "folke/noice.nvim",
        event = "VeryLazy",
        opts = {
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
                bottom_search = true,
                command_palette = true,
                long_message_to_split = true,
                inc_rename = false,
                lsp_doc_border = true, -- rounded border for hover (K)
            },
        },
        -- stylua: ignore
        keys = {
            { "<S-Enter>", function() require("noice").redirect(vim.fn.getcmdline()) end, mode = "c", desc = "Redirect Cmdline" },
            { "<Leader>snl", function() require("noice").cmd("last") end, desc = "Noice Last Message" },
            { "<Leader>snh", function() require("noice").cmd("history") end, desc = "Noice History" },
            { "<Leader>sna", function() require("noice").cmd("all") end, desc = "Noice All" },
            { "<Leader>snd", function() require("noice").cmd("dismiss") end, desc = "Dismiss All" },
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
        ft = { "python", "lua" },
    },

    -- Icons
    { "nvim-tree/nvim-web-devicons" },

    -- UI components
    { "MunifTanjim/nui.nvim" },
}
