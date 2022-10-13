-- Control de mensaje de errores por falta de project
local status_ok, project = pcall(require, "project_nvim")
if not status_ok then
    return
end

-- Configuración de project_nvim
project.setup({
    manual_mode = false,
    detection_methods = { "lsp", "pattern" },
    patterns = { ".git", "*.Rproj", "Makefile" },
    ignore_lsp = {},
    exclude_dirs = {},
    show_hidden = false,
    silent_chdir = true,
    scope_chdir = "global",
    datapath = vim.fn.stdpath("data"),
})
