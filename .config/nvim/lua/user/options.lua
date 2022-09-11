-- Definiendo opciones de Neovim

-- Generales
vim.opt.backup = false                             -- Crea archivo de respaldo
vim.opt.clipboard = "unnamedplus"                  -- Permite a nvim acceder al portapapeles
vim.opt.cmdheight = 2                              -- Altura de la linea de comandos
vim.opt.completeopt = { "menuone", "noselect" }    -- Opciones relacionadas al menú de autocompletado cmp
vim.opt.colorcolumn = "80"                         -- Marcador de columna
vim.opt.conceallevel = 0                           -- ``` visible en archivos markdown
vim.opt.encoding = "utf-8"                         -- Encoding para caracteres especiales
vim.opt.errorbells = false                         -- Deshabilitar sonido de la campana
vim.opt.fileencoding = "utf-8"                     -- Encoding usado para los archivos
vim.opt.laststatus = 3                             -- Global statusline
vim.opt.mouse = "a"                                -- Permite la integración del mouse (seleccionar texto, mover cursor)
vim.opt.showmode = false                           -- No mostrar modo actual
vim.opt.signcolumn = "yes"                         -- Mostrar columna de diagnóstico
vim.opt.spelllang = { "es", "en" }                 -- Idioma de entrada
vim.opt.shortmess:append("c")                      -- Control de cantidad de mensajes de alarma
vim.opt.swapfile = false                           -- Crea archivo swap
vim.opt.title = false                              -- Mostar el nombre del archivo en ventana del terminal

-- List chars
vim.opt.list = true -- Opciones de `list`
vim.opt.listchars = {
    eol = "↴",                                     -- Simbología de CR al final de la línea
    space = "⋅",                                   -- Simbología de "⋅" para representar espacios
    tab = "  ",                                    -- Alternativa : "▷▷",
    extends = "›",                                 -- Alternativa : … »
    precedes = "‹",                                -- Alternativa : … «
    trail = "•",                                   -- BULLET (U+2022, UTF-8: E2 80 A2)
}

-- Tiempos
vim.opt.updatetime = 300                            -- akinso settings.lua
vim.opt.timeout = true                              -- akinso settings.lua
vim.opt.timeoutlen = 500                            -- akinso settings.lua
vim.opt.ttimeoutlen = 10                            -- akinso settings.lua

-- Temas, colores y fuentes
vim.opt.background = "dark"                        -- Fondo oscuro
vim.opt.guifont = "JetBrainsMono :h12"             -- Fuente por defecto en Neovim
vim.opt.termguicolors = true                       -- Activa `true colors` de la terminal

-- Ventanas y buffers
vim.opt.splitbelow = true                          -- Forzar ventanas horizontales hacia abajo
vim.opt.splitright = true                          -- Forzar ventanas verticales hacia la derecha

-- Terminal
vim.opt.hidden = true                              -- Para manejo de terminales con toggleterm plugin

-- Líneas
vim.opt.cursorline = true                          -- Resalta la línea actual
vim.opt.number = true                              -- Muestra el número de línea
vim.opt.numberwidth = 4                            -- Ancho de columna de numeración
vim.opt.relativenumber = true                      -- Muestra numeración relativa
vim.opt.scrolloff = 8                              -- Margen hacia parte superior e inferior cuando se navega por ventana
vim.opt.sidescrolloff = 10                         -- Margen hacia lados de las ventanas cuando se navega por ventana

-- Búsqueda
vim.opt.hlsearch = true                            -- Resalta búsqueda
vim.opt.ignorecase = true                          -- Ignorar mayúsculas al hacer una búsqueda
vim.opt.incsearch = true                           -- Búsqueda incremental
vim.opt.smartcase = true                           -- No ignorar mayúsculas si la palabra a buscar contiene mayúsculas

-- Tabs e indentación
vim.opt.autoindent = true                          -- Activar autoindentación1
vim.opt.cindent = true                             -- Indentación tipo c, si no gusta puede cambiar a 'smartindent = true'
vim.opt.breakindent = true                         -- Continuar con identación de texto cuando 'wrap = true'
vim.opt.linebreak = true                           -- Corte de 'wrap' en palabras y no letras
--[[ vim.opt.showbreak = string.rep(" ", 3)             -- Líneas largas usen 'wrap' inteligente (NOTE: Probar) ]]
--[[ vim.opt.smartindent = true                         -- Activar autoindentación ]]
vim.opt.textwidth = 80                             -- Ancho de texto
vim.opt.wrap = false                               -- No wrap

-- Indentación
vim.opt.expandtab = true                           -- Insertar espacios en lugar de <Tab>s
vim.opt.tabstop = 4                                -- Tamaño de la indentación de 4 <Tabs>s
vim.opt.softtabstop = 4                            --
--[[ vim.opt.shiftround = true                          -- Indentación `<>` multiplo de `shiftwidth` ]]
vim.opt.shiftwidth = 4                             -- Tamaño de la autoindentación

-- Menú de autocompletado
vim.opt.pumblend = 3                               -- Nivel de transparencia del menú
vim.opt.pumheight = 10                             -- Altura del menú
vim.opt.wildmode = "longest:full,full"             -- Listado de opciones en línea de comandos
vim.opt.wildoptions = "pum"                        -- Tipo de menú

-- Opciones de formato
vim.opt.formatoptions = {
    t = false,                                     -- Auto-wrap texto usando 'textwidth'
    c = true,                                      -- Auto-wrap comentarios usando 'textwidth'
    r = true,                                      -- Continuar comentarios cuando se presiona 'Enter <CR>'
    o = false,                                     -- Pero no cuando se agrega un línea con 'o' y 'O'
    q = true,                                      -- Formatear comentarios con 'gq'
    a = false,                                     -- No ejecutar autoformato
    j = true,                                      -- Auto-remove comentarios si es posible
    n = true,                                      -- Indentacion después de 'formatlistpat'
    ['2'] = false,                                 -- No indentar después de la segunda línea del párrafo
}

