-- Setting leader key
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- General
vim.o.undofile = true     -- Enable persistent undo (see also `:h undodir`)
vim.o.backup = false      -- Don't store backup while overwriting the file
vim.o.writebackup = false -- Don't store backup while overwriting the file

vim.o.mouse = "a"         -- Enable mouse for all available modes

-- Enable all filetype plugins
vim.cmd("filetype plugin indent on")

-- Enable syntax highlighting if it wasn"t already (as it is time consuming)
if vim.fn.exists("syntax_on") ~= 1 then
  vim.cmd("syntax enable")
end

-- Paste from clipboard if not in SSH
vim.schedule(function()
  vim.opt.clipboard = vim.env.SSH_TTY and "" or "unnamedplus"
end)

-- Appearance
vim.o.termguicolors = true  -- Enable gui colors
vim.o.laststatus = 3        -- Setting with 'incline.nvim'

vim.o.breakindent = true    -- Indent wrapped lines to match line start
vim.o.cursorline = true     -- Highlight current line
vim.o.linebreak = true      -- Wrap long lines at 'breakat' (if 'wrap' is set)
vim.o.number = true         -- Show line numbers
vim.o.relativenumber = true -- Show relarive numbers
vim.o.splitbelow = true     -- Horizontal splits will be below
vim.o.splitright = true     -- Vertical splits will be to the right

vim.o.ruler = false         -- Don't show cursor position in command line
vim.o.scrolloff = 10        -- Minimal number of screen lines to keep above and below the cursor
vim.o.sidescrolloff = 8     -- Minimal number of horizontal columns to keep the cursor sideways
vim.o.showmode = false      -- Don't show mode in command line
vim.o.wrap = false          -- Display long lines as just one line

-- UI options
vim.o.winborder = "rounded" -- Floating windows border
vim.o.pumheight = 10        -- Make popup menu smaller
vim.o.signcolumn = "yes"    -- Always show sign column (otherwise it will shift text)
vim.o.fillchars = "eob: "   -- Don't show `~` outside of buffer
vim.o.list = true           -- Show some helper symbols
vim.opt.listchars = {       -- Symbols
  tab = "> ",
  trail = "·",
  nbsp = "␣"
}

vim.opt.shortmess:append("WcC") -- Reduce command line messages

-- Editing
vim.o.expandtab = true                 -- Spaces instead of tabs

vim.o.ignorecase = true                -- Ignore case when searching (use `\C` to force not doing that)
vim.o.incsearch = true                 -- Show search results while typing
vim.o.infercase = true                 -- Infer letter cases for a richer built-in keyword completion
vim.o.smartcase = true                 -- Don't ignore case when searching if pattern has upper case
vim.o.smartindent = true               -- Make indenting smart

vim.o.inccommand = "split"             -- Preview substitution live

vim.o.completeopt = "menuone,noselect" -- Customize completions
vim.o.virtualedit = "block"            -- Allow going past the end of line in visual block mode
vim.o.formatoptions = "qjl1"           -- Don't autoformat comments

vim.opt.spelllang = { "en", "es" }     -- Languages for spellcheking

vim.o.foldmethod = "expr"              -- Fold method
vim.o.foldlevel = 99                   -- Default to all folds open
-- NOTE: foldexpr is managed by treesitter or lsp
