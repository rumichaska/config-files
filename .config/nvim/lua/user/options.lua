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
vim.opt.list = true                                -- Opciones de `list`
vim.opt.listchars:append("eol:↴")                  -- Simbología de CR al final de la línea
vim.opt.listchars:append("space:⋅")                -- Simbología de "⋅" para representar espacios
vim.opt.mouse = "a"                                -- Permite la integración del mouse (seleccionar texto, mover cursor)
vim.opt.pumheight = 10                             -- Tamaño del menú popup
vim.opt.showmode = false                           -- No mostrar modo actual
vim.opt.signcolumn = "yes"                         -- Mostrar columna de diagnóstico
vim.opt.spelllang = { "es", "en" }                 -- Idioma de entrada
vim.opt.updatetime = 50                            -- Reducir el `updatetime`
vim.opt.shortmess:append("c")                      -- Control de cantidad de mensajes de alarma
vim.opt.swapfile = false                           -- Crea archivo swap
vim.opt.title = false                              -- Mostar el nombre del archivo en ventana del terminal

-- Temas, colores y fuentes
vim.opt.background = "dark"                        -- Fondo oscuro
vim.opt.guifont = "JetBrainsMono :h12"             -- Fuente por defecto en Neovim
vim.opt.termguicolors = true                       -- Activa `true colors` de la terminal

-- Ventanas
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
vim.opt.wrap = false                               -- No dividir la línea si es muy larga

-- Búsqueda
vim.opt.hlsearch = true                            -- Resalta búsqueda
vim.opt.ignorecase = true                          -- Ignorar mayúsculas al hacer una búsqueda
vim.opt.incsearch = true                           -- Búsqueda incremental
vim.opt.smartcase = true                           -- No ignorar mayúsculas si la palabra a buscar contiene mayúsculas

-- Indentación
vim.opt.expandtab = true                           -- Insertar espacios en lugar de <Tab>s
vim.opt.tabstop = 4                                -- Tamaño de la indentación de 4 <Tabs>s
vim.opt.softtabstop = 4                            --
vim.opt.shiftround = true                          -- Indentación `<>` multiplo de `shiftwidth`
vim.opt.shiftwidth = 4                             -- Tamaño de la autoindentación
vim.opt.smartindent = true                         -- Activar autoindentación
