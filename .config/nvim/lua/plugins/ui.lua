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
            vim.ui.select = function(...)
                require("lazy").load({ plugins = { "dressing.nvim" } })
                return vim.ui.select(...)
            end
            vim.ui.input = function(...)
                require("lazy").load({ plugins = { "dressing.nvim" } })
                return vim.ui.input(...)
            end
        end,
    },

    -- Buffer
    {
        "akinsho/bufferline.nvim",
        version = "*",
        event = "VeryLazy",
        keys = {
            { "<Leader>bp", "<cmd>BufferLineTogglePin<CR>", desc = "Toggle Pin" },
            { "<Leader>bP", "<cmd>BufferLineGroupCloe ungrouped<CR>", desc = "Delete Non-pinned Buffers" },
        },
        opts = {
            options = {
                diagnostics = "nvim_lsp",
                offsets = {
                    {
                        filetype = "neo-tree",
                        text = "File Explorer",
                        text_align = "center",
                        -- highlight = "Directory",
                    },
                },
                always_show_bufferline = true,
            },
            highlights = require("catppuccin.groups.integrations.bufferline").get({
                styles = { "italic", "bold" },
                custom = {
                    all = {
                        fill = { fg = "#000000" },
                    },
                    mocha = {
                        background = { fg = require("catppuccin.palettes").get_palette("mocha").text },
                    },
                    latte = {
                        background = { fg = "#000000" },
                    },
                },
            }),
        },
    },

    -- Statusline
    {
        "nvim-lualine/lualine.nvim",
        event = "VeryLazy",
        opts = function()
            local Util = require("util")
            local icons = require("config").icons

            -- Add custom extensions for iron.nvim if installed
            local function extension(tbl)
                local ext = {}
                if Util.has("iron.nvim") then
                    ext = {
                        {
                            sections = {
                                lualine_a = {
                                    function()
                                        return "IronREPL #"
                                    end,
                                },
                            },
                            -- requires set local filetype to 'ironterm' when open term
                            -- check ftplugin/r.lua for example
                            filetypes = { "ironterm" },
                        },
                    }
                end
                for _, v in pairs(tbl) do
                    table.insert(ext, v)
                end
                return ext
            end

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
                        { "filetype", icon_only = true, separator = "", padding = { left = 1, right = 0 } },
                        { "filename", path = 1, symbols = { modified = "  ", readonly = "", unnamed = "" } },
                        -- stylua: ignore
                        {
                            function() return require("nvim-navic").get_location() end,
                            cond = function() return package.loaded["nvim-navic"] and require("nvim-navic").is_available() end,
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
                        {
                            function() return  "  " .. require("dap").status() end,
                            cond = function() return package.loaded["dap"] and require("dap").status ~= "" end,
                            color = Util.fg("Debug")
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
                        { "progress", separator = " ", padding = { left = 1, right = 0 } },
                        { "location", padding = { left = 0, right = 1 } },
                    },
                    lualine_z = {
                        function()
                            return " " .. os.date("%R")
                        end,
                    },
                },
                extensions = extension({
                    "lazy",
                    "neo-tree",
                }),
            }
        end,
    },

    -- Indent guides
    {
        "lukas-reineke/indent-blankline.nvim",
        event = { "BufReadPost", "BufNewFile" },
        opts = {
            char = "│",
            filetype_exclude = {
                "help",
                "alpha",
                "dashboard",
                "neo-tree",
                "Trouble",
                "lazy",
                "mason",
                "notify",
                "toggleterm",
                "lazyterm",
            },
            show_current_context = true,
            use_treesitter = true,
            use_treesitter_scope = true,
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
            },
            routes = {
                {
                    filter = {
                        event = "msg_show",
                        any = {
                            { find = "%d+L, %d+B" },
                            { find = "; after #%d+" },
                            { find = "; before #%d+" },
                        },
                    },
                    view = "mini",
                },
            },
            presets = {
                bottom_search = true,
                command_palette = true,
                long_message_to_split = true,
                inc_rename = true,
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

    -- LSP symbol navigation
    {
        "SmiteshP/nvim-navic",
        init = function()
            vim.g.navic_silence = true
            require("util").on_attach(function(client, buffer)
                if client.server_capabilities.documentSymbolProvider then
                    require("nvim-navic").attach(client, buffer)
                end
            end)
        end,
        opts = function()
            return {
                separator = " ",
                highlight = true,
                depth_limit = 5,
                icons = require("config").icons.kinds,
            }
        end,
    },

    -- Color highlighter
    {
        "norcalli/nvim-colorizer.lua",
        event = { "BufReadPost", "BufNewFile" },
        opts = {
            css = { css = true },
            html = { css = true },
            r = { names = false, rgb_fn = true },
        },
    },

    -- Icons
    { "nvim-tree/nvim-web-devicons" },

    -- UI components
    { "MunifTanjim/nui.nvim" },
}
