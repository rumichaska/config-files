local Util = require("util")

-- Highlight on search
vim.keymap.set("n", "<Esc>", "<Cmd>nohlsearch<CR>", { desc = "Clear highlights" })

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
vim.keymap.set("n", "<Leader>wt", function() Util.float_term({ name = "term-proj", cwd = Util.get_root() }) end,
  { desc = "Terminal (project root dir)" })
vim.keymap.set("n", "<Leader>wT", function() Util.float_term({ cwd = vim.uv.os_homedir() }) end,
  { desc = "Terminal (home dir)" })

-- Terminal
vim.keymap.set("t", "<Esc><Esc>", "<C-\\><C-n>", { desc = "Exit terminal mode" })
vim.keymap.set("t", "<C-w><C-h>", "<Cmd>wincmd h<CR>", { desc = "Move focus to left window" })
vim.keymap.set("t", "<C-w><C-l>", "<Cmd>wincmd l<CR>", { desc = "Move focus to right window" })
vim.keymap.set("t", "<C-w><C-j>", "<Cmd>wincmd j<CR>", { desc = "Move focus to lower window" })
vim.keymap.set("t", "<C-w><C-k>", "<Cmd>wincmd k<CR>", { desc = "Move focus to upper window" })

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

-- Toggle options
vim.keymap.set("n", "<Leader>ts", "<Cmd>setlocal spell!<CR>", { desc = "Toggle spell" })
vim.keymap.set("n", "<Leader>tw", "<Cmd>setlocal wrap!<CR>", { desc = "Toggle wrap" })
vim.keymap.set("n", "<Leader>tn", "<Cmd>setlocal number! relativenumber!<CR>", { desc = "Toggle number" })
vim.keymap.set("n", "<Leader>td", "<Cmd>lua vim.diagnostic.enable(not vim.diagnostic.is_enabled())<CR>",
  { desc = "Toggle diagnostics" })

-- Lazy
vim.keymap.set("n", "<Leader>l", "<Cmd>Lazy<CR>", { desc = "Lazy" })

-- Mason
vim.keymap.set("n", "<Leader>m", "<Cmd>Mason<CR>", { desc = "Mason" })
