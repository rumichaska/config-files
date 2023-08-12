-- Local options
vim.opt_local.colorcolumn = "100"

-- Functions and variables
local function map(mode, lhs, rhs, desc)
    vim.keymap.set(mode, lhs, rhs, { silent = true, buffer = 0, desc = desc })
end

local function augroup(name)
    return vim.api.nvim_create_augroup("R_" .. name, { clear = true })
end

local r = {
    rmd_render = "\"rmarkdown::render('" .. vim.fn.expand("%") .. "')\"",
    source = 'source("' .. vim.fn.expand("%") .. '")',
}

-- Operators (%>% %in% <-)
map("i", "<C-S-m>", "<Esc>:normal! a %>%<CR>a ", "R: 'Pipe' Operator")
map("i", "<C-S-i>", "<Esc>:normal! a %in%<CR>a ", "R: `%in%` Operator")
map("i", "<M-->", "<Esc>:normal! a <-<CR>a ", "R: 'Asign' Operator")

-- Commands shortcuts
map("n", "<LocalLeader>cs", "<cmd>:IronSend " .. r.source .. "<CR>", "R: Source Current File")
map("n", "<LocalLeader>cr", "<cmd>!R -e " .. r.rmd_render .. "<CR>", "R: Render Rmd File")
map("n", "<LocalLeader>cc", "73i-<Esc>0:normal gcc<CR>2l<S-R>", "R: Add Section Comment")

-- Console
map("n", "<LocalLeader>tr", "<cmd>IronRepl<CR>", "Open/Hide R Console")
map("n", "<LocalLeader>tc", "<cmd>IronSend system('clear')<CR>", "Clear Console")

-- Register keys
require("which-key").register({
    ["<LocalLeader>c"] = { name = "+code", buffer = 0 },
    ["<LocalLeader>t"] = { name = "+REPL", buffer = 0 },
})

-- Autocmds
vim.api.nvim_create_autocmd("TermOpen", {
    pattern = "term://*",
    callback = function()
        map("n", "<Leader>tr", ":IronHide r<CR>", "Hide R Console")
        map("t", "<C-S-m>", " %>% ")
        map("t", "<C-S-i>", " %in% ")
        map("t", "<M-->", " <- ")
    end,
    group = augroup("console"),
})

-- NOTE: Dinamic enable/disable diagnostic in R file until LSP fix errors
-- with languagesever v3.15. Provisional fix installing via `remotes::install_github("REditorSupport/languageserver")`
--
-- vim.api.nvim_create_autocmd("BufEnter", {
--     callback = function(event)
--         local filetype = vim.bo[event.buf].filetype == "r"
--         if filetype and not vim.diagnostic.is_disabled() then
--             vim.diagnostic.disable()
--             require("lazy.core.util").info("Disabling diagnostic in current file", { title = "LSP" })
--         else
--             vim.diagnostic.enable()
--         end
--     end,
--     group = augroup("diagnostic"),
-- })
-- vim.api.nvim_create_autocmd("BufWritePost", {
--     callback = function(event)
--         local filetype = vim.bo[event.buf].filetype == "r"
--         if filetype and vim.diagnostic.is_disabled() then
--             vim.diagnostic.enable()
--         end
--     end,
--     group = augroup("enable_when_write"),
-- })
-- vim.api.nvim_create_autocmd("InsertEnter", {
--     callback = function(event)
--         local filetype = vim.bo[event.buf].filetype == "r"
--         if filetype and not vim.diagnostic.is_disabled() then
--             vim.diagnostic.disable()
--         end
--     end,
--     group = augroup("disable_in_insert"),
-- })
