local Util = require("util")

return {

    -- File explorer
    {
        "nvim-neo-tree/neo-tree.nvim",
        branch = "v3.x",
        cmd = "Neotree",
        keys = {
            {
                "<Leader>fe",
                function()
                    require("neo-tree.command").execute({ toggle = true, dir = Util.get_root() })
                end,
                desc = "Explorer Neotree (root dir)",
            },
            {
                "<Leader>fE",
                function()
                    require("neo-tree.command").execute({ toggle = true, dir = vim.loop.cwd() })
                end,
                desc = "Explorer NeoTree (cwd)",
            },
            { "<Leader>e", "<Leader>fe", desc = "Explorer NeoTree (root dir)", remap = true },
            { "<Leader>E", "<Leader>fE", desc = "Explorer NeoTree (cwd)", remap = true },
        },
        deactivate = function()
            vim.cmd([[Neotree close]])
        end,
        init = function()
            if vim.fn.argc() == 1 then
                local stat = vim.loop.fs_stat(vim.fn.argv(0))
                if stat and stat.type == "directory" then
                    require("neo-tree")
                end
            end
        end,
        opts = {
            sources = { "filesystem", "buffers", "git_status", "document_symbols" },
            open_files_do_not_replace_types = { "terminal", "Trouble", "qf", "Outline" },
            filesystem = {
                bind_to_cwd = false,
                follow_current_file = { enabled = true },
                use_libuv_file_watcher = true,
            },
            window = {
                mappings = {
                    ["<Space>"] = "none",
                },
                position = "right",
            },
            default_component_configs = {
                indent = {
                    with_expanders = true,
                    expander_collapsed = "",
                    expander_expanded = "",
                    expander_highlight = "NeoTreeExpander",
                },
            },
        },
        config = function(_, opts)
            require("neo-tree").setup(opts)
            vim.api.nvim_create_autocmd("TermClose", {
                pattern = "*lazygit",
                callback = function()
                    if package.loaded["neo-tree.sources.git_status"] then
                        require("neo-tree.sources.git_status").refresh()
                    end
                end,
            })
        end,
    },

    -- Fuzzy finder
    {
        "nvim-telescope/telescope.nvim",
        branch = "0.1.x",
        cmd = "Telescope",
        dependencies = {
            "nvim-telescope/telescope-fzf-native.nvim",
            build = "make",
            config = function()
                require("telescope").load_extension("fzf")
            end,
        },
        keys = {
            { "<Leader>,", "<cmd>Telescope buffers show_all_buffers=true<CR>", desc = "Switch Buffer" },
            { "<Leader>/", Util.telescope("live_grep"), desc = "Grep (root dir)" },
            { "<Leader>:", "<cmd>Telescope command_history<CR>", desc = "Command History" },
            { "<Leader><Space>", Util.telescope("files"), desc = "Find Files (root dir)" },
            -- Find
            { "<Leader>fb", "<cmd>Telescope buffers<CR>", desc = "Buffers" },
            { "<Leader>ff", Util.telescope("files"), desc = "Find Files (root dir)" },
            { "<Leader>fF", Util.telescope("files", { cwd = false }), desc = "Find Files (cwd)" },
            { "<Leader>fr", "<cmd>Telescope oldfiles<CR>", desc = "Recent" },
            { "<Leader>fR", Util.telescope("oldfiles", { cwd = vim.loop.cwd() }), desc = "Recent (cwd)" },
            -- Git
            { "<Leader>gc", "<cmd>Telescope git_commits<CR>", desc = "Git Commits" },
            { "<Leader>gs", "<cmd>Telescope git_status<CR>", desc = "Git Status" },
            -- Search
            -- { "<Leader>s", "<cmd>Telescope registers<CR>", desc = "Registers" },
            { "<Leader>sa", "<cmd>Telescope autocommands<CR>", desc = "Auto Commands" },
            { "<Leader>sb", "<cmd>Telescope current_buffer_fuzzy_find<CR>", desc = "Buffer" },
            { "<Leader>sc", "<cmd>Telescope command_history<CR>", desc = "Command History" },
            { "<Leader>sC", "<cmd>Telescope commands<CR>", desc = "Command" },
            { "<Leader>sd", "<cmd>Telescope diagnostics bufnr=0<CR>", desc = "Document Diagnostics" },
            { "<Leader>sD", "<cmd>Telescope diagnostics<CR>", desc = "Workspace Diagnostics" },
            { "<Leader>sg", Util.telescope("live_grep"), desc = "Grep (root dir)" },
            { "<Leader>sG", Util.telescope("live_grep", { cwd = false }), desc = "Grep (cwd)" },
            { "<leader>sh", "<cmd>Telescope help_tags<cr>", desc = "Help Pages" },
            { "<leader>sH", "<cmd>Telescope highlights<cr>", desc = "Search Highlight Groups" },
            { "<leader>sk", "<cmd>Telescope keymaps<cr>", desc = "Key Maps" },
            { "<leader>sM", "<cmd>Telescope man_pages<cr>", desc = "Man Pages" },
            { "<leader>sm", "<cmd>Telescope marks<cr>", desc = "Jump To Mark" },
            { "<leader>so", "<cmd>Telescope vim_options<cr>", desc = "Options" },
            { "<leader>sR", "<cmd>Telescope resume<cr>", desc = "Resume" },
            { "<Leader>sw", Util.telescope("grep_string", { word_match = "-w" }), desc = "Word (root dir)" },
            { "<Leader>sW", Util.telescope("grep_string", { cwd = false, word_match = "-w" }), desc = "Word (cwd)" },
            { "<Leader>sw", Util.telescope("grep_string"), mode = "v", desc = "Selection (root dir)" },
            { "<Leader>sW", Util.telescope("grep_string", { cwd = false }), mode = "v", desc = "Selection (cwd)" },
            {
                "<Leader>uC",
                Util.telescope("colorscheme", { enable_preview = true }),
                desc = "Colorscheme with preview",
            },
            {
                "<Leader>ss",
                Util.telescope("lsp_document_symbols", {
                    symbols = {
                        "Class",
                        "Function",
                        "Method",
                        "Constructor",
                        "Interface",
                        "Module",
                        "Struct",
                        "Trait",
                        "Field",
                        "Property",
                    },
                }),
                desc = "Goto Symbol",
            },
            {
                "<Leader>sS",
                Util.telescope("lsp_dynamic_workspace_symbols", {
                    symbols = {
                        "Class",
                        "Function",
                        "Method",
                        "Constructor",
                        "Interface",
                        "Module",
                        "Struct",
                        "Trait",
                        "Field",
                        "Property",
                    },
                }),
                desc = "Goto Symbol (Workspace)",
            },
        },
        opts = {
            defaults = {
                prompt_prefix = " ",
                selection_caret = " ",
                mappings = {
                    i = {
                        ["<C-t>"] = function(...)
                            return require("trouble.providers.telescope").open_with_trouble(...)
                        end,
                        ["<A-t>"] = function(...)
                            return require("trouble.providers.telescope").open_selected_with_trouble(...)
                        end,
                        ["<A-i>"] = function()
                            local action_state = require("telescope.actions.state")
                            local line = action_state.get_current_line()
                            Util.telescope("find_files", { no_ignore = true, default_text = line })()
                        end,
                        ["<A-h>"] = function()
                            local action_state = require("telescope.actions.state")
                            local line = action_state.get_current_line()
                            Util.telescope("find_files", { hidden = true, default_text = line })()
                        end,
                        ["<C-Down>"] = function(...)
                            return require("telescope.actions").cycle_history_next(...)
                        end,
                        ["<C-Up>"] = function(...)
                            return require("telescope.actions").cycle_history_prev(...)
                        end,
                        ["<C-f>"] = function(...)
                            return require("telescope.actions").preview_scrolling_down(...)
                        end,
                        ["<C-b>"] = function(...)
                            return require("telescope.actions").preview_scrolling_up(...)
                        end,
                    },
                    n = {
                        ["q"] = function(...)
                            return require("telescope.actions").close(...)
                        end,
                    },
                },
            },
        },
    },

    -- Which-key
    {
        "folke/which-key.nvim",
        event = "VeryLazy",
        opts = {
            plugins = { spelling = true },
            defaults = {
                mode = { "n", "v" },
                ["g"] = { name = "+goto" },
                ["gz"] = { name = "+surround" },
                ["]"] = { name = "+next" },
                ["["] = { name = "+prev" },
                ["<Leader><Tab>"] = { name = "+tabs" },
                ["<Leader>b"] = { name = "+buffer" },
                ["<Leader>c"] = { name = "+code" },
                ["<Leader>f"] = { name = "+file/find" },
                ["<Leader>g"] = { name = "+git" },
                ["<Leader>gh"] = { name = "+hunks" },
                ["<Leader>q"] = { name = "+quit/session" },
                ["<Leader>s"] = { name = "+search" },
                ["<Leader>u"] = { name = "+ui" },
                ["<Leader>w"] = { name = "+windows" },
                ["<Leader>x"] = { name = "+diagnostics/quickfix" },
            },
        },
        config = function(_, opts)
            local wk = require("which-key")
            wk.setup(opts)
            wk.register(opts.defaults)
        end,
    },

    -- Git
    {
        "lewis6991/gitsigns.nvim",
        event = { "BufReadPre", "BufNewFile" },
        opts = {
            signs = {
                add = { text = "▎" },
                change = { text = "▎" },
                delete = { text = "" },
                topdelete = { text = "" },
                changedelete = { text = "▎" },
                untracked = { text = "▎" },
            },
            on_attach = function(buffer)
                local gs = package.loaded.gitsigns

                local function map(mode, l, r, desc)
                    vim.keymap.set(mode, l, r, { buffer = buffer, desc = desc })
                end

                -- stylua: ignore start
                map("n", "]h", gs.next_hunk, "Next Hunk")
                map("n", "[h", gs.prev_hunk, "Prev Hunk")
                map({ "n", "v" }, "<Leader>ghs", ":Gitsigns stage_hunk<CR>", "Stage Hunk")
                map({ "n", "v" }, "<Leader>ghr", ":Gitsigns reset_hunk<CR>", "Reset Hunk")
                map("n", "<Leader>ghS", gs.stage_buffer, "Stage Buffer")
                map("n", "<Leader>ghu", gs.undo_stage_hunk, "Undo Stage Hunk")
                map("n", "<Leader>ghR", gs.reset_buffer, "Reset Buffer")
                map("n", "<Leader>ghp", gs.preview_hunk, "Preview Hunk")
                map("n", "<Leader>ghb", function() gs.blame_line({ full = true }) end, "Blame Line")
                map("n", "<Leader>ghd", gs.diffthis, "Diff This")
                map("n", "<Leader>ghD", function() gs.diffthis("~") end, "Diff This ~")
                map({ "o", "x" }, "ih", ":<C-U>Gitsigns select_hunk<CR>", "GitSigns Select Hunk")
            end,
        },
    },

    -- Highlights instances of the word under your cursor.
    {
        "RRethy/vim-illuminate",
        event = { "BufReadPost", "BufNewFile" },
        opts = {
            delay = 200,
            large_file_cutoff = 2000,
            large_file_overrides = {
                providers = { "lsp" },
            },
        },
        config = function(_, opts)
            require("illuminate").configure(opts)

            local function map(key, dir, buffer)
                vim.keymap.set("n", key, function()
                    require("illuminate")["goto_" .. dir .. "_reference"](false)
                end, { desc = dir:sub(1, 1):upper() .. dir:sub(2) .. " Reference", buffer = buffer })
            end

            map("]]", "next")
            map("[[", "prev")

            -- also set it after loading ftplugins, since a lot overwrite [[ and ]]
            vim.api.nvim_create_autocmd("FileType", {
                callback = function()
                    local buffer = vim.api.nvim_get_current_buf()
                    map("]]", "next", buffer)
                    map("[[", "prev", buffer)
                end,
            })
        end,
        keys = {
            { "]]", desc = "Next Reference" },
            { "[[", desc = "Prev Reference" },
        },
    },

    -- Quickfix list of diagnostics and others
    {
        "folke/trouble.nvim",
        cmd = { "TroubleToggle", "Trouble" },
        opts = { use_diagnostic_signs = true },
        keys = {
            { "<Leader>xx", "<cmd>TroubleToggle document_diagnostics<CR>", desc = "Document Diagnostics (Trouble)" },
            { "<Leader>xX", "<cmd>TroubleToggle workspace_diagnostics<CR>", desc = "Workspace Diagnostics (Trouble)" },
            { "<Leader>xL", "<cmd>TroubleToggle loclist<CR>", desc = "Location List (Trouble)" },
            { "<Leader>xQ", "<cmd>TroubleToggle quickfix<CR>", desc = "Quickfix List (Trouble)" },
            {
                "[q",
                function()
                    if require("trouble").is_open() then
                        require("trouble").previous({ skip_groups = true, jump = true })
                    else
                        local ok, err = pcall(vim.cmd.cprev)
                        if not ok then
                            vim.notify(err, vim.log.levels.ERROR)
                        end
                    end
                end,
                desc = "Previous trouble/quickfix item",
            },
            {
                "]q",
                function()
                    if require("trouble").is_open() then
                        require("trouble").next({ skip_groups = true, jump = true })
                    else
                        local ok, err = pcall(vim.cmd.cnext)
                        if not ok then
                            vim.notify(err, vim.log.levels.ERROR)
                        end
                    end
                end,
                desc = "Next trouble/quickfix item",
            },
        },
    },

    -- Finds and lists all of the TODO, HACK, BUG, etc comments
    {
        "folke/todo-comments.nvim",
        cmd = { "TodoTrouble", "TodoTelescope" },
        event = { "BufReadPost", "BufNewFile" },
        config = true,
        -- stylua: ignore
        keys = {
            { "]t", function() require("todo-comments").jump_next() end, desc = "Next Todo Comment" },
            { "[t", function() require("todo-comments").jump_prev() end, desc = "Previous Todo Comment" },
            { "<Leader>xt", "<cmd>TodoTrouble<CR>", desc = "Todo (Trouble)" },
            { "<Leader>xT", "<cmd>TodoTrouble keywords=TODO,FIX,FIXME<CR>", desc = "Todo/Fix/Fixme (Trouble)" },
            { "<Leader>st", "<cmd>TodoTelescope<CR>", desc = "Todo" },
            { "<Leader>sT", "<cmd>TodoTelescope keywords=TODO,FIX,FIXME<CR>", desc = "Todo/Fix/Fixme" },
        },
    },
}
