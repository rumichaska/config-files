return {
  "Vigemus/iron.nvim",
  cmd = "IronRepl",
  main = "iron.core",
  ft = { "r", "rmd", "quarto", "python", "julia" },
  opts = function()
    return {
      config = {
        highlight_last = false,
        scratch_repl = true,
        close_window_on_exit = true,
        repl_definition = {
          r = {
            command = { "R", "--no-save", "-q" },
          },
          rmd = {
            command = { "R", "--no-save", "-q" },
          },
          quarto = {
            command = { "R", "--no-save", "-q" },
          },
          python = require("iron.fts.python").ipython,
          julia = require("iron.fts.julia").julia,
        },
        repl_open_cmd = require("iron.view").split("30%", {
          number = false,
          relativenumber = false,
        }),
      },
      keymaps = {
        toggle_repl = "<Leader>rr",
        restar_repl = "<Leader>rR",
        visual_send = "<C-CR>",
        send_line = "<C-CR>",
        send_paragraph = "<A-p>",
        send_until_cursor = "<A-b>",
        exit = "<Leader>rq",
        clear = "<Leader>rc",
      },
      ignore_blank_lines = true,
    }
  end,
}
