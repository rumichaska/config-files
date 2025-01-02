return {
  "stevearc/oil.nvim",
  keys = {
    {
      "<Leader>e",
      function()
        require("oil").open_float()
      end,
      desc = "Open oil"
    },
    {
      "q",
      function()
        require("oil").close()
      end,
      desc = "Close oil"
    },
  },
  opts = {
    keymaps = {
      ["<C-c>"] = false,
    },
    view_options = {
      show_hidden = true,
    },
  }
}
