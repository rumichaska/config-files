-- Control de mensaje de errores por falta de project
local status_ok, project = pcall(require, "project_nvim")
if not status_ok then
    return
end

-- Configuración de project_nvim
project.setup({
    manual_mode = false,
    detection_methos = { "lsp", "pattern" },
    patterns = { ".git", "_darcs", ".hg", ".bzr", ".svn", "Makefile", "package.json", "*.Rproj" },
    ignore_lsp = {},
    exclude_dirs = {},
    show_hidden = false,
    silent_chdir = true,
    datapath = vim.fn.stdpath("data"),
})
