-- NOTE: Get config from r filetypes
-- alternative to get all the configuration of r.lua into rmd.lua
-- vim.cmd.runtime("ftplugin/r.lua")

-- Local options
vim.opt_local.colorcolumn = "100"

-- Functions and variables
local function map(mode, lhs, rhs, desc)
    vim.keymap.set(mode, lhs, rhs, { silent = true, buffer = 0, desc = desc })
end

local function augroup(name)
    return vim.api.nvim_create_augroup("R_" .. name, { clear = true })
end

local render = "\"rmarkdown::render('" .. vim.fn.expand("%") .. "')\""

-- Operators (%>% %in% <-)
map("i", "<C-S-m>", "<Esc>:normal! a %>%<CR>a ", "R: 'Pipe' Operator")
map("i", "<C-S-i>", "<Esc>:normal! a %in%<CR>a ", "R: `%in%` Operator")
map("i", "<M-->", "<Esc>:normal! a <-<CR>a ", "R: 'Asign' Operator")

-- Commands shortcuts
map("n", "<LocalLeader>cr", "<cmd>!R -e " .. render .. "<CR>", "R: Render Rmd File")
map("n", "<LocalLeader>cc", "73i-<Esc>0:normal gcc<CR>2l<S-R>", "R: Add Section Comment")

-- Console
map("n", "<LocalLeader>tr", "<cmd>IronRepl<CR>", "Open/Hide R Console")
map("n", "<LocalLeader>tc", "<cmd>IronSend system('clear')<CR>", "Clear Console")

-- Register which-key
require("which-key").register({
    ["<LocalLeader>c"] = { name = "+code", buffer = 0 },
    ["<LocalLeader>t"] = { name = "+REPL", buffer = 0 },
})

-- Autocmds
vim.api.nvim_create_autocmd("TermOpen", {
    pattern = "term://*",
    callback = function()
        map("n", "<LocalLeader>tr", ":IronHide r<CR>", "Hide R Console")
        map("t", "<C-S-m>", " %>% ")
        map("t", "<C-S-i>", " %in% ")
        map("t", "<M-->", " <- ")
        -- set filetype for lualine.nvim extension (optional)
        vim.opt_local.filetype = "ironterm"
    end,
    group = augroup("console"),
})

-- Set environment variable for PANDOC
vim.env["RSTUDIO_PANDOC"] = "/usr/lib/rstudio/resources/app/bin/quarto/bin/tools/"
