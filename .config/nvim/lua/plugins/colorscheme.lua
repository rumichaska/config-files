return {
  -- Catppuccin
  {
    "catppuccin/nvim",
    name = "catppuccin",
    lazy = false,
    priority = 1000,
    opts = {
      flavour = "mocha",
      styles = {
        conditionals = { "bold" },
        loops = { "bold" },
        functions = { "bold" },
        keywords = { "bold" }
      },
      lsp_styles = {
        underlines = {
          errors = { "undercurl" },
          hints = { "undercurl" },
          warnings = { "undercurl" },
          information = { "undercurl" },
          ok = { "undercurl" },
        },
        inlay_hints = {
          background = true,
        },
      },
      custom_highlights = function(colors)
        return {
          WinSeparator = { fg = colors.flamingo },
        }
      end,
      defaul_integrations = false,
      integrations = {
        blink_cmp = { style = "bordered" },
        gitsigns = true,
        mason = true,
        mini = { enabled = true },
        render_markdown = true,
        telescope = { enabled = true },
      },
    },
    config = function(_, opts)
      require("catppuccin").setup(opts)
      vim.cmd.colorscheme("catppuccin")
    end,
  }
}
