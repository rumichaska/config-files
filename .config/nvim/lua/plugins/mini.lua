return {
  -- Icons
  {
    "echasnovski/mini.icons",
    version = "*",
    opts = {},
  },
  -- Hipatterns
  {
    "echasnovski/mini.hipatterns",
    version = "*",
    opts = function()
      local hipatterns = require("mini.hipatterns")
      return {
        highlighters = {
          fixme = { pattern = "%f[%w]()FIXME()%f[%W]", group = "MiniHipatternsFixme" },
          hack = { pattern = "%f[%w]()HACK()%f[%W]", group = "MiniHipatternsHack" },
          todo = { pattern = "%f[%w]()TODO()%f[%W]", group = "MiniHipatternsTodo" },
          note = { pattern = "%f[%w]()NOTE()%f[%W]", group = "MiniHipatternsNote" },
          hex_color = hipatterns.gen_highlighter.hex_color(),
        }
      }
    end,
  },
  -- Pairs
  {
    "echasnovski/mini.pairs",
    version = "*",
    opts = {},
  },
  -- Surround
  {
    "echasnovski/mini.surround",
    version = "*",
    opts = {},
  },
  -- Indentscope
  {
    "echasnovski/mini.indentscope",
    version = "*",
    opts = {
      symbol = "│"
    }
  },
}
