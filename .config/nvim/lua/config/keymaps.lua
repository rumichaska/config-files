local Util = require("util")

-- Toggle options
vim.keymap.set("n", "<Leader>ts", function() Util.toggle("spell") end, { desc = "Options: Toggle spelling" })
vim.keymap.set("n", "<Leader>tS", function() Util.language() end, { desc = "Options: Changing spelling language" })
vim.keymap.set("n", "<Leader>tw", function() Util.toggle("wrap") end, { desc = "Options: Toggle word wrap" })
vim.keymap.set("n", "<Leader>tl", function() Util.toggle_number() end, { desc = "Options: Toggle line numbers" })
vim.keymap.set("n", "<Leader>td", Util.toggle_diagnostics, { desc = "Options: Toggle diagnostics" })
vim.keymap.set("n", "<Leader>tc",
  function()
    local conceallevel = vim.o.conceallevel > 0 and vim.o.conceallevel or 3
    Util.toggle("conceallevel", false, { 0, conceallevel })
  end,
  { desc = "Options: Toggle conceal" })

-- Highlight on search
vim.keymap.set({ "n", "i" }, "<Esc>", "<Cmd>nohlsearch<CR><Esc>", { desc = "Clear highlights" })

-- Make split navigation easier.
vim.keymap.set("n", "<C-h>", "<C-w><C-h>", { desc = "Move focus to the left window" })
vim.keymap.set("n", "<C-l>", "<C-w><C-l>", { desc = "Move focus to the right window" })
vim.keymap.set("n", "<C-j>", "<C-w><C-j>", { desc = "Move focus to the lower window" })
vim.keymap.set("n", "<C-k>", "<C-w><C-k>", { desc = "Move focus to the upper window" })

-- Buffer navigation
vim.keymap.set("n", "<Leader>bb", "<Cmd>e #<Cr>", { desc = "Switch to last buffer" })

-- Resize window using <ctrl> arrow keys
vim.keymap.set("n", "<C-Up>", "<Cmd>resize +2<CR>", { desc = "Increase window height" })
vim.keymap.set("n", "<C-Down>", "<Cmd>resize -2<CR>", { desc = "Decrease window height" })
vim.keymap.set("n", "<C-Left>", "<Cmd>vertical resize -2<CR>", { desc = "Decrease window width" })
vim.keymap.set("n", "<C-Right>", "<Cmd>vertical resize +2<CR>", { desc = "Increase window width" })
vim.keymap.set("n", "<Leader>ur", "<Cmd>wincmd=<Bar>nohlsearch<Bar>diffupdate<Bar>normal! <C-L><CR>",
  { desc = "Redraw / clear hlsearch / diff update" }
)

-- Floating terminal
vim.keymap.set("n", "<Leader>wt", function() Util.float_term(nil, { cwd = Util.get_root() }) end,
  { desc = "Terminal (root dir)" })
vim.keymap.set("n", "<Leader>wT", function() Util.float_term(nil, { cwd = vim.uv.os_homedir() }) end,
  { desc = "Terminal (home dir)" })

-- Terminal
vim.keymap.set("t", "<Esc><Esc>", "<C-\\><C-n>", { desc = "Exit terminal mode" })
vim.keymap.set("t", "<C-h>", "<Cmd>wincmd h<CR>", { desc = "Move focus to left window" })
vim.keymap.set("t", "<C-l>", "<Cmd>wincmd l<CR>", { desc = "Move focus to right window" })
vim.keymap.set("t", "<C-j>", "<Cmd>wincmd j<CR>", { desc = "Move focus to lower window" })
vim.keymap.set("t", "<C-k>", "<Cmd>wincmd k<CR>", { desc = "Move focus to upper window" })

-- Windows
vim.keymap.set("n", "<Leader>wd", "<C-W>c", { desc = "Delete window", remap = true })
vim.keymap.set("n", "<Leader>w-", "<C-W>s", { desc = "Split window below", remap = true })
vim.keymap.set("n", "<Leader>w|", "<C-W>v", { desc = "Split window right", remap = true })

-- Better up/down
vim.keymap.set({ "n", "x" }, "j", "v:count == 0 ? 'gj' : 'j'", { expr = true })
vim.keymap.set({ "n", "x" }, "k", "v:count == 0 ? 'gk' : 'k'", { expr = true })

-- Move Lines using <alt> jk keys
vim.keymap.set("n", "<A-j>", "<Cmd>m .+1<CR>==", { desc = "Move down" })
vim.keymap.set("n", "<A-k>", "<Cmd>m .-2<CR>==", { desc = "Move up" })
vim.keymap.set("i", "<A-j>", "<Esc><Cmd>m .+1<CR>==gi", { desc = "Move down" })
vim.keymap.set("i", "<A-k>", "<Esc><Cmd>m .-2<CR>==gi", { desc = "Move up" })
vim.keymap.set("v", "<A-j>", ":m '>+1<CR>gv=gv", { desc = "Move down" })
vim.keymap.set("v", "<A-k>", ":m '<-2<CR>gv=gv", { desc = "Move up" })

-- n always forward and N always backwards in search with / and ?
vim.keymap.set({ "n", "x", "o" }, "n", "'Nn'[v:searchforward]", { expr = true, desc = "Next search result" })
vim.keymap.set({ "n", "x", "o" }, "N", "'nN'[v:searchforward]", { expr = true, desc = "Prev search result" })

-- Lazy
vim.keymap.set("n", "<Leader>l", "<Cmd>Lazy<CR>", { desc = "Lazy" })

-- Mason
vim.keymap.set("n", "<Leader>m", "<Cmd>Mason<CR>", { desc = "Mason" })
