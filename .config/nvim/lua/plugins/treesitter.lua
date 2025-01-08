return {
  "nvim-treesitter/nvim-treesitter",
  version = false,
  build = ":TSUpdate",
  main = "nvim-treesitter.configs",
  opts = {
    ensure_installed = {
      "bash",
      "c",
      "html",
      "javascript",
      "julia",
      "lua",
      "markdown",
      "markdown_inline",
      "python",
      "query",
      "r",
      "vim",
      "vimdoc",
      "yaml",
    },
    auto_install = false,
    highlight = {
      enable = true,
      additional_vim_regex_highlighting = false,
    },
    indent = { enable = true },
    incremental_selection = { enable = true }
  },
}
