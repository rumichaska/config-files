-- Control de mensaje de errores por falta de null-ls
local null_ls_ok, null_ls = pcall(require, "null-ls")
if not null_ls_ok then
    return
end

-- Configuración de null-ls
null_ls.setup({
    sources = {
        -- Python
        null_ls.builtins.diagnostics.pylint.with({
            diagnostics_postprocess = function(diagnostic)
                diagnostic.code = diagnostic.message_id
            end,
        }),
        null_ls.builtins.formatting.autopep8,
    }
})
