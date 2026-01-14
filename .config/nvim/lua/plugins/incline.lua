return {
  {
    "b0o/incline.nvim",
    event = "VeryLazy",
    opts = function()
      return {
        hide = { cursorline = "smart" },
        render = function(props)
          local icons = require("mini.icons")
          local palette = require("catppuccin.palettes").get_palette("mocha")
          local filename = vim.fn.fnamemodify(vim.api.nvim_buf_get_name(props.buf), ":t")
          if filename == "" then filename = "[No Name]" end
          local ft_icon, ft_hl, _ = icons.get("file", filename)
          local function get_file_name()
            local label = {}
            table.insert(
              label,
              { " " .. (vim.bo[props.buf].modified and " " or ""), guifg = palette.maroon }
            )
            table.insert(label, { (ft_icon or "") .. " ", group = ft_hl })
            table.insert(
              label,
              { filename .. " ", gui = vim.bo[props.buf].modified and "bold,italic" or "bold" }
            )
            if not props.focused then
              label["group"] = "MiniStarterInactive"
            end
            return label
          end
          return { get_file_name() }
        end,
        window = {
          padding = 0,
          margin = { horizontal = 0 },
        },
      }
    end,
  },
}
