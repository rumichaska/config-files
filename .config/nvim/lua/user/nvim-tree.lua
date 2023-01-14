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

-- Control de mensaje de errores cuando se importa icons
local icons_ok, icons = pcall(require, "user.icons")
if not icons_ok then
    return
end

-- Definiendo variable local
local tree_cb = nvim_tree_config.nvim_tree_callback

-- Configuración de nvim-tree
nvim_tree.setup({
    disable_netrw = true,
    sync_root_with_cwd = true,
    respect_buf_cwd = true,
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
    renderer = {
        icons = {
            glyphs = {
                git = {
                    unstaged = icons.git_status.Unstaged,
                    staged = icons.git_status.Staged,
                    -- unmerged = icon.git_status.Unmerged,
                    renamed = icons.git_status.Renamed,
                    untracked = icons.git_status.Untracked,
                    deleted = icons.git_status.Deleted,
                    ignored = icons.git_status.Ignored,
                },
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
        dotfiles = true,
        exclude = { ".gitignore" },
    },
    git = {
        timeout = 500,
    },
})

-- Keymaps
vim.keymap.set("n", "<Leader>e", ":NvimTreeToggle<CR>", { desc = "[E]nter explorer" })
