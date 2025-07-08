return {
  {
    "nvim-telescope/telescope.nvim",
    tag = "0.1.8",
    dependencies = {
      { "nvim-lua/plenary.nvim" },
      {
        "nvim-telescope/telescope-fzf-native.nvim",
        build = "make",
        config = function()
          require("telescope").load_extension("fzf")
        end,
      }
    },
    keys = {
      {
        "<Leader>sh",
        function()
          require("telescope.builtin").help_tags()
        end,
        desc = "Search help"
      },
      {
        "<Leader>sk",
        function()
          require("telescope.builtin").keymaps()
        end,
        desc = "Search keymaps"
      },
      {
        "<Leader>sb",
        function()
          require("telescope.builtin").current_buffer_fuzzy_find()
        end,
        desc = "Search in buffer"
      },
      {
        "<Leader>sg",
        function()
          require("telescope.builtin").live_grep()
        end,
        desc = "Grep string (cwd)"
      },
      {
        "<Leader>sw",
        function()
          require("telescope.builtin").grep_string({
            word_match = "-w"
          })
        end,
        desc = "Search word (cwd)"
      },
      -- NOTE: Mejorar en función a la configuración anterior, crear 'util.lua'
      {
        "<Leader>ss",
        function()
          require("telescope.builtin").lsp_document_symbols({
            symbols = {
              "Class",
              "Function",
              "Method",
              "Constructor",
              "Interface",
              "Module",
              "Struct",
              "Trait",
              "Field",
              "Property",
            },
          })
        end,
        desc = "Go to document symbols (cwd)"
      },
      {
        "<Leader>sS",
        function()
          require("telescope.builtin").lsp_workspace_symbols({
            symbols = {
              "Class",
              "Function",
              "Method",
              "Constructor",
              "Interface",
              "Module",
              "Struct",
              "Trait",
              "Field",
              "Property",
            },
          })
        end,
        desc = "Go to workspace symbols (cwd)"
      },
      {
        "<Leader>ff",
        function()
          require("telescope.builtin").find_files()
        end,
        desc = "Find files"
      },
      {
        "<Leader>fb",
        function()
          require("telescope.builtin").buffers()
        end,
        desc = "Find buffers (cwd)"
      },
      {
        "<Leader>fp",
        function()
          require("telescope.builtin").find_files({
            ---@diagnostic disable-next-line: param-type-mismatch
            cwd = vim.fs.joinpath(vim.fn.stdpath("data"), "lazy")
          })
        end,
        desc = "Find files (Plugins)"
      },
    },
    opts = {
      pickers = {
        find_files = { theme = "ivy" },
        buffers = {
          mappings = {
            i = {
              ["<C-d>"] = function(...)
                return require("telescope.actions").delete_buffer(...)
              end,
            },
            n = {
              ["<C-d>"] = function(...)
                return require("telescope.actions").delete_buffer(...)
              end,
            }
          },
          previewer = false,
          theme = "dropdown"
        },
        grep_string = { theme = "dropdown" },
        current_buffer_fuzzy_find = { theme = "dropdown" },
        help_tags = { theme = "ivy" }
      },
      extensions = {
        fzf = {}
      }
    }
  }
}
