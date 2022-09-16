-- Control de mensaje de errores por falta de lualine
local status_ok, lualine = pcall(require, "lualine")
if not status_ok then
    return
end

-- Importación de íconos
local icons = require("user.icons")

-- Definiendo variable local para personalización de `diagnostics`
local diagnostics = {
    "diagnostics",
    sources = { "nvim_diagnostic" },
    sections = { "error", "warn" },
    symbols = {
        error = icons.diagnostics.ErrorOutline .. " ",
        warn = icons.diagnostics.WarningOutline .. " ",
    },
    colored = true,
    update_in_insert = false,
    always_visible = true,
}

-- Definiendo variables locales para personalización de `diff`
local hide_in_width = function()
    return vim.fn.winwidth(0) > 80
end

local diff = {
    "diff",
    colored = true,
    symbols = {
        added = icons.git.Add .. " ",
        modified = icons.git.Mod .. "",
        removed = icons.git.Remove .. " ",
    },
    cond = hide_in_width,
}

-- Definiendo variable local para personalización de `mode`
local mode = {
    "mode",
    fmt = function(str)
        return "-- " .. str .. " --"
    end,
}

-- Defeniendo variable local para personalización de `branch` (opcional)
local branch = {
    "branch",
    icons_enabled = true,
    icon = "",
}

-- Configuración de lualine
lualine.setup({
    options = {
        icons_enabled = true,
        theme = "auto",
        component_separators = "|",  -- Deshabilitado, por defecto : { left = '', right = ''},
        section_separators = "",    -- Deshabilitado, por defecto : { left = '', right = ''},
        disabled_filetypes = { "dashboard", "NvimTree", "Outline" },
        always_divide_middle = true,
    },
    sections = {
        lualine_a = { mode },
        lualine_b = { branch, diff, diagnostics },
        lualine_c = { "filename" },
        lualine_x = { "encoding", "fileformat", "filetype" },
        lualine_y = { "progress" },
        lualine_z = { "location" },
    },
    inactive_sections = {
        lualine_a = {},
        lualine_b = {},
        lualine_c = { "filename" },
        lualine_x = { "location" },
        lualine_y = {},
        lualine_z = {},
    },
    tabline = {},
    extensions = {},
})
