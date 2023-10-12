local Util = require("util")

-- Keymap function
local function map(mode, lhs, rhs, opts)
    vim.keymap.set(mode, lhs, rhs, opts)
end

-- Better up/down
map({ "n", "x" }, "j", "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })
map({ "n", "x" }, "k", "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })

-- Move to windows (splits) using <ctrl> hjkl keys
map("n", "<C-h>", "<C-w>h", { desc = "Go To Left Window", remap = true })
map("n", "<C-j>", "<C-w>j", { desc = "Go To Lower Window", remap = true })
map("n", "<C-k>", "<C-w>k", { desc = "Go To Upper Window", remap = true })
map("n", "<C-l>", "<C-w>l", { desc = "Go To Right Window", remap = true })

-- Resize windows (splits) using <ctrl> arrow keys
map("n", "<C-Up>", "<cmd>resize +2<CR>", { desc = "Increase Window Height" })
map("n", "<C-Down>", "<cmd>resize -2<CR>", { desc = "Decrease Window Height" })
map("n", "<C-Left>", "<cmd>vertical resize +2<CR>", { desc = "Decrease Window Width" })
map("n", "<C-Right>", "<cmd>vertical resize -2<CR>", { desc = "Increase Window Width" })

-- Move Lines using <alt> jk keys
map("n", "<A-j>", "<cmd>m .+1<CR>==", { desc = "Move Down" })
map("n", "<A-k>", "<cmd>m .-2<CR>==", { desc = "Move Up" })
map("i", "<A-j>", "<Esc><cmd>m .+1<CR>==gi", { desc = "Move Down" })
map("i", "<A-k>", "<Esc><cmd>m .-2<CR>==gi", { desc = "Move Up" })
map("v", "<A-j>", ":m '>+1<CR>gv=gv", { desc = "Move Down" })
map("v", "<A-k>", ":m '<-2<CR>gv=gv", { desc = "Move Up" })

-- Buffer navigation
if Util.has("bufferline.nvim") then
    map("n", "<S-h>", "<cmd>BufferLineCyclePrev<CR>", { desc = "Prev Buffer" })
    map("n", "<S-l>", "<cmd>BufferLineCycleNext<CR>", { desc = "Next Buffer" })
    map("n", "[b", "<cmd>BufferLineCyclePrev<CR>", { desc = "Prev Buffer" })
    map("n", "]b", "<cmd>BufferLineCycleNext<CR>", { desc = "Next Buffer" })
else
    map("n", "<S-h>", "<cmd>bprevious<CR>", { desc = "Prev Buffer" })
    map("n", "<S-l>", "<cmd>bnext<CR>", { desc = "Next Buffer" })
    map("n", "[b", "<cmd>bprevious<CR>", { desc = "Prev Buffer" })
    map("n", "]b", "<cmd>bnext<CR>", { desc = "Next Buffer" })
end
map("n", "<Leader>bb", "<cmd>e #<Cr>", { desc = "Switch To Other Buffer" })
map("n", "<Leader>`", "<cmd>e #<CR>", { desc = "Switch To Other Buffer" })

-- Clear highlight search with <Esc>
map({ "i", "n" }, "<Esc>", "<cmd>noh<CR><Esc>", { desc = "Escape And Clear hlsearch" })

-- Clear search, diff update and redraw
map(
    "n",
    "<Leader>ur",
    "<cmd>nohlsearch<Bar>diffupdate<Bar>normal! <C-L><CR>",
    { desc = "Redraw / clear hlsearch / diff update" }
)

-- Search word under cursor
map({ "n", "x" }, "gw", "*N", { desc = "Search Word Under Cursor" })

-- https://github.com/mhinz/vim-galore#saner-behavior-of-n-and-n
-- n always forward and N always backwards in search with / and ?
map("n", "n", "'Nn'[v:searchforward]", { expr = true, desc = "Next Search Result" })
map("x", "n", "'Nn'[v:searchforward]", { expr = true, desc = "Next Search Result" })
map("o", "n", "'Nn'[v:searchforward]", { expr = true, desc = "Next Search Result" })
map("n", "N", "'nN'[v:searchforward]", { expr = true, desc = "Prev Search Result" })
map("x", "N", "'nN'[v:searchforward]", { expr = true, desc = "Prev Search Result" })
map("o", "N", "'nN'[v:searchforward]", { expr = true, desc = "Prev Search Result" })

-- Add undo break-points
map("i", ",", ",<C-g>u")
map("i", ".", ".<C-g>u")
map("i", ";", ";<C-g>u")

-- Save file
map({ "i", "x", "n", "s" }, "<C-s>", "<cmd>w<CR><Esc>", { desc = "Save File" })

-- Keywordprg
map("n", "<Leader>K", "<cmd>norm! K<CR>", { desc = "Keywordprg" })

-- Better indenting
map("v", "<", "<gv")
map("v", ">", ">gv")

-- lazy
map("n", "<Leader>l", "<cmd>Lazy<CR>", { desc = "Lazy" })

-- New file
map("n", "<Leader>fn", "<cmd>enew<CR>", { desc = "New File" })

map("n", "<Leader>xl", "<cmd>lopen<CR>", { desc = "Location List" })
map("n", "<Leader>xq", "<cmd>copen<CR>", { desc = "Quickfix List" })

-- Quickfix with trouble plugin
if not Util.has("trouble.nvim") then
    map("n", "[q", vim.cmd.cprev, { desc = "Previous Quickfix" })
    map("n", "]q", vim.cmd.cnext, { desc = "Previous Quickfix" })
end

-- Formatting
map({ "n", "v" }, "<leader>cf", function()
    require("plugins.lsp.format").format({ force = true })
end, { desc = "Format" })

-- stylua: ignore start

-- Toggle options
map("n", "<Leader>uf", require("plugins.lsp.format").toggle, { desc = "Toggle Format On Save" })
map("n", "<Leader>us", function() Util.toggle("spell") end, { desc = "Toggle Spelling" })
map("n", "<Leader>uS", function() Util.language() end, { desc = "Changing Spelling Language" })
map("n", "<Leader>uw", function() Util.toggle("wrap") end, { desc = "Toggle Word Wrap" })
map("n", "<Leader>ul", function() Util.toggle_number() end, { desc = "Toggle Line Numbers" })
map("n", "<Leader>ud", Util.toggle_diagnostics, { desc = "Toggle Diagnostics" })
map("n", "<Leader>ut", "<cmd>TSContextToggle<CR>", { desc = "Toggle Treesitter Context" })
local conceallevel = vim.o.conceallevel > 0 and vim.o.conceallevel or 3
map("n", "<Leader>uc", function() Util.toggle("conceallevel", false, { 0, conceallevel }) end,
    { desc = "Toggle Conceal" })
if vim.lsp.inlay_hint then
    map("n", "<Leader>uh", function() vim.lsp.inlay_hint(0, nil) end, { desc = "Toggle Inlay Hints" })
end

-- Lazygit
map("n", "<Leader>gg", function() Util.float_term({ "lazygit" }, { cwd = Util.get_root(), esc_esc = false, ctrl_hjkl = false }) end, { desc = "Lazygit {root dir}" })
map("n", "<Leader>gG", function() Util.float_term({ "lazygit" }, { esc_esc = false, ctrl_hjkl = false }) end, { desc = "Lazygit {cwd}" })

-- Quit
map("n", "<Leader>qq", "<cmd>qa<CR>", { desc = "Quit All" })
map("n", "<Leader>qc", "<cmd>bdelete<CR>", { desc = "Quit Current Buffer" })

-- stylua: ignore end

-- Highlights under cursor
map("n", "<Leader>ui", vim.show_pos, { desc = "Inspect Pos" })

-- Floating terminal
local lazyterm = function() Util.float_term(nil, { cwd = Util.get_root() }) end
map("n", "<Leader>ft", lazyterm, { desc = "Terminal (root dir)" })
map("n", "<Leader>fT", function() Util.float_term() end, { desc = "Terminal (cwd)" })
map("n", "<C-|>", lazyterm, { desc = "Terminal (root dir)" })
-- NOTE: Only works with ANSI keyboard distribution
-- map("n", "<C-/>", lazyterm, { desc = "Terminal (root dir)" })
-- map("n", "<C-_>", lazyterm, { desc = "which_key_ignore" })

-- Terminal Mappings
map("t", "<Esc><Esc>", "<C-\\><C-n>", { desc = "Enter Normal Mode" })
map("t", "<C-h>", "<cmd>wincmd h<CR>", { desc = "Go To Left Window" })
map("t", "<C-j>", "<cmd>wincmd j<CR>", { desc = "Go To Lower Window" })
map("t", "<C-k>", "<cmd>wincmd k<CR>", { desc = "Go To Upper Window" })
map("t", "<C-l>", "<cmd>wincmd l<CR>", { desc = "Go To Right Window" })
map("t", "<C-|>", "<cmd>close<CR>", { desc = "Hide Terminal" })
-- NOTE: Only works with ANSI keyboard distribution
-- map("n", "<C-/>", lazyterm, { desc = "Terminal (root dir)" })
-- map("t", "<C-_>", "<cmd>close<CR>", { desc = "which_key_ignore" })

-- Windows
map("n", "<Leader>ww", "<C-W>p", { desc = "Other Window", remap = true })
map("n", "<Leader>wd", "<C-W>c", { desc = "Delete Window", remap = true })
map("n", "<Leader>w-", "<C-W>s", { desc = "Split Window Below", remap = true })
map("n", "<Leader>w|", "<C-W>v", { desc = "Split Window Right", remap = true })
map("n", "<Leader>-", "<C-W>s", { desc = "Split Window Below", remap = true })
map("n", "<Leader>|", "<C-W>v", { desc = "Split Window Right", remap = true })

-- Tabs
map("n", "<Leader><Tab>l", "<cmd>tablast<CR>", { desc = "Last Tab" })
map("n", "<Leader><Tab>f", "<cmd>tabfirst<CR>", { desc = "First Tab" })
map("n", "<Leader><Tab><Tab>", "<cmd>tabnew<CR>", { desc = "New Tab" })
map("n", "<Leader><Tab>]", "<cmd>tabnext<CR>", { desc = "Next Tab" })
map("n", "<Leader><Tab>d", "<cmd>tabclose<CR>", { desc = "Close Tab" })
map("n", "<Leader><Tab>[", "<cmd>tabprevious<CR>", { desc = "Previous Tab" })
