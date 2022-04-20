-- Definiendo opciones de Neovim
local options = {
    -- Generales
    backup = false,                             -- Crea archivo de respaldo
    clipboard = "unnamedplus",                  -- Permite a nvim acceder al portapapeles
    completeopt = { "menuone", "noselect" },    -- Opciones relacionadas al menú de autocompletado cmp
    colorcolumn = "80",                         -- Marcador de columna
    conceallevel = 0,                           -- ``` visible en archivos markdown
    encoding = "utf-8",                         -- Encoding para caracteres especiales
    errorbells = false,                         -- Deshabilitar sonido de la campana
    fileencoding = "utf-8",                     -- Encoding usado para los archivos
    mouse = "a",                                -- Permite la integración del mouse (seleccionar texto, mover cursor)
    pumheight = 10,                             -- Tamaño del menú popup
    showmode = false,                           -- No mostrar modo actual
    signcolumn = "yes",                         -- Mostrar columna de diagnóstico
    spelllang = { "es", "en" },                 -- Idioma de entrada
    updatetime = 50,                            -- Reducir el `updatetime`
    swapfile = false,                           -- Crea archivo swap
    title = false,                              -- Mostar el nombre del archivo en ventana del terminal
    -- Temas, colores y fuentes
    background = "dark",                        -- Fondo oscuro
    guifont = "JetBrainsMono :h12",             -- Fuente por defecto en Neovim
    termguicolors = true,                       -- Activa `true colors` de la terminal
    -- Ventanas
    splitbelow = true,                          -- Forzar ventanas horizontales hacia abajo
    splitright = true,                          -- Forzar ventanas verticales hacia la derecha
    -- Terminal
    hidden = true,                              -- Para manejo de terminales con toggleterm plugin
    -- Líneas
    cursorline = true,                          -- Resalta la línea actual
    number = true,                              -- Muestra el número de línea
    numberwidth = 4,                            -- Ancho de columna de numeración
    relativenumber = true,                      -- Muestra numeración relativa
    scrolloff = 8,                              -- Margen hacia parte superior e inferior cuando se navega por ventana
    sidescrolloff = 10,                         -- Margen hacia lados de las ventanas cuando se navega por ventana
    wrap = false,                               -- No dividir la línea si es muy larga
    -- Búsqueda
    hlsearch = true,                            -- Resalta búsqueda
    ignorecase = true,                          -- Ignorar mayúsculas al hacer una búsqueda
    incsearch = true,                           -- Búsqueda incremental
    smartcase = true,                           -- No ignorar mayúsculas si la palabra a buscar contiene mayúsculas
    -- Indentación
    expandtab = true,                           -- Insertar espacios en lugar de <Tab>s
    tabstop = 4,                                -- Tamaño de la indentación de 4 <Tabs>s
    softtabstop = 4,                            --
    shiftround = true,                          -- Indentación `<>` multiplo de `shiftwidth`
    shiftwidth = 4,                             -- Tamaño de la autoindentación
    smartindent = true,                         -- Activar autoindentación
}

-- Función `for` para asignar las variables a nvim
for k, v in pairs(options) do
    vim.opt[k] = v
end

-- Opciones adicionales
vim.opt.shortmess:append("c")                   -- Control de cantidad de mensajes de alarma
vim.opt.list = true                             -- Opciones de `list`
vim.opt.listchars:append("eol:↴")               -- Simbología de CR al final de la línea
-- vim.opt.listchars:append("space:⋅")             -- Simbología de "⋅" para representar espacios

