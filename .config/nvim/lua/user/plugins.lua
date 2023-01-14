-- Definiendo variable local
local fn = vim.fn
local is_bootstrap = false

-- Instalar 'packer' de forma automática cuando se inicie nueva instalación
local install_path = fn.stdpath "data" .. "/site/pack/packer/start/packer.nvim"
if fn.empty(fn.glob(install_path)) > 0 then
    is_bootstrap = true
    fn.system { "git", "clone", "--depth", "1", "https://github.com/wbthomason/packer.nvim", install_path, }
    vim.cmd [[packadd packer.vim]]
end

-- Autocommand que actualiza plugins cada vez que se guarda el archivo plugins.lua
local packer_au = vim.api.nvim_create_augroup("paker_au", {
    clear = true
})
vim.api.nvim_create_autocmd({ "BufWritePost" }, {
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

    -- PLUGINS GENERALES
    -- Manejo de packer con packer
    use("wbthomason/packer.nvim")
    -- Popup API de vim en neovim (revisar)
    use("nvim-lua/popup.nvim")
    -- Autocompletado de ', ", (, [, ,{ , etc.
    use("windwp/nvim-autopairs")
    -- Ićonos
    use("kyazdani42/nvim-web-devicons")

    -- LSP
    -- Configuración por LSP
    use({
        "neovim/nvim-lspconfig",
        -- Complementos
        requires = {
            -- Manejo e instalación de LSP
            "williamboman/mason.nvim",
            "williamboman/mason-lspconfig.nvim",
            -- Formato, bugs y linters
            "mfussenegger/nvim-dap",
            "jose-elias-alvarez/null-ls.nvim",
            -- Actualización de estado
            "j-hui/fidget.nvim",
            -- Desarrollo con Lua
            "folke/neodev.nvim",
        },
    })

    -- CMP
    -- Para autocompletado según lenguaje
    use({
        "hrsh7th/nvim-cmp",
        -- Complementos
        requires = {
            -- Extensiones
            "hrsh7th/cmp-nvim-lsp",
            "hrsh7th/cmp-buffer",
            "hrsh7th/cmp-path",
            "hrsh7th/cmp-cmdline",
            "hrsh7th/cmp-nvim-lua",
            -- snippets
            "saadparwaiz1/cmp_luasnip",
            "L3MON4D3/LuaSnip",
            "rafamadriz/friendly-snippets",
        },
    })

    -- TREESITTER
    -- Para sintax highlight según lenguaje
    use({
        "nvim-treesitter/nvim-treesitter",
        -- Actualización constante
        run = function()
            pcall(require("nvim-treesitter.install").update({ with_sync = true }))
        end,
    })
    -- Complemento para navegación con treesitter
    use({
        "nvim-treesitter/nvim-treesitter-textobjects",
        after = "nvim-treesitter",
    })
    -- Colores para corchetes, llaves, paréntesis, etc.
    use("p00f/nvim-ts-rainbow")

    -- TELESCOPE
    -- Para búsqueda de archivos, texto, código, etc.
    use({
        "nvim-telescope/telescope.nvim",
        branch = "0.1.x",
        requires = { "nvim-lua/plenary.nvim" }
    })
    -- Complemento para uso de fzf cuando haya disponible make en SO
    use({
        "nvim-telescope/telescope-fzf-native.nvim",
        run = "make",
        -- cond = vim.fn.executable "make" == 1,
    })

    -- COLORSCHEME Y COLORES
    -- Temas de neovim
    use("folke/tokyonight.nvim")
    -- Mostrar colores en código
    use("norcalli/nvim-colorizer.lua")

    -- BUFFERLINE
    -- Mostrar barra de estado de buffers activos
    use({
        "akinsho/bufferline.nvim",
        -- Versión estable
        tag = "v3.*",
    })

    -- LUALINE
    -- Barra de estado inferior
    use("nvim-lualine/lualine.nvim")

    -- NVIMTREE
    -- Exploración y navegación de archivos
    use("kyazdani42/nvim-tree.lua")

    -- COMMENTS
    -- Implementación de comentarios según lenguaje
    use("numToStr/Comment.nvim")
    use("JoosepAlviste/nvim-ts-context-commentstring")

    -- GIT
    -- Estado de modificación según git
    use("lewis6991/gitsigns.nvim")

    -- TERMINAL
    -- Abrir terminales
    use({
        "akinsho/toggleterm.nvim",
        -- Versión estable
        tag = "v2.*",
    })
    -- REPL
    use("hkupty/iron.nvim")

    -- INDENT BLANKLINE
    -- Monstrar indentación
    use("lukas-reineke/indent-blankline.nvim")

    -- Automatically set up your configuration after cloning packer.nvim
    -- Put this at the end after all plugins
    if is_bootstrap then
        require("packer").sync()
    end

end)
