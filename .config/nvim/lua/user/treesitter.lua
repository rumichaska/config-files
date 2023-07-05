-- Control de mensaje de errores por falta de treesitter
local status_ok, configs = pcall(require, "nvim-treesitter.configs")
if not status_ok then
    return
end
--
-- Parsers con soporte
local ts_parser = {
    -- "bash",
    "comment",
    "css",
    "html",
    "lua",
    "make",
    "markdown",
    "markdown_inline",
    "python",
    "r",
    "scss",
    "yaml",
}

-- Configuración de treesitter
configs.setup({
    -- Configuración de treesitter, modificar según lenguajes
    ensure_installed = ts_parser, -- Solo instalar lenguajes con soporte
    sync_install = false,         -- Sincronización solo lenguajes con soporte
    ignore_install = {},          -- Lista de `parsers` a ignorar en instalación
    highlight = {
        enable = true,            -- `false` deshabilitará la extensión
    },
    indent = {
        enable = true,
    },
    incremental_selection = {
        enable = true,
        keymaps = {
            init_selection = "<c-space>",
            node_incremental = "<c-space>",
            scope_incremental = "<c-s>",
            node_decremental = "<c-backspace>",
        },
    },
    textobjects = {
        select = {
            enable = true,
            lookahead = true,
            keymaps = {
                ["af"] = "@function.outer",
                ["if"] = "@function.inner",
                ["ac"] = "@class.outer",
                ["ic"] = { query = "@class.inner", desc = "Select inner part of a class region" },
                ["as"] = { query = "@scope", query_group = "locals", desc = "Select language scope" },
            },
            selection_modes = {
                ['@parameter.outer'] = 'v', -- charwise
                ['@function.outer'] = 'V',  -- linewise
                ['@class.outer'] = '<c-v>', -- blockwise
            },
            include_surrounding_whitespace = true,
        },
        move = {
            enable = true,
            set_jumps = true, -- whether to set jumps in the jumplist
            goto_next_start = {
                ["]m"] = "@function.outer",
                ["]]"] = { query = "@class.outer", desc = "Next class start" },
                ["]o"] = "@loop.*",
                ["]s"] = { query = "@scope", query_group = "locals", desc = "Next scope" },
                ["]z"] = { query = "@fold", query_group = "folds", desc = "Next fold" },
            },
            goto_next_end = {
                ["]M"] = "@function.outer",
                ["]["] = "@class.outer",
            },
            goto_previous_start = {
                ["[m"] = "@function.outer",
                ["[["] = "@class.outer",
            },
            goto_previous_end = {
                ["[M"] = "@function.outer",
                ["[]"] = "@class.outer",
            },
            goto_next = {
                ["]d"] = "@conditional.outer",
            },
            goto_previous = {
                ["[d"] = "@conditional.outer",
            }
        },
    },
    -- Agregando configuración para comentarios según lenguajes
    context_commentstring = {
        enable = true,
        enable_autocmd = false,
    },
})
