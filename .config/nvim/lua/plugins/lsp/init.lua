return {

    -- lspconfig
    {
        "neovim/nvim-lspconfig",
        event = { "BufReadPre", "BufNewFile" },
        dependencies = {
            -- stylua: ignore
            { "folke/neoconf.nvim", cmd = "Neoconf", config = false, dependencies = { "nvim-lspconfig" } },
            { "folke/neodev.nvim", opts = {} },
            "williamboman/mason.nvim",
            "williamboman/mason-lspconfig.nvim",
            {
                "hrsh7th/cmp-nvim-lsp",
                cond = function()
                    return require("util").has("nvim-cmp")
                end,
            },
        },
        -- From LazyVim github
        opts = {
            diagnostics = {
                underline = true,
                update_in_insert = false,
                virtual_text = false,
                -- virtual_text = {
                --     spacing = 4,
                --     source = "if_many",
                --     prefix = "icons",
                -- },
                severity_sort = true,
                float = {
                    border = "rounded",
                },
            },
            inlay_hints = {
                enabled = false,
            },
            capabilities = {},
            autoformat = false,
            format = {
                formatting_options = nil,
                timeout_ms = nil,
            },
            -- LSP Server Settings
            servers = {
                lua_ls = {
                    settings = {
                        Lua = {
                            workspace = {
                                checkThirdParty = false,
                            },
                            completion = {
                                callSnippet = "Replace",
                            },
                            hint = { enable = true },
                        },
                    },
                },
                r_language_server = {
                    mason = false,
                    root_dir = function(fname)
                        local util = require("lspconfig.util")
                        return util.root_pattern("*.Rproj")(fname) or util.find_git_ancestor(fname) or vim.loop.os_homedir()
                    end,
                    settings = {
                        r = {
                            lsp = {
                                diagnostics = true,
                                rich_documentation = false,
                            },
                        },
                    },
                },
                pyright = {
                    mason = false,
                    settings = {
                        python = {
                            analysis = {
                                autoSearchPaths = true,
                                diagnosticMode = "workspace",
                                useLibraryCodeForTypes = true,
                            },
                        },
                    },
                },
            },
            setup = {},
        },
        config = function(_, opts)
            local Util = require("util")

            if Util.has("neoconf.nvim") then
                local plugin = require("lazy.core.config").spec.plugins["neoconf.nvim"]
                require("neoconf").setup(require("lazy.core.plugin").values(plugin, "opts", false))
            end

            -- Setup autoformat
            require("plugins.lsp.format").setup(opts)
            -- Setup formatting and keymaps
            Util.on_attach(function(client, buffer)
                require("plugins.lsp.keymaps").on_attach(client, buffer)
            end)

            local register_capability = vim.lsp.handlers["client/registerCapability"]

            vim.lsp.handlers["client/registerCapability"] = function(err, res, ctx)
                local ret = register_capability(err, res, ctx)
                local client_id = ctx.client_id
                local client = vim.lsp.get_client_by_id(client_id)
                local buffer = vim.api.nvim_get_current_buf()
                require("plugins.lsp.keymaps").on_attach(client, buffer)
                return ret
            end

            -- Diagnostics
            for name, icon in pairs(require("config").icons.diagnostics) do
                name = "DiagnosticSign" .. name
                vim.fn.sign_define(name, { text = icon, texthl = name, numhl = "" })
            end

            local inlay_hint = vim.lsp.buf.inlay_hint or vim.lsp.inlay_hint

            if opts.inlay_hints.enabled and inlay_hint then
                Util.on_attach(function(client, buffer)
                    if client.supports_method("textDocument/inlayHint") then
                        inlay_hint(buffer, true)
                    end
                end)
            end

            if type(opts.diagnostics.virtual_text) == "table" and opts.diagnostics.virtual_text.prefix == "icons" then
                opts.diagnostics.virtual_text.prefix = vim.fn.has("nvim-0.10.0") == 0 and "●"
                    or function(diagnostic)
                        local icons = require("config").icons.diagnostics
                        for d, icon in pairs(icons) do
                            if diagnostic.severity == vim.diagnostic.severity[d:upper()] then
                                return icon
                            end
                        end
                    end
            end

            vim.diagnostic.config(vim.deepcopy(opts.diagnostics))

            local servers = opts.servers
            local has_cmp, cmp_nvim_lsp = pcall(require, "cmp_nvim_lsp")
            local capabilities = vim.tbl_deep_extend(
                "force",
                {},
                vim.lsp.protocol.make_client_capabilities(),
                has_cmp and cmp_nvim_lsp.default_capabilities() or {},
                opts.capabilities or {}
            )

            local function setup(server)
                local server_opts = vim.tbl_deep_extend("force", {
                    capabilities = vim.deepcopy(capabilities),
                }, servers[server] or {})

                if opts.setup[server] then
                    if opts.setup[server](server, server_opts) then
                        return
                    end
                elseif opts.setup["*"] then
                    if opts.setup["*"](server, server_opts) then
                        return
                    end
                end
                require("lspconfig")[server].setup(server_opts)
                require("lspconfig.ui.windows").default_options.border = "rounded"
            end

            -- get all the servers that are available thourgh mason-lspconfig
            local have_mason, mlsp = pcall(require, "mason-lspconfig")
            local all_mslp_servers = {}
            if have_mason then
                all_mslp_servers = vim.tbl_keys(require("mason-lspconfig.mappings.server").lspconfig_to_package)
            end

            local ensure_installed = {}
            for server, server_opts in pairs(servers) do
                if server_opts then
                    server_opts = server_opts == true and {} or server_opts
                    -- run manual setup if mason=false or if this is a server that cannot be installed with mason-lspconfig
                    if server_opts.mason == false or not vim.tbl_contains(all_mslp_servers, server) then
                        setup(server)
                    else
                        ensure_installed[#ensure_installed + 1] = server
                    end
                end
            end

            if have_mason then
                mlsp.setup({ ensure_installed = ensure_installed, handlers = { setup } })
            end

            if Util.lsp_get_config("denols") and Util.lsp_get_config("tsserver") then
                local is_deno = require("util").root_pattern("deno.json", "deno.jsonc")
                Util.lsp_disable("tsserver", is_deno)
                Util.lsp_disable("denols", function(root_dir)
                    return not is_deno(root_dir)
                end)
            end
        end,
    },

    -- Formatters (check for alternative)
    {
        "nvimtools/none-ls.nvim",
        event = { "BufReadPre", "BufNewFile" },
        dependencies = { "williamboman/mason.nvim" },
        opts = function()
            local nls = require("null-ls")
            return {
                root_dir = require("null-ls.utils").root_pattern(".null-ls-root", ".neoconf.json", "Makefile", ".git"),
                sources = {
                    -- Lua
                    nls.builtins.formatting.stylua,
                    -- Python
                    nls.builtins.diagnostics.pylint.with({
                        diagnostics_postprocess = function(diagnostic)
                            diagnostic.code = diagnostic.message_id
                        end,
                    }),
                },
            }
        end,
    },

    -- cmdline tools and lsp servers
    {
        "williamboman/mason.nvim",
        cmd = "Mason",
        keys = {
            { "<Leader>cm", "<cmd>Mason<CR>", desc = "Mason" },
        },
        build = ":MasonUpdate",
        opts = {
            ensure_installed = {
                "stylua",
            },
            ui = {
                border = "rounded",
            },
        },
        config = function(_, opts)
            require("mason").setup(opts)
            local mr = require("mason-registry")
            local function ensure_installed()
                for _, tool in ipairs(opts.ensure_installed) do
                    local p = mr.get_package(tool)
                    if not p:is_installed() then
                        p:install()
                    end
                end
            end
            if mr.refresh then
                mr.refresh(ensure_installed)
            else
                ensure_installed()
            end
        end,
    },
}
