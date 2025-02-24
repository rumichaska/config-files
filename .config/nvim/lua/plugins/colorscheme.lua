return {
  -- Kanagawa
  {
    "rebelot/kanagawa.nvim",
    enabled = false,
    lazy = false,
    priority = 1000,
    opts = {
      colors = {
        palette = { dragonBlack3 = "#000000" },
        theme = {
          all = {
            ui = { bg_gutter = "none" },
          },
        },
      },
      overrides = function(colors)
        local theme = colors.theme
        return {
          Pmenu = { fg = theme.ui.shade0, bg = theme.ui.bg_p1 },
          PmenuSel = { fg = "NONE", bg = theme.ui.bg_p2 },
          PmenuSbar = { bg = theme.ui.bg_m1 },
          PmenuThumb = { bg = theme.ui.bg_p2 },
        }
      end,
      theme = "dragon",
    },
    config = function(_, opts)
      require("kanagawa").setup(opts)
      vim.cmd.colorscheme("kanagawa")
    end,
  },
  -- Catppuccin
  {
    "catppuccin/nvim",
    name = "catppuccin",
    lazy = false,
    priority = 1000,
    opts = {
      flavour = "mocha",
      term_colors = true,
      styles = {
        conditionals = { "bold" },
        loops = { "bold" },
        keywords = { "bold" }
      },
      color_overrides = {
        mocha = {
          base = "#000000",
          mantle = "#000000",
          crust = "#000000"
        },
      },
      custom_highlights = function(colors)
        return {
          WinSeparator = { fg = colors.flamingo },
        }
      end,
      defaul_integrations = false,
      integrations = {
        blink_cmp = true,
        gitsigns = true,
        markdown = true,
        mason = true,
        mini = { enabled = true },
        native_lsp = {
          enabled = true,
          underlines = {
            errors = { "undercurl" },
            hints = { "undercurl" },
            warnings = { "undercurl" },
            information = { "undercurl" },
            ok = { "undercurl" },
          },
        },
        render_markdown = true,
        treesitter = true,
        telescope = { enabled = true },
      },
    },
    config = function(_, opts)
      require("catppuccin").setup(opts)
      vim.cmd.colorscheme("catppuccin")
    end,
  }
}
