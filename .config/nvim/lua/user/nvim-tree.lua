-- Control de mensaje de errores por falta de nvim-tree
local status_ok, nvim_tree = pcall(require, "nvim-tree")
if not status_ok then
    return
end

-- Control de mensaje de errores por falta de nvim-tree.config
local config_status_ok, nvim_tree_config = pcall(require, "nvim-tree.config")
if not config_status_ok then
    return
end

-- Importación de íconos
local icons = require("user.icons")

-- Definiendo variable local
local tree_cb = nvim_tree_config.nvim_tree_callback

-- Configuración de nvim-tree
nvim_tree.setup({
    disable_netrw = true,
    sync_root_with_cwd = true,
    view = {
        width = 40,
        mappings = {
            list = {
                { key = { "l", "<CR>", "o" }, cb = tree_cb "edit" },
                { key = "h", cb = tree_cb "close_node" },
                { key = "v", cb = tree_cb "vsplit" },
            },
        },
    },
    diagnostics = {
        enable = true,
        icons = {
            hint = icons.diagnostics.Hint,
            info = icons.diagnostics.Information,
            warning = icons.diagnostics.Warning,
            error = icons.diagnostics.Error,
        },
    },
    update_focused_file = {
        enable = true,
        update_root = true,
    },
    ignore_ft_on_setup = {
        "startify",
        "dashboard",
        "alpha",
    },
    filters = {
        custom = { ".git" },
        exclude = { ".gitignore" },
    },
    git = {
        timeout = 500,
    },
})
