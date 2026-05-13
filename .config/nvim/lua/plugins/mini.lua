return {
  {
    "nvim-mini/mini.nvim",
    version = false,
    config = function()
      -- Pairs
      require("mini.pairs").setup()
      -- Surround
      require("mini.surround").setup()
      -- Icons
      require("mini.icons").setup()
      -- Indentscope
      require("mini.indentscope").setup({ symbol = "│" })
      -- Hipatterns
      require("mini.hipatterns").setup({
        highlighters = {
          fixme = { pattern = "%f[%w]()FIXME()%f[%W]", group = "MiniHipatternsFixme" },
          hack = { pattern = "%f[%w]()HACK()%f[%W]", group = "MiniHipatternsHack" },
          todo = { pattern = "%f[%w]()TODO()%f[%W]", group = "MiniHipatternsTodo" },
          note = { pattern = "%f[%w]()NOTE()%f[%W]", group = "MiniHipatternsNote" },
          hex_color = require("mini.hipatterns").gen_highlighter.hex_color({
            filter = function()
              local hex_color_disable = require("util").lsp.minihipatterns_disable
              local buffer = vim.api.nvim_get_current_buf()
              if not hex_color_disable[vim.bo[buffer].ft] then
                return true
              end
            end,
          }),
        }
      })
    end,
  }
}
