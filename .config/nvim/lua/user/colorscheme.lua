-- TEMA ONEDARK: Configuración

local theme_onedark = require("onedark")
theme_onedark.setup({
    style = "darker",
    code_style = {
        comments = "italic",
        keywords = "bold",
        functions = "italic,bold",
        strings = "none",
        variables = "none"
    },
})

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

-- TEMA GRUVBOX: Configuración

vim.g.gruvbox_material_background = "hard"
vim.g.gruvbox_material_foreground = "material"
vim.g.gruvbox_material_transparent_background = 0
vim.g.gruvbox_material_visual = "reverse"
vim.g.gruvbox_material_menu_selection_background = "green"
vim.g.gruvbox_material_sign_column_background = "grey"
vim.g.gruvbox_material_spell_foreground = "colored"
vim.g.gruvbox_material_ui_contrast = "high"
vim.g.gruvbox_material_show_eob = 1
vim.g.gruvbox_material_disable_temrinal_colors = 0
vim.g.gruvbox_material_statusline_style = "dafault"
-- vim.g.gruvbox_material_better_performance = 1
vim.g.gruvbox_material_palette = "material"
-- Configuración dependiente de fuente
vim.g.gruvbox_material_disable_italic_comment = 0
vim.g.gruvbox_material_enable_bold = 1
vim.g.gruvbox_material_enable_italic = 1

-- Definiendo variable local
local colorscheme = "tokyonight"

-- Control de mensaje de errores por falta de colorscheme
local status_ok, _ = pcall(vim.cmd, "colorscheme " .. colorscheme)
if not status_ok then
    vim.notify("colorscheme " .. colorscheme .. " not found!")
    return
end
