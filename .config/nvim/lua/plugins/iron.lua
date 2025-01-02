return {
  "Vigemus/iron.nvim",
  cmd = "IronRepl",
  main = "iron.core",
  opts = function()
    -- Remove extra <CR> when sending lines to R console
    -- local bracketed_paste_radian = function(lines)
    --   local open_code = "\27[200~"
    --   local close_code = "\27[201~"
    --   local cr = "\13"
    --   if #lines == 1 then
    --     return { lines[1] .. cr }
    --   else
    --     local new = { open_code .. lines[1] }
    --     for line = 2, #lines do
    --       table.insert(new, lines[line])
    --     end
    --
    --     table.insert(new, close_code)
    --     return new
    --   end
    -- end
    return {
      config = {
        scratch_repl = true,
        close_window_on_exit = true,
        repl_definition = {
          -- r = {
          --   command = { "radian" },
          --   format = bracketed_paste_radian,
          -- },
          r = require("iron.fts.r").radian,
          python = require("iron.fts.python").ipython,
          julia = require("iron.fts.julia").julia,
        },
        repl_open_cmd = require("iron.view").split("30%", {
          number = false,
          relativenumber = false,
        }),
      },
      keymaps = {
        visual_send = "<C-CR>",
        send_line = "<C-CR>",
        send_paragraph = "<A-p>",
        send_until_cursor = "<A-b>",
        exit = "<Leader>tq",
        clear = "<Leader>tc",
      },
      highlight_last = false,
      ignore_blank_lines = true,
    }
  end,
}
