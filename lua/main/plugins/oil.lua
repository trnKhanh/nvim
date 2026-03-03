return {
    "stevearc/oil.nvim",
    dependencies = { "echasnovski/mini.icons", opts = {} },
    opts = {
        columns = {
            "icon",
            "permissions",
            "size",
            "mtime",
        },
    },
    config = function(_, opts)
        vim.keymap.set("n", "-", "<CMD>Oil<CR>", { desc = "Open parent directory" })
        require("oil").setup(opts)
    end,
    lazy = false,
}
