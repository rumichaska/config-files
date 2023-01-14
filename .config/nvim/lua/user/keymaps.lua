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
keymap("n", "<Leader>q", ":bdelete<CR>", opts) -- Cerrar buffer

-- Borrar resaltado de búqueda
keymap("n", "<Leader>nh", ":noh<CR>", opts)

-- Insert --

-- Visual y Visual Block --

-- Indentación continua
keymap("v", "<", "<gv", opts)
keymap("v", ">", ">gv", opts)

-- Mover texto arriba o abajo
keymap("v", "<M-j>", ":move '>+1<CR>gv=gv", opts)
keymap("v", "<M-k>", ":move '<-2<CR>gv=gv", opts)

-- Terminal --

-- Navegación entre buffer y terminal
vim.api.nvim_create_autocmd({ "TermOpen" }, {
    pattern = "term://*",
    callback = function()
        keymap("t", "<Esc>", [[<C-\><C-n>]], term_opts)
        keymap("t", "<C-h>", [[<Cmd>wincmd h<CR>]], term_opts)
        keymap("t", "<C-j>", [[<Cmd>wincmd j<CR>]], term_opts)
        keymap("t", "<C-k>", [[<Cmd>wincmd k<CR>]], term_opts)
        keymap("t", "<C-l>", [[<Cmd>wincmd l<CR>]], term_opts)
    end,
    group = vim.api.nvim_create_augroup("term_keymaps", { clear = true })
})
