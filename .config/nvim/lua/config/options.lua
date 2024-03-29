-- Mapleader
vim.g.mapleader = " "
vim.g.maplocalleader = ","

-- Nvim options
local opt = vim.opt

opt.autowrite = true -- Enable auto write
opt.breakindent = true
opt.clipboard = "unnamedplus" -- Sync with system clipboard
opt.completeopt = "menu,menuone,noselect"
-- opt.colorcolumn = "80" -- Column highlight (ftplugin/)
opt.conceallevel = 3 -- Hide * markup for bold and italic
opt.confirm = true -- Confirm to save changes before exiting modified buffer
opt.cursorline = true -- Enable highlighting of the current line
opt.expandtab = true -- Use spaces instead of tabs
-- opt.formatoptions = "jcrqln" (config.autocmds)
opt.grepformat = "%f:%l:%c:%m"
opt.grepprg = "rg --vimgrep"
opt.ignorecase = true -- Ignore case
opt.inccommand = "nosplit" -- preview incremental substitute
opt.laststatus = 0
opt.linebreak = true
opt.list = true -- Show some invisible characters (tabs...
opt.listchars = {
    eol = "↴",
    -- space = "⋅",
    tab = "  ",
    trail = "•",
}
opt.mouse = "a" -- Enable mouse mode
opt.number = true -- Print line number
-- opt.pumblend = 10 -- Popup blend (render problems NerdFont symbols)
opt.pumheight = 10 -- Maximum number of entries in a popup
opt.relativenumber = true -- Relative line numbers
opt.scrolloff = 4 -- Lines of context
opt.sessionoptions = { "buffers", "curdir", "tabpages", "winsize" }
opt.shiftround = true -- Round indent
opt.shiftwidth = 4 -- Size of an indent
opt.shortmess:append({ W = true, I = true, c = true, C = true })
opt.showmode = false -- Don't show mode since we have a statusline
opt.sidescrolloff = 8 -- Columns of context
opt.signcolumn = "yes" -- Always show the signcolumn, otherwise it would shift the text each time
opt.smartcase = true -- Don't ignore case with capitals
opt.smartindent = true -- Insert indents automatically
opt.spelllang = "en"
opt.splitbelow = true -- Put new windows below current
opt.splitright = true -- Put new windows right of current
opt.tabstop = 4 -- Number of spaces tabs count for
opt.termguicolors = true -- True color support
opt.timeoutlen = 300
opt.undofile = true
opt.undolevels = 10000
opt.updatetime = 200 -- Save swap file and trigger CursorHold
opt.wildmode = "longest:full,full" -- Command-line completion mode
opt.winminwidth = 5 -- Minimum window width
opt.wrap = false -- Disable line wrap
opt.fillchars = {
    foldopen = "",
    foldclose = "",
    -- fold = "⸱",
    fold = " ",
    foldsep = " ",
    diff = "╱",
    eob = " ",
}

if vim.fn.has("nvim-0.10") == 1 then
    opt.smoothscroll = true
end

-- Folding
opt.foldlevel = 99
opt.foldtext = "v:lua.require'util.ui'.foldtext()"

if vim.fn.has("nvim-0.9.0") == 1 then
    opt.statuscolumn = [[%!v:lua.require'util.ui'.statuscolumn()]]
end

if vim.fn.has("nvim-0.10") == 1 then
    opt.foldmethod = "expr"
    opt.foldexpr = "v:lua.vim.treesitter.foldexpr()"
else
    opt.foldmethod = "indent"
end

-- Fix markdown indentation settings
vim.g.markdown_recommended_style = 0
