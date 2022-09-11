-- Control de mensaje de errores por falta de comment
local status_ok, comment = pcall(require, "Comment")
if not status_ok then
    return
end

-- Configuración de comment
comment.setup({
    -- Función para comentarios según lenguaje
    pre_hook = function(ctx)
        local U = require("Comment.utils")
        local key = ctx.ctype == U.ctype.linewise and "__default" or "__multiline"
        local location = nil
        if ctx.ctype == U.ctype.blockwise then
            location = require("ts_context_commentstring.utils").get_cursor_location()
        elseif ctx.cmotion == U.cmotion.v or ctx.cmotion == U.cmotion.V then
            location = require("ts_context_commentstring.utils").get_visual_start_location()
        end
        return require("ts_context_commentstring.internal").calculate_commentstring {
            key = key,
            location = location,
        }
    end,
})
