return {
  {
    "nvim-telescope/telescope.nvim",
    version = "*",
    dependencies = {
      { "nvim-lua/plenary.nvim" },
      {
        "nvim-telescope/telescope-fzf-native.nvim",
        build = "make",
        config = function() require("telescope").load_extension("fzf") end,
      }
    },
    keys = {
      {
        "<Leader>sh",
        function() require("telescope.builtin").help_tags() end,
        desc = "Search help"
      },
      {
        "<Leader>sk",
        function() require("telescope.builtin").keymaps() end,
        desc = "Search keymaps"
      },
      {
        "<Leader>sb",
        function() require("telescope.builtin").current_buffer_fuzzy_find() end,
        desc = "Search in buffer"
      },
      {
        "<Leader>sg",
        function() require("telescope.builtin").live_grep() end,
        desc = "Grep string (cwd)"
      },
      {
        "<Leader>sw",
        function()
          require("telescope.builtin").grep_string({ word_match = "-w" })
        end,
        desc = "Search word (cwd)"
      },
      {
        "<Leader>ff",
        function() require("telescope.builtin").find_files() end,
        desc = "Find files"
      },
      {
        "<Leader>fp",
        function()
          require("telescope.builtin").find_files({
            cwd = vim.fs.joinpath(vim.fn.stdpath("data"), "lazy")
          })
        end,
        desc = "Find files (Plugins)"
      },
      {
        "<Leader>fb",
        function() require("telescope.builtin").buffers() end,
        desc = "Find buffers (cwd)"
      },
    },
    opts = {
      pickers = {
        help_tags = { theme = "dropdown" },
        keymaps = { theme = "dropdown" },
        current_buffer_fuzzy_find = { theme = "dropdown" },
        live_grep = { theme = "dropdown" },
        grep_string = { theme = "dropdown" },
        find_files = { previewer = false, theme = "dropdown", },
        buffers = { previewer = false, theme = "dropdown" },
      },
      extensions = {
        fzf = {}
      }
    }
  }
}
