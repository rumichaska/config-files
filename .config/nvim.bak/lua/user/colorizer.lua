-- Control de mensaje de errores por falta de colorizer
local status_ok, colorizer = pcall(require, "colorizer")
if not status_ok then
    return
end

-- Configuración de colorizer
colorizer.setup({
    -- Aplicar a todos los tipos de archivos
    "*",
    -- Deshabilitar colorear nombres y activar para funciones rgb() o rgba()
    r = { names = false, rgb_fn = true },
    css = { css = true, css_fn = true },
})
