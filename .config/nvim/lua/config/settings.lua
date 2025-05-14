-- Setting leader key
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- General
vim.opt.undofile = true              -- Enable persistent undo (see also `:h undodir`)

vim.opt.backup = false               -- Don't store backup while overwriting the file
vim.opt.writebackup = false          -- Don't store backup while overwriting the file

vim.opt.mouse = "a"                  -- Enable mouse for all available modes

vim.cmd("filetype plugin indent on") -- Enable all filetype plugins

-- Appearance
-- vim.o.background = ""       -- Setting for 'kanagawa.nvim' theme
vim.opt.laststatus = 3        -- Setting with 'incline.nvim'

vim.opt.breakindent = true    -- Indent wrapped lines to match line start
vim.opt.cursorline = true     -- Highlight current line
vim.opt.linebreak = true      -- Wrap long lines at 'breakat' (if 'wrap' is set)
vim.opt.number = true         -- Show line numbers
vim.opt.relativenumber = true -- Show relarive numbers
vim.opt.splitbelow = true     -- Horizontal splits will be below
vim.opt.splitright = true     -- Vertical splits will be to the right

vim.opt.ruler = false         -- Don't show cursor position in command line
vim.opt.scrolloff = 10        -- Minimal number of screen lines to keep above and below the cursor
vim.opt.sidescrolloff = 8     -- Minimal number of horizontal columns to keep the cursor sideways
vim.opt.showmode = false      -- Don't show mode in command line
vim.opt.wrap = false          -- Display long lines as just one line

vim.opt.fillchars = "eob: "   -- Don't show `~` outside of buffer
vim.opt.signcolumn = "yes"    -- Always show sign column (otherwise it will shift text)

vim.opt.shortmess:append({
  W = true,
  I = true,
  c = true,
  C = true
})                                     -- Messages
vim.opt.pumheight = 10                 -- Make popup menu smaller
vim.opt.wildmode = "longest:full,full" -- Command-line completion mode

vim.opt.listchars = ({
  tab = "> ",
  trail = "·",
  nbsp = "␣"
})                  -- Define which helper symbols to show
vim.opt.list = true -- Show some helper symbols

if vim.fn.exists("syntax_on") ~= 1 then
  vim.cmd([[syntax enable]])
end -- Enable syntax highlighting if it wasn"t already (as it is time consuming)

-- Editing
vim.opt.expandtab = true     -- Spaces instead of tabs
vim.opt.smartindent = true   -- Make indenting smart

vim.opt.ignorecase = true    -- Ignore case when searching (use `\C` to force not doing that)
vim.opt.incsearch = true     -- Show search results while typing
vim.opt.infercase = true     -- Infer letter cases for a richer built-in keyword completion
vim.opt.smartcase = true     -- Don't ignore case when searching if pattern has upper case
vim.opt.inccommand = "split" -- Preview substitution live

vim.schedule(function()
  vim.opt.clipboard = vim.env.SSH_TTY and "" or "unnamedplus"
end)                                              -- Paste from clipboard if not in SSH
vim.opt.completeopt = "menuone,noinsert,noselect" -- Customize completions
vim.opt.virtualedit = "block"                     -- Allow going past the end of line in visual block mode
vim.opt.formatoptions = "qjl1"                    -- Don't autoformat comments

-- Enable gui colors
if vim.fn.has('nvim-0.10') == 0 then vim.o.termguicolors = true end
