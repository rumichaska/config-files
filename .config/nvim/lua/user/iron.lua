-- Control de mensaje de errores por falta de iron.core
local status_ok, iron = pcall(require, "iron.core")
if not status_ok then
    return
end

-- Control de mensaje de errores por falta de iron.view
local view_ok, view = pcall(require, "iron.view")
if not view_ok then
    return
end

-- Modificación local de bracketed_paste para radian
local bracketed_paste_radian = function(lines)
    local open_code = "\27[200~"
    local close_code = "\27[201~"
    local cr = "\13"

    if #lines == 1 then
        return { lines[1] .. cr }
    else
        local new = { open_code .. lines[1] }
        for line = 2, #lines do
            table.insert(new, lines[line])
        end

        table.insert(new, close_code)

        return new
    end
end

-- Configuración de iron
iron.setup({
    config = {
        highlight_last = false,
        scratch_repl = true,
        close_window_on_exit = true,
        repl_definition = {
            r = {
                command = { "radian" },
                format = bracketed_paste_radian,
            },
            rmd = {
                command = { "radian" },
                format = bracketed_paste_radian,
            },
            python = require("iron.fts.python").ipython,
        },
        repl_open_cmd = view.split("30%", {
            number = false,
            relativenumber = false,
        })
    },
    keymaps = {
        -- visual_send = "<Space>l",
        -- send_line = "<Space>l",
        -- clear = "<Space>cl",
        visual_send = "<C-CR>",
        send_line = "<C-CR>",
        clear = "<C>cl",
    },
    ignore_blank_lines = true,
})
