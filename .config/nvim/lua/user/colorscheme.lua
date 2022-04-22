-- TEMA NORD: Configuración

local ts_nord = require("nord")
vim.g.nord_borders = true
vim.g.nord_disable_background = false
ts_nord.set()

-- TEMA ONEDARK: Configuración

local ts_onedark = require("onedark")
ts_onedark.setup({
    dark_sidebar = true,
    dark_float = true,
    highlight_linenumber = true,
    sidebars = { "packer", "terminal" },
    transparent = false,
    transparent_sidebar = false,
    -- Configuración dependiente de fuente
    keyword_style = "NONE",
    comment_style = "NONE",
    function_style = "NONE",
    variable_style = "NONE",
    lualine_bold = true,
})

-- TEMA TOKYONIGHT: Configuración

vim.g.tokyonight_style = "storm"
vim.g.tokyonight_dark_sidebar = true
vim.g.tokyonight_dark_float = true
vim.g.tokyonight_sidebars = { "packer", "terminal" }
vim.g.tokyonight_transparent = false
vim.g.tokyonight_transparent_sidebar = false
-- Configuración dependiente de fuente
vim.g.tokyonight_italic_keywords = true
vim.g.tokyonight_italic_comments = true
vim.g.tokyonight_italic_functions = true
vim.g.tokyonight_italic_variables = true
vim.g.tokyonight_lualine_bold = true

-- TEMA GRUVBOX: Configuración

vim.g.gruvbox_material_better_performance = 1
vim.g.gruvbox_material_palette = "material"
vim.g.gruvbox_material_background = "soft"
vim.g.gruvbox_material_transparent_background = 0
vim.g.gruvbox_material_visual = "reverse"
-- Configuración dependiente de fuente
vim.g.gruvbox_material_enable_italic = 1
vim.g.gruvbox_material_disable_italic_comment = 0
vim.g.gruvbox_material_enable_bold = 1

-- Definiendo variable local
local colorscheme = "gruvbox-material"

-- Control de mensaje de errores por falta de colorscheme
local status_ok, _ = pcall(vim.cmd, "colorscheme " .. colorscheme)
if not status_ok then
    vim.notify("colorscheme " .. colorscheme .. " not found!")
    return
end
