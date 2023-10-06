return {

    -- Snippets
    {
        "L3MON4D3/LuaSnip",
        version = "2.*",
        build = (not jit.os:find("Windows"))
                and "echo 'NOTE: jsregexp is optional, so not a big deal if it fails to build'; make install_jsregexp"
            or nil,
        dependencies = {
            "rafamadriz/friendly-snippets",
            config = function()
                require("luasnip.loaders.from_vscode").lazy_load()
            end,
        },
        -- stylua: ignore
        keys = {
            {
                "<Tab>",
                function()
                    return require("luasnip").jumpable(1) and "<Plug>luasnip-jump-next" or "<Tab>"
                end,
                expr = true, silent = true, mode = "i",
            },
            {
                "<Tab>", function() require("luasnip").jump(1) end, mode = "s",
            },
            {
                "<S-Tab>", function() require("luasnip").jump(-1) end, mode = { "i", "s" },
            },
        },
        opts = {
            history = true,
            delete_check_events = "TextChanged",
            update_events = { "TextChanged", "TextChangedI" },
        },
        config = function(_, opts)
            local ls = require("luasnip")

            -- Filetype snippets
            local s = ls.snippet
            local t = ls.text_node
            local i = ls.insert_node
            local fmt = require("luasnip.extras.fmt").fmt

            -- R
            ls.add_snippets("r", {
                s("head1", fmt("# {} ----", { i(1, "SECTION 1") })),
                s("head2", fmt("## {} ----", { i(1, "SECTION 2") })),
                s("head3", fmt("### {} ----", { i(1, "SECTION 3") })),
                s("#!", t("#! /usr/bin/env Rscript")),
            })

            -- Rmd
            ls.add_snippets("rmd", {
                s("head1", fmt("# {} ----", { i(1, "SECTION 1") })),
                s("head2", fmt("## {} ----", { i(1, "SECTION 2") })),
                s("head3", fmt("### {} ----", { i(1, "SECTION 3") })),
            })

            ls.setup(opts)
        end,
    },

    -- Auto completion
    {
        "hrsh7th/nvim-cmp",
        event = "InsertEnter",
        dependencies = {
            "hrsh7th/cmp-nvim-lsp",
            "hrsh7th/cmp-buffer",
            "hrsh7th/cmp-path",
            "hrsh7th/cmp-cmdline",
            "hrsh7th/cmp-nvim-lua",
            "saadparwaiz1/cmp_luasnip",
        },
        opts = function()
            vim.api.nvim_set_hl(0, "CmpGhostText", { link = "Comment", default = true })
            local cmp = require("cmp")
            local defaults = require("cmp.config.default")()
            return {
                snippet = {
                    expand = function(args)
                        require("luasnip").lsp_expand(args.body)
                    end,
                },
                window = {
                    completion = cmp.config.window.bordered({
                        winhighlight = "Normal:NormalFloat,FloatBorder:FloatBorder,CursorLine:Visual,Search:None",
                        -- scrollbar = false,
                    }),
                    documentation = cmp.config.window.bordered({
                        winhighlight = "Normal:NormalFloat,FloatBorder:FloatBorder,CursorLine:Visual,Search:None",
                        -- scrollbar = false,
                    }),
                },
                completion = {
                    completeopt = "menu,menuone,noinsert",
                },
                mapping = cmp.mapping.preset.insert({
                    ["<C-n>"] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Insert }),
                    ["<C-p>"] = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Insert }),
                    ["<C-b>"] = cmp.mapping.scroll_docs(-4),
                    ["<C-f>"] = cmp.mapping.scroll_docs(4),
                    ["<C-Space>"] = cmp.mapping.complete(),
                    ["<C-e>"] = cmp.mapping.abort(),
                    ["<CR>"] = cmp.mapping.confirm({ select = true }), -- Accept current selection
                }),
                sources = cmp.config.sources({
                    { name = "nvim_lsp" },
                    { name = "luasnip" },
                    { name = "buffer" },
                    {
                        name = "path",
                        option = {
                            -- get path to current working directory (cwd),
                            -- defaults to current buffer directory
                            get_cwd = function()
                                return vim.fn.getcwd()
                            end,
                        },
                    },
                    { name = "nvim_lua" },
                }),
                formatting = {
                    format = function(entry, vim_item)
                        -- NOTE: Load plugin if installed, else use `config.icons.kinds`
                        local lspkind_ok, lspkind = pcall(require, "lspkind")
                        local icons = require("config").icons.kinds
                        if not lspkind_ok then
                            vim_item.kind = string.format("%s %s", icons[vim_item.kind], vim_item.kind)
                            vim_item.menu = ({
                                nvim_lsp = "[LSP]",
                                luasnip = "[LuaSnip]",
                                buffer = "[Buffer]",
                                path = "[Path]",
                                nvim_lua = "[Lua]",
                            })[entry.source.name]
                            return vim_item
                        else
                            lspkind.cmp_format()(entry, vim_item)
                        end
                    end,
                },
                experimental = {
                    ghost_text = {
                        hl_group = "CmpGhostText",
                    },
                },
                sorting = defaults.sorting,
            }
        end,
    },

    -- Auto pairs
    {
        "windwp/nvim-autopairs",
        event = "InsertEnter",
        opts = {
            check_ts = true,
            fast_wrap = {},
        },
        config = function(_, opts)
            -- Integration with nvim-cmp
            local cmp_autopairs = require("nvim-autopairs.completion.cmp")
            local cmp = require("cmp")
            cmp.event:on("confirm_donde", cmp_autopairs.on_confirm_done())

            require("nvim-autopairs").setup(opts)
        end,
    },

    -- Surround
    {
        "echasnovski/mini.surround",
        keys = function(_, keys)
            -- Populate the keys based on the user's options
            local plugin = require("lazy.core.config").spec.plugins["mini.surround"]
            local opts = require("lazy.core.plugin").values(plugin, "opts", false)
            local mappings = {
                { opts.mappings.add, desc = "Add Surrounding", mode = { "n", "v" } },
                { opts.mappings.delete, desc = "Delete Surrounding" },
                { opts.mappings.find, desc = "Find Right Surrounding" },
                { opts.mappings.find_left, desc = "Find Left Surrounding" },
                { opts.mappings.highlight, desc = "Highlight Surrounding" },
                { opts.mappings.replace, desc = "Replace Surrounding" },
                { opts.mappings.update_n_lines, desc = "Update `MiniSurround.config.n_lines`" },
            }
            mappings = vim.tbl_filter(function(m)
                return m[1] and #m[1] > 0
            end, mappings)
            return vim.list_extend(mappings, keys)
        end,
        opts = {
            mappings = {
                add = "gza", -- Add surrounding in Normal and Visual modes
                delete = "gzd", -- Delete surrounding
                find = "gzf", -- Find surrounding (to the right)
                find_left = "gzF", -- Find surrounding (to the left)
                highlight = "gzh", -- Highlight surrounding
                replace = "gzr", -- Replace surrounding
                update_n_lines = "gzn", -- Update `n_lines`
            },
        },
    },

    -- Comments
    {
        "JoosepAlviste/nvim-ts-context-commentstring",
        opts = {
            enable_autocmd = false,
        },
    },
    {
        "echasnovski/mini.comment",
        event = "VeryLazy",
        opts = {
            options = {
                custom_commentstring = function()
                    return require("ts_context_commentstring.internal").calculate_commentstring()
                        or vim.bo.commentstring
                end,
            },
        },
    },

    -- Better text-objects
    {
        "echasnovski/mini.ai",
        -- keys = {
        --   { "a", mode = { "x", "o" } },
        --   { "i", mode = { "x", "o" } },
        -- },
        event = "VeryLazy",
        dependencies = { "nvim-treesitter-textobjects" },
        opts = function()
            local ai = require("mini.ai")
            return {
                n_lines = 500,
                custom_textobjects = {
                    f = ai.gen_spec.treesitter({ a = "@function.outer", i = "@function.inner" }, {}),
                    c = ai.gen_spec.treesitter({ a = "@class.outer", i = "@class.inner" }, {}),
                    i = ai.gen_spec.treesitter({ a = "@conditional.outer", i = "@conditional.inner" }, {}),
                    o = ai.gen_spec.treesitter({ a = "@loop.outer", i = "@loop.inner" }, {}),
                    t = { "<([%p%w]-)%f[^<%w][^<>]->.-</%1>", "^<.->().*()</[^/]->$" },
                },
            }
        end,
        config = function(_, opts)
            require("mini.ai").setup(opts)
            -- register all text objects with which-key
            require("util").on_load("which-key.nvim", function()
                local i = {
                    [" "] = "Whitespace",
                    ['"'] = 'Balanced "',
                    ["'"] = "Balanced '",
                    ["`"] = "Balanced `",
                    ["("] = "Balanced (",
                    [")"] = "Balanced ) including white-space",
                    [">"] = "Balanced > including white-space",
                    ["<lt>"] = "Balanced <",
                    ["]"] = "Balanced ] including white-space",
                    ["["] = "Balanced [",
                    ["}"] = "Balanced } including white-space",
                    ["{"] = "Balanced {",
                    ["?"] = "User Prompt",
                    _ = "Underscore",
                    a = "Argument",
                    b = "Balanced ), ], }",
                    c = "Class",
                    f = "Function",
                    i  = "Conditional",
                    o = "Loop",
                    q = "Quote `, \", '",
                    t = "Tag",
                }
                local a = vim.deepcopy(i)
                for k, v in pairs(a) do
                    a[k] = v:gsub(" including.*", "")
                end

                local ic = vim.deepcopy(i)
                local ac = vim.deepcopy(a)
                for key, name in pairs({ n = "Next", l = "Last" }) do
                    i[key] = vim.tbl_extend("force", { name = "Inside " .. name .. " textobject" }, ic)
                    a[key] = vim.tbl_extend("force", { name = "Around " .. name .. " textobject" }, ac)
                end
                require("which-key").register({
                    mode = { "o", "x" },
                    i = i,
                    a = a,
                })
            end)
        end,
    },

    -- REPL
    {
        "Vigemus/iron.nvim",
        cmd = "IronRepl",
        opts = function()
            -- Remove extra <CR> when sending lines to R console
            local function bracketed_paste_radian(lines)
                local open_code = "\27[200~"
                local close_code = "\27[201~"
                local cr = "\13"
                if #lines == 1 then
                    return { lines[1] .. cr }
                else
                    local new = { open_code .. lines[1] }
                    for line = 2, #lines do
                        table.insert(new, lines[line])
                    end

                    table.insert(new, close_code)
                    return new
                end
            end

            local view = require("iron.view")

            return {
                config = {
                    highlight_last = false,
                    scratch_repl = true,
                    close_window_on_exit = true,
                    repl_definition = {
                        r = {
                            command = { "radian" },
                            format = bracketed_paste_radian,
                        },
                        rmd = {
                            command = { "radian" },
                            format = bracketed_paste_radian,
                        },
                        python = require("iron.fts.python").ipython,
                    },
                    repl_open_cmd = view.split("30%", {
                        number = false,
                        relativenumber = false,
                    }),
                },
                keymaps = {
                    visual_send = "<C-CR>",
                    send_line = "<C-CR>",
                    send_until_cursor = "<A-b>",
                },
                ignore_blank_lines = true,
            }
        end,
        config = function(_, opts)
            require("iron.core").setup(opts)
        end,
    },
}
