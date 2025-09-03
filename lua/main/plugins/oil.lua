return {
    "stevearc/oil.nvim",
    dependencies = { "echasnovski/mini.icons", opts = {} },
    opts = function()
        vim.keymap.set("n", "-", "<CMD>Oil<CR>", { desc = "Open parent directory" })
        return {
            columns = {
                "icon",
                "permissions",
                "size",
                "mtime",
            },
        }
    end,
    lazy = false,
}
