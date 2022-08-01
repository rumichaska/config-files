-- Definiendo variable local
local fn = vim.fn

-- Instalar 'packer' de forma automática cuando se inicie nueva instalación
local install_path = fn.stdpath "data" .. "/site/pack/packer/start/packer.nvim"
if fn.empty(fn.glob(install_path)) > 0 then
    PACKER_BOOTSTRAP = fn.system {
        "git",
        "clone",
        "--depth",
        "1",
        "https://github.com/wbthomason/packer.nvim",
        install_path,
    }
    print "Installing packer close and reopen Neovim..."
    vim.cmd [[packadd packer.nvim]]
end

-- Autocommand que recarga neovim cada vez que se guarda el archivo plugins.lua
local packer_au = vim.api.nvim_create_augroup("paker_au", {
    clear = true
})
vim.api.nvim_create_autocmd("BufWritePost", {
    pattern = "plugins.lua",
    command = "source <afile> | PackerSync",
    group = packer_au,
})

-- Control de mensaje de errores por primer uso de packer
local status_ok, packer = pcall(require, "packer")
if not status_ok then
    return
end

-- Uso de 'packer' en ventana
packer.init({
    display = {
        open_fn = function()
            return require("packer.util").float({ border = "rounded" })
        end,
    },
})

-- Installar plugins
return packer.startup(function(use)

    -- Plugins generales
    use("wbthomason/packer.nvim")                -- Hace que `packer` se maneje así mismo
    use("nvim-lua/popup.nvim")                   -- Implementación del Popup API de vim en neovim
    use("nvim-lua/plenary.nvim")                 -- Diversas funciones lua usadas por otros plugins
    use("windwp/nvim-autopairs")                 -- Autopairs, se puede integrar con cmp y treesitter
    use("kyazdani42/nvim-web-devicons")          -- Iconos, se puede integrar con nvim-tree, lualine, ...

    -- Colorscheme y colores
    use("shaunsingh/nord.nvim")                  -- Tema nord
    use("ful1e5/onedark.nvim")                   -- Tema onedark
    use("folke/tokyonight.nvim")                 -- Tema tokyonight
    use("sainnhe/gruvbox-material")              -- Tema gruvbox
    use("norcalli/nvim-colorizer.lua")           -- Sombreado de colores

    -- Bufferline
    use({
        "akinsho/bufferline.nvim",               -- Bufferline, barra de estado de buffers activos
        tag = "v2.*",                            -- Versión estable
    })

    -- Lualine
    use("nvim-lualine/lualine.nvim")             -- Lualine, barra de estado inferior

    -- Nvim tree
    use("kyazdani42/nvim-tree.lua")              -- Nvim tree, explorador de archivos

    -- Autocompletado cmp
    use("hrsh7th/nvim-cmp")                      -- Plugin de autocompletado
    use("hrsh7th/cmp-nvim-lsp")                  -- Extensiones cmp - lsp
    use("hrsh7th/cmp-buffer")                    -- Extensiones cmp - buffer
    use("hrsh7th/cmp-path")                      -- Extensiones cmp - path
    use("hrsh7th/cmp-cmdline")                   -- Extensiones cmp - cmdline

    -- Lua snippets
    use("L3MON4D3/LuaSnip")                      -- Motor para snippets (luasnip engine)
    use("saadparwaiz1/cmp_luasnip")              -- Extensiones cmp - luasnip engine
    use("rafamadriz/friendly-snippets")          -- Snippets para varios lenguajes

    -- LSP
    use("neovim/nvim-lspconfig")                 -- Activar LSP
    use("williamboman/nvim-lsp-installer")       -- Language server installer

    -- TreeSitter
    use({
        "nvim-treesitter/nvim-treesitter",       -- TreeSitter, resaltador de sintaxis
        run = ":TSUpdate",                       -- Actualización automática de lenguajes
    })
    use("p00f/nvim-ts-rainbow")                  -- Colores para corchetes|parentesis

    -- Comments
    use("numToStr/Comment.nvim")                         -- Para comentar código
    use("JoosepAlviste/nvim-ts-context-commentstring")   -- Comentarios en función a lenguaje

    -- Telescope
    use("nvim-telescope/telescope.nvim")         -- Telescope, buscador de archivos

    -- Git
    use("lewis6991/gitsigns.nvim")               -- Git, control de versiones junto a número de línea

    -- Proyectos
    use("ahmedkhalf/project.nvim")               -- Manejo de proyectos

    -- Toggleterm
    use({
        "akinsho/toggleterm.nvim",               -- Manejo de Terminales y consolas
        tag = "v2.*",                            -- Versión estable
    })

    -- Indent blankline
    use("lukas-reineke/indent-blankline.nvim")   -- indent-blankline, para mostrar indentación

    -- Automatically set up your configuration after cloning packer.nvim
    -- Put this at the end after all plugins
    if PACKER_BOOTSTRAP then
        require("packer").sync()
    end

end)
