-- Definiendo variables locales para el mapeo
local opts = { noremap = true, silent = true }
local term_opts = { noremap = true } -- Desactivar para usar toggleterm
local keymap = vim.keymap.set

-- Usar <Space> como tecla `leader`
keymap("", "<Space>", "<Nop>", opts) -- Quitar el mapeo asignado a espacio
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Modos
--   normal_mode = "n",
--   insert_mode = "i",
--   visual_mode = "v",
--   visual_block_mode = "x",
--   term_mode = "t",
--   command_mode = "c",

-- Normal --

-- Navegación entre ventanas (splits)
keymap("n", "<C-h>", "<C-w>h", opts)
keymap("n", "<C-j>", "<C-w>j", opts)
keymap("n", "<C-k>", "<C-w>k", opts)
keymap("n", "<C-l>", "<C-w>l", opts)

-- Cambio de tamaño de ventanas
keymap("n", "<C-Up>", ":resize +2<CR>", opts)
keymap("n", "<C-Down>", ":resize -2<CR>", opts)
keymap("n", "<C-Right>", ":vertical resize +2<CR>", opts)
keymap("n", "<C-Left>", ":vertical resize -2<CR>", opts)

-- Navegación entre buffers
keymap("n", "<Leader>k", ":bnext<CR>", opts)
keymap("n", "<Leader>j", ":bprevious<CR>", opts)

-- Nvimtree
keymap("n", "<Leader>e", ":NvimTreeToggle<CR>", opts)

-- Telescope y búsqueda
keymap("n", "<Leader>ff", ":Telescope find_files<CR>", opts)
keymap("n", "<Leader>fg", ":Telescope live_grep<CR>", opts)
keymap("n", "<Leader>fb", ":Telescope buffers<CR>", opts)
keymap("n", "<Leader>ft", ":Telescope help_tags<CR>", opts)
keymap("n", "<Leader>nh", ":noh<CR>", opts) -- Borrar resaltado de búqueda

-- Insert --

-- Visual y Visual Block --

-- Indentación continua
keymap("v", "<", "<gv", opts)
keymap("v", ">", ">gv", opts)

-- Mover texto arriba o abajo
keymap("v", "<M-j>", ":move '>+1<CR>gv=gv", opts)
keymap("v", "<M-k>", ":move '<-2<CR>gv=gv", opts)

-- Terminal --

-- toggleterm
local toggleterm_au = vim.api.nvim_create_augroup("toggleterm_au", {
    clear = true
})

vim.api.nvim_create_autocmd("TermOpen", {
    pattern = "term://*",
    callback = function()
        keymap("t", "<Esc>", [[<C-\><C-n>]], term_opts)
        keymap("t", "<C-h>", [[<C-\><C-n><C-W>h]], term_opts)
        keymap("t", "<C-j>", [[<C-\><C-n><C-W>j]], term_opts)
        keymap("t", "<C-k>", [[<C-\><C-n><C-W>k]], term_opts)
        keymap("t", "<C-l>", [[<C-\><C-n><C-W>l]], term_opts)
    end,
    group = toggleterm_au
})

-- Mapeos personalizados de lenguajes de programación

-- R language

-- Lanzar consola de R
keymap("n", "<Leader>tr", ":lua _R_TOGGLE()<CR>", opts)

-- Función para el autogroup personalizado de R
local r_au = vim.api.nvim_create_augroup("r_au", {
    clear = true
})

-- Keymaps personalizados de R
vim.api.nvim_create_autocmd("FileType", {
    pattern = { "r", "rmd" },
    callback = function()
        -- Atajos para operadores de R %>% %in% <-
        keymap("i", "<M-M>", "<Esc>:normal! a %>%<CR>a ", opts)
        keymap("i", "<M-I>", "<Esc>:normal! a %in%<CR>a ", opts)
        keymap("i", "<M-->", "<Esc>:normal! a <-<CR>a ", opts)
        -- Enviar código a consola, similar a Ctrl+Enter
        keymap("n", "<Leader>l", ":ToggleTermSendCurrentLine 10<CR>j0")
        keymap("v", "<Leader>l", ":ToggleTermSendVisualLines 10<CR>}")
        keymap("v", "<Leader>l", ":ToggleTermSendVisualSelection 10<CR>}")
        -- Enviar .R a consola, similar a Ctrl+Shift+S
        keymap("n", "<Leader>L", ":10TermExec cmd='source(\"%\")'<CR>")
        -- Enviar .Rmd a consola, similar a Ctrl+Shift+K
        keymap("n", "<Leader>K", ":10TermExec cmd='rmarkdown::render(\"%\")'<CR>")
        -- Comentario de sección tipo RStudio Ctrl+Shift+R
        keymap("n", "gch", "73i-<Esc>0:normal gcc<CR>2l<S-R>", opts)
    end,
    group = r_au
})

-- vim.cmd [[
--     augroup r_setup
--         autocmd!
--         autocmd FileType r,rmd inoremap <buffer> <M-M> <Esc>:normal! a %>%<CR>a
--         autocmd FileType r,rmd inoremap <buffer> <M-I> <Esc>:normal! a %in%<CR>a
--         autocmd FileType r,rmd inoremap <buffer> <M--> <Esc>:normal! a <-<CR>a
--         autocmd FileType rmd set completefunc=pandoc#completion#Complete
--     augroup END
-- ]]

-- Python 3

-- Lanzar consola de Python
keymap("n", "<Leader>tp", ":lua _PYTHON_TOGGLE()<CR>", opts)

