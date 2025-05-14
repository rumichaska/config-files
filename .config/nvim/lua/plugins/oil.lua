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
    delete_to_trash = true,
    view_options = {
      show_hidden = true,
    },
    float = {
      max_width = 0.8,
      max_height = 0.8,
    },
  },
}
