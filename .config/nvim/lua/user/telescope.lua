-- Control de mensaje de errores por falta de telescope
local telescope_ok, telescope = pcall(require, "telescope")
if not telescope_ok then
    return
end

-- Control de mensaje de errores por falta de telescope.actions
local actions_ok, actions = pcall(require, "telescope.actions")
if not actions_ok then
    return
end

-- Control de mensaje de errores por falta de telescope.builtin
local builtin_ok, builtin = pcall(require, "telescope.builtin")
if not builtin_ok then
    return
end

-- Control de mensaje de errores por falta de telescope.builtin
local themes_ok, themes = pcall(require, "telescope.themes")
if not themes_ok then
    return
end

-- Control de mensaje de errores cuando se importa icons
local icons_ok, icons = pcall(require, "user.icons")
if not icons_ok then
    return
end

-- Configuración de telescope
telescope.setup({
    defaults = {
        -- Configuración general
        prompt_prefix = icons.ui.Telescope .. " ",
        selection_caret = icons.ui.TelescopeCaret .. " ",
        path_display = { "smart" },
        -- Mapeo
        mappings = {
            -- Insert mode
            i = {
                -- Navegación del historial de búsqueda
                ["<C-n>"] = actions.cycle_history_next,
                ["<C-p>"] = actions.cycle_history_prev,
                -- Navegación entre opciones
                ["<C-j>"] = actions.move_selection_next,
                ["<C-k>"] = actions.move_selection_previous,
                ["<Down>"] = actions.move_selection_next,
                ["<Up>"] = actions.move_selection_previous,
                ["<C-u>"] = actions.preview_scrolling_up,
                ["<C-d>"] = actions.preview_scrolling_down,
                ["<PageUp>"] = actions.results_scrolling_up,
                ["<PageDown>"] = actions.results_scrolling_down,
                -- Cerrar ventana
                ["<C-c>"] = actions.close,
                -- Opciones de selección
                ["<CR>"] = actions.select_default,
                ["<C-x>"] = actions.select_horizontal,
                ["<C-v>"] = actions.select_vertical,
                ["<C-t>"] = actions.select_tab,
                -- Otras opciones de mapeo
                -- ["<Tab>"] = actions.toggle_selection + actions.move_selection_worse,
                -- ["<S-Tab>"] = actions.toggle_selection + actions.move_selection_better,
                ["<Tab>"] = actions.move_selection_previous,
                ["<S-Tab>"] = actions.move_selection_next,
                ["<C-q>"] = actions.send_to_qflist + actions.open_qflist,
                ["<M-q>"] = actions.send_selected_to_qflist + actions.open_qflist,
                ["<C-l>"] = actions.complete_tag,
                -- ["<C-_>"] = actions.which_key, -- Conflicto con atajo de terminal
            },
            -- Normal mode
            n = {
                -- Navegación entre opciones
                ["j"] = actions.move_selection_next,
                ["k"] = actions.move_selection_previous,
                ["H"] = actions.move_to_top,
                ["M"] = actions.move_to_middle,
                ["L"] = actions.move_to_bottom,
                ["<Down>"] = actions.move_selection_next,
                ["<Up>"] = actions.move_selection_previous,
                ["gg"] = actions.move_to_top,
                ["G"] = actions.move_to_bottom,
                ["<C-u>"] = actions.preview_scrolling_up,
                ["<C-d>"] = actions.preview_scrolling_down,
                ["<PageUp>"] = actions.results_scrolling_up,
                ["<PageDown>"] = actions.results_scrolling_down,
                -- Opciones de selección
                ["<Esc>"] = actions.close,
                ["<CR>"] = actions.select_default,
                ["<C-x>"] = actions.select_horizontal,
                ["<C-v>"] = actions.select_vertical,
                ["<C-t>"] = actions.select_tab,
                -- Otras opciones de mapeo
                -- ["<Tab>"] = actions.toggle_selection + actions.move_selection_worse,
                -- ["<S-Tab>"] = actions.toggle_selection + actions.move_selection_better,
                ["<Tab>"] = actions.move_selection_previous,
                ["<S-Tab>"] = actions.move_selection_next,
                ["<C-q>"] = actions.send_to_qflist + actions.open_qflist,
                ["<M-q>"] = actions.send_selected_to_qflist + actions.open_qflist,
                ["?"] = actions.which_key,
            },
        },
    },
    file_ignore_patterns = {
        ".git/",
        "target/",
        "docs/",
        "vendor/*",
        "%.lock",
        "__pycache__/*",
        "%.sqlite3",
        "%.ipynb",
        "node_modules/*",
        "%.svg",
        "%.otf",
        "%.ttf",
        "%.webp",
        ".dart_tool/",
        ".github/",
        ".gradle/",
        ".idea/",
        ".settings/",
        ".vscode/",
        "__pycache__/",
        "build/",
        "env/",
        "gradle/",
        "node_modules/",
        "%.pdb",
        "%.dll",
        "%.class",
        "%.exe",
        "%.cache",
        "%.ico",
        "%.pdf",
        "%.dylib",
        "%.jar",
        "%.docx",
        "%.met",
        "smalljre_*/*",
        ".vale/",
        "%.burp",
        "%.mp4",
        "%.mkv",
        "%.rar",
        "%.zip",
        "%.7z",
        "%.tar",
        "%.bz2",
        "%.epub",
        "%.flac",
        "%.tar.gz",
    },
    pickers = {},
    extensions = {},
})

-- Configuración para proyectos
telescope.load_extension("projects")
telescope.load_extension("fzf")

-- Keymaps
vim.keymap.set("n", "<Leader>?", builtin.oldfiles, { desc = "[?] Find recently opened files" })
vim.keymap.set("n", "<Leader><Space>", builtin.buffers, { desc = "[ ] Find existing buffers" })
vim.keymap.set("n", "<Leader>/", function()
    builtin.current_buffer_fuzzy_find(themes.get_dropdown({
        winblend = 10,
        previewer = false,
    }))
end, { desc = "[/] Fuzzily search in current buffer" })
vim.keymap.set("n", "<Leader>ff", builtin.find_files, { desc = "[F]ind [F]iles" })
vim.keymap.set("n", "<Leader>fh", builtin.help_tags, { desc = "[F]ind [H]elp" })
vim.keymap.set("n", "<Leader>fw", builtin.grep_string, { desc = "[F]ind current [W]ord" })
vim.keymap.set("n", "<Leader>fg", builtin.live_grep, { desc = "[F]ind by [G]rep" })
vim.keymap.set("n", "<Leader>fd", builtin.diagnostics, { desc = "[F]ind [D]iagnostic" })
