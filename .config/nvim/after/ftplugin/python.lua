-- Local options
vim.opt_local.colorcolumn = "80"

-- Functions and variables
local function map(mode, lhs, rhs, desc)
    vim.keymap.set(mode, lhs, rhs, { silent = true, buffer = 0, desc = desc })
end

local function augroup(name)
    return vim.api.nvim_create_augroup("Python_" .. name, { clear = true })
end

local source = vim.fn.expand("%:p:.")

-- Commands shortcuts and console
map("n", "<LocalLeader>ts", ":!python3 " .. source .. "<CR>", "Python: Source Current File")
map("n", "<LocalLeader>tr", "<cmd>IronRepl<CR>", "Python: Open/Hide ipython Console")

-- Autocmds
vim.api.nvim_create_autocmd("TermOpen", {
    group = augroup("ipython"),
    callback = function(event)
        if vim.bo[event.buf].filetype ~= "lazyterm" then
            map("n", "<LocalLeader>tr", "<cmd>IronHide python<CR>", "Python: Hide ipython")
            -- set filetype as "ironterm"
            vim.opt_local.filetype = "ironterm"
        end
    end,
})
