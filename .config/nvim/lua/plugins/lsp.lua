return {
  {
    "folke/lazydev.nvim",
    ft = "lua",
    opts = {
      library = {
        { path = "${3rd}/luv/library", words = { "vim%.uv" } },
      },
    },
  },
  {
    "williamboman/mason.nvim",
    version = "^1.0.0"
  },
  {
    "williamboman/mason-lspconfig.nvim",
    version = "^1.0.0"
  },
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        lua_ls = {
          settings = {
            Lua = {
              workspace = {
                checkThirdParty = false,
              },
              codeLens = {
                enable = true,
              },
              completion = {
                callSnippet = "Replace",
              },
              doc = {
                privateName = { "^_" },
              },
              hint = {
                enable = true,
                setType = false,
                paramType = true,
                paramName = "Disable",
                semicolon = "Disable",
                arrayIndex = "Disable",
              },
            },
          },
        },
        r_language_server = {
          root = function(fname)
            return require("lspconfig.util").root_pattern("*.Rproj", "DESCRIPTION", "NAMESPACE", ".Rbuildignore")(fname)
                or vim.fs.dirname(vim.fs.find('.git', { path = startpath, upward = true })[1])
                or vim.loop.os_homedir()
          end,
          settings = {
            r = {
              lsp = {
                diagnostic = true,
                rich_documentation = false,
              },
            },
          },
        },
        pyright = {
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
      }
    },
    config = function(_, opts)
      -- Mason
      require("mason").setup({ ui = { border = "rounded", height = 0.8 } })
      local ensure_installed = vim.tbl_keys(opts.servers or {})
      require("mason-lspconfig").setup({
        ensure_installed = ensure_installed,
      })
      -- Diagnostics
      local diagnostics = {
        underline = true,
        update_in_insert = false,
        virtual_text = false,
        severity_sort = true,
        float = {
          border = "rounded"
        }
      }
      vim.diagnostic.config(vim.deepcopy(diagnostics))
      -- LSP config
      local lspconfig = require("lspconfig")
      for server, config in pairs(opts.servers) do
        config.capabilities = require("blink.cmp").get_lsp_capabilities(config.capabilities)
        lspconfig[server].setup(config)
      end
    end
  }
}
