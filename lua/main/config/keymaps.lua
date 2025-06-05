local opts = { noremap = true, silent = true }

-- Map <Space> as the leader key
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-----------------------
-- QUICKFIX --
-----------------------
vim.keymap.set("n", "<C-j>", ":cnext<CR>", opts)
vim.keymap.set("n", "<C-k>", ":cprev<CR>", opts)
vim.keymap.set("n", "<leader>j", ":lnext<CR>", opts)
vim.keymap.set("n", "<leader>k", ":lprev<CR>", opts)

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
vim.keymap.set("n", "<C-S-l>", ":bnext<CR>", opts)
vim.keymap.set("n", "<C-S-h>", ":bprevious<CR>", opts)

------------------------
-- VISUAL MODE INDENT --
------------------------
-- Indent and stay in visual mode
vim.keymap.set("v", "<", "<gv", opts)
vim.keymap.set("v", ">", ">gv", opts)
-- Move lines up and down in visual mode
vim.keymap.set({ "x", "v" }, "<S-j>", ":move '>+1<CR>gv-gv", opts)
vim.keymap.set({ "x", "v" }, "<S-k>", ":move '<-2<CR>gv-gv", opts)

------------
-- SEARCH --
------------
vim.keymap.set("n", "<leader>cs", ":nohl<CR>", opts)

-----------
--- MISC --
-----------
vim.keymap.set("v", "p", [["_dP]], opts)
