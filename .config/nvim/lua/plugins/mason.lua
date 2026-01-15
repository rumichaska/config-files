return {
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
