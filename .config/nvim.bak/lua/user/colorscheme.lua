-- TEMA TOKYONIGHT: Configuración

local theme_tokyonight = require("tokyonight")
theme_tokyonight.setup({
    style = "night",
    styles = {
        comments = { italic = true },
        keywords = { italic = false, bold = true },
        functions = { italic = true, bold = true },
        variables = {},
    },
    sidebars = { "qf", "packer", "terminal", "help" },
    lualine_bold = true,
    on_highlights = function(hl, c)
        hl.CursorLineNr = {
            fg = c.yellow,
            bold = true,
        }
        hl.NvimTreeWinSeparator = {
            fg = c.bg_sidebar,
        }
    end,
})

-- Definiendo variable local
local colorscheme = "tokyonight"

-- Control de mensaje de errores por falta de colorscheme
local status_ok, _ = pcall(vim.cmd, "colorscheme " .. colorscheme)
if not status_ok then
    vim.notify("colorscheme " .. colorscheme .. " not found!")
    return
end
