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
map("i", "<C-S-m>", "<Esc>:normal! a |><CR>a ", "R: 'Base pipe' Operator")
map("i", "<C-S-i>", "<Esc>:normal! a %in%<CR>a ", "R: `%in%` Operator")
map("i", "<M-->", "<Esc>:normal! a <-<CR>a ", "R: 'Asign' Operator")

-- Commands shortcuts
map("n", "<LocalLeader>ts", "<cmd>!R -e " .. render .. "<CR>", "R: Render Rmd File")
map("n", "<LocalLeader>tv", "<cmd>IronSend httpgd::hgd_url()<CR>", "R: Viewer")
map("n", "<LocalLeader>tr", "<cmd>IronRepl<CR>", "R: Open/Hide Console")
map("n", "<LocalLeader>tc", "<cmd>IronSend system('clear')<CR>", "R: Clear Console")

-- Autocmds
vim.api.nvim_create_autocmd("TermOpen", {
    group = augroup("console"),
    callback = function(event)
        if vim.bo[event.buf].filetype ~= "lazyterm" then
            map("n", "<LocalLeader>tr", "<cmd>IronHide r<CR>", "Hide R Console")
            map("t", "<C-S-m>", " |> ")
            map("t", "<C-S-i>", " %in% ")
            map("t", "<M-->", " <- ")
            -- set filetype as "ironterm"
            vim.opt_local.filetype = "ironterm"
        end
    end,
})
