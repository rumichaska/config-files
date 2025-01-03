return {
  -- Icons
  {
    "echasnovski/mini.icons",
    version = false,
    opts = {},
  },
  -- Hipatterns
  {
    "echasnovski/mini.hipatterns",
    version = false,
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
    version = false,
    opts = {},
  },
  -- Surround
  {
    "echasnovski/mini.surround",
    version = false,
    opts = {},
  },
  -- Indentscope
  {
    "echasnovski/mini.indentscope",
    version = false,
    opts = {
      symbol = "│"
    }
  },
}
