-- Control de mensaje de errores por falta de lualine
local status_ok, lualine = pcall(require, "lualine")
if not status_ok then
    return
end

-- Importación de íconos
local icons = require("user.icons")

-- Condiciones
local conditions = {
    buffer_not_empty = function()
        return vim.fn.empty(vim.fn.expand("%:t")) ~= 1
    end,
    hide_in_width = function()
        return vim.fn.winwidth(0) > 80
    end,
}

-- Definiendo variable local para personalización de `diagnostics`
local diagnostics = {
    "diagnostics",
    sources = { "nvim_diagnostic" },
    sections = { "error", "warn" },
    symbols = {
        error = icons.diagnostics.ErrorOutline .. " ",
        warn = icons.diagnostics.WarningOutline .. " ",
    },
    always_visible = true,
}

-- Definiendo variables local para personalización de `diff`
local diff = {
    "diff",
    symbols = {
        added = icons.git.Add .. " ",
        modified = icons.git.Mod .. "",
        removed = icons.git.Remove .. " ",
    },
    cond = conditions.hide_in_width,
}

-- Definiendo variable local para personalización de `filename`
local filename = {
    "filename",
    fmt = function(str)
        return "%=" .. str
    end,
    color = { gui = "bold" }
}

-- Definiendo variable local para personalización de `mode`
local mode = {
    "mode",
    fmt = function(str)
        return "-- " .. str .. " --"
    end,
}

-- Defeniendo variable local para personalización de `branch`
local branch = {
    "branch",
    icon = "",
}

-- Definiendo variable loal para la personalización de `encoding`
local encoding = {
    "encoding",
    fmt = string.upper
}

-- Configuración de lualine
lualine.setup({
    options = {
        theme = "auto",
        section_separators = "",    -- Deshabilitado, por defecto : { left = '', right = ''},
        component_separators = "|",  -- Deshabilitado, por defecto : { left = '', right = ''},
        disabled_filetypes = { "dashboard", "NvimTree", "Outline" },
        always_divide_middle = true,
    },
    sections = {
        lualine_a = { mode },
        lualine_b = { branch, diff, diagnostics },
        lualine_c = { filename },
        lualine_x = { encoding, "fileformat", "filetype" },
        lualine_y = { "progress" },
        lualine_z = { "location" },
    },
    inactive_sections = {
        lualine_a = {},
        lualine_b = {},
        lualine_c = {},
        lualine_x = {},
        lualine_y = {},
        lualine_z = {},
    },
    tabline = {},
    winbar = {},
    extensions = { "toggleterm" },
})
