return {
  {
    "folke/lazydev.nvim",
    ft = "lua",
    opts = {
      library = {
        { path = "${3rd}/luv/library", words = { "vim%.uv" } },
        { path = vim.env.VIMRUNTIME,   words = { "vim" } },
      },
    },
  },
  {
    "mason-org/mason-lspconfig.nvim",
    opts = {},
    dependencies = {
      {
        "mason-org/mason.nvim",
        opts = {
          ui = { height = 0.8 }
        }
      },
      "neovim/nvim-lspconfig",
    },
  }
}
