return {
  {
    "saghen/blink.cmp",
    dependencies = "rafamadriz/friendly-snippets",
    version = "*",
    opts = {
      keymap = { preset = "default" },
      appearance = { nerd_font_variant = "mono" },
      completion = {
        accept = { auto_brackets = { enabled = false } },
        menu = {
          border = "rounded",
          scrollbar = false,
          draw = {
            columns = {
              { "label", "label_description", gap = 1 }, { "kind_icon", "kind" }
            },
            components = {
              kind_icon = {
                ellipsis = false,
                text = function(ctx)
                  local kind_icon, _, _ = require("mini.icons").get("lsp", ctx.kind)
                  return kind_icon
                end,
                -- Optionally, you may also use the highlights from mini.icons
                highlight = function(ctx)
                  local _, hl, _ = require("mini.icons").get("lsp", ctx.kind)
                  return hl
                end,
              }
            }
          }
        },
        documentation = {
          auto_show = false,
          window = {
            border = "rounded",
            scrollbar = false,
          }
        },
        ghost_text = { enabled = true }
      },
      signature = {
        enabled = true,
        window = { border = "rounded" }
      },
      cmdline = { enabled = false },
      sources = {
        default = { "lsp", "path", "snippets", "buffer" },
        per_filetype = {
          -- add lazydev to your completion providers
          lua = { "lazydev", "lsp", "path", "snippets", "buffer" },
          r = { "lsp", "buffer", "path", "snippets" },
        },
        providers = {
          lazydev = {
            name = "LazyDev",
            module = "lazydev.integrations.blink",
            -- make lazydev completions top priority (see `:h blink.cmp`)
            score_offset = 100,
          },
          path = {
            opts = {
              get_cwd = function() return vim.fn.getcwd() end,
            }
          },
        },
      },
    },
  }
}
