-- Definiendo variables locales para el mapeo
local opts = { noremap = true, silent = true }
local keymap = vim.keymap.set
-- local term_opts = { silent = true } -- Desactivar para usar toggleterm

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
keymap("n", "<Leader>1", ":BufferLineGoToBuffer 1<CR>", opts)
keymap("n", "<Leader>2", ":BufferLineGoToBuffer 2<CR>", opts)
keymap("n", "<Leader>3", ":BufferLineGoToBuffer 3<CR>", opts)
keymap("n", "<Leader>4", ":BufferLineGoToBuffer 4<CR>", opts)
keymap("n", "<Leader>5", ":BufferLineGoToBuffer 5<CR>", opts)
keymap("n", "<Leader>6", ":BufferLineGoToBuffer 6<CR>", opts)
keymap("n", "<Leader>7", ":BufferLineGoToBuffer 7<CR>", opts)
keymap("n", "<Leader>8", ":BufferLineGoToBuffer 8<CR>", opts)
keymap("n", "<Leader>9", ":BufferLineGoToBuffer 9<CR>", opts)

-- Nvimtree
keymap("n", "<Leader>e", ":NvimTreeToggle<CR>", opts)

-- Telescope y búsqueda
keymap("n", "<Leader>ff", ":Telescope find_files<CR>", opts)
keymap("n", "<Leader>fg", ":Telescope live_grep<CR>", opts)
keymap("n", "<Leader>fb", ":Telescope buffers<CR>", opts)
keymap("n", "<Leader>ft", ":Telescope help_tags<CR>", opts)
keymap("n", "<Leader>nh", ":noh<CR>", opts) -- Borrar resaltado de búqueda

-- Insert --

-- R language
local r_keymap = vim.api.nvim_create_augroup("r_keymap", { clear = true })
vim.api.nvim_create_autocmd("FileType", {
    pattern = { "r" , "rmd" },
    callback = function()
        keymap("i", "<M-M>", "<Esc>:normal! a %>%<CR>a ", opts)
        keymap("i", "<M-I>", "<Esc>:normal! a %in%<CR>a ", opts)
        keymap("i", "<M-->", "<Esc>:normal! a <-<CR>a ", opts)
    end,
    group = r_keymap
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

-- Lanzar consola de R
keymap("n", "<Leader>tr", ":lua _R_TOGGLE()<CR>", opts)

-- Python 3

-- Lanzar consola de Python
keymap("n", "<Leader>tp", ":lua _PYTHON_TOGGLE()<CR>", opts)

-- Visual --

-- Indentación continua
keymap("v", "<", "<gv", opts)
keymap("v", ">", ">gv", opts)

-- Mover texto arriba o abajo
keymap("v", "<M-j>", ":move '>+1<CR>gv=gv", opts)
keymap("v", "<M-k>", ":move '<-2<CR>gv=gv", opts)

-- Visual Block --

-- Mover bloque de texto arriba o abajo
keymap("x", "<M-j>", ":move '>+1<CR>gv=gv", opts)
keymap("x", "<M-k>", ":move '<-2<CR>gv=gv", opts)

-- Terminal --

-- Navegación desde terminal hacia ventanas (splits) -- Desactivar para usar toggleterm
-- keymap("t", "<C-h>", "<C-\\><C-N><C-w>h", term_opts)
-- keymap("t", "<C-j>", "<C-\\><C-N><C-w>j", term_opts)
-- keymap("t", "<C-k>", "<C-\\><C-N><C-w>k", term_opts)
-- keymap("t", "<C-l>", "<C-\\><C-N><C-w>l", term_opts)
-- keymap("t", "<Esc>", "<C-\\><C-N>", term_opts)

