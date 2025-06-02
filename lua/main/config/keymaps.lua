local opts = { noremap = true, silent = true }

-- Map <Space> as the leader key
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-----------------------
-- WINDOW NAVIGATION --
-----------------------
vim.keymap.set("n", "<C-h>", "<C-w>h", opts)
vim.keymap.set("n", "<C-j>", "<C-w>j", opts)
vim.keymap.set("n", "<C-k>", "<C-w>k", opts)
vim.keymap.set("n", "<C-l>", "<C-w>l", opts)

-------------------
-- WINDOW RESIZE --
-------------------
vim.keymap.set("n", "<S-Up>", ":resize +2<CR>", opts)
vim.keymap.set("n", "<S-Down>", ":resize -2<CR>", opts)
vim.keymap.set("n", "<S-Right>", ":vertical resize +2<CR>", opts)
vim.keymap.set("n", "<S-Left>", ":vertical resize -2<CR>", opts)

-----------------------
-- BUFFER NAVIGATION --
-----------------------
vim.keymap.set("n", "<C-L>", ":bnext<CR>", opts)
vim.keymap.set("n", "<C-H>", ":bprevious<CR>", opts)

------------------------
-- VISUAL MODE INDENT --
------------------------
-- Indent and stay in visual mode
vim.keymap.set("v", "<", "<gv", opts)
vim.keymap.set("v", ">", ">gv", opts)
-- Move lines up and down in visual mode
vim.keymap.set({ "x", "v" }, "J", ":move '>+1<CR>gv-gv", opts)
vim.keymap.set({ "x", "v" }, "K", ":move '<-2<CR>gv-gv", opts)

------------
-- SEARCH --
------------
vim.keymap.set("n", "<leader>cs", ":nohl<CR>", opts)

-----------
--- MISC --
-----------
vim.keymap.set("v", "p", [["_dP]], opts)
