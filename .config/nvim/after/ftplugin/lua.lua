-- Settings
vim.opt_local.number = true
vim.opt_local.relativenumber = true
vim.opt_local.shiftwidth = 2

-- Keymaps
vim.keymap.set("n", "<Leader><Leader>x", "<Cmd>source %<CR>", { desc = "Source currente file" })
vim.keymap.set("n", "<Leader>x", ":.lua<CR>", { desc = "Execute currente line"})
vim.keymap.set("v", "<Leader>x", ":lua<CR>", { desc = "Execute currente line" })
