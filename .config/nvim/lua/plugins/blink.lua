return {
  { "rafamadriz/friendly-snippets" },
  {
    "saghen/blink.cmp",
    version = "*",
    opts = {
      keymap = { preset = "default" },
      appearance = { nerd_font_variant = "mono" },
      completion = {
        accept = { auto_brackets = { enabled = false } },
        menu = {
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
            scrollbar = false,
          }
        },
        ghost_text = { enabled = true }
      },
      signature = {
        enabled = true,
      },
      cmdline = { enabled = false },
      sources = {
        default = { "lsp", "path", "snippets", "buffer" },
        per_filetype = {
          r = { "lsp", "buffer", "path" },
          rmd = { "lsp", "buffer", "path", "markdown" },
          quarto = { "lsp", "buffer", "path", "markdown" },
          markdown = { "buffer", "path", "markdown" },
        },
        providers = {
          markdown = {
            name = "RenderMarkdown",
            module = "render-markdown.integ.blink",
            fallbacks = { "lsp" },
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
