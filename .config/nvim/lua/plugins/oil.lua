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
  },
  opts = {
    view_options = {
      show_hidden = true,
    },
  }
}
