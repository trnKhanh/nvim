return {
    "github/copilot.vim",
    config = function()
        vim.g.copilot_no_tab_map = true

        vim.keymap.set("i", "<C-h>", 'copilot#Accept("<CR>")', { silent = true, expr = true })
        vim.keymap.set("i", "<C-u>", "copilot#Next()", { silent = true, expr = true })
        vim.keymap.set("i", "<C-i>", "copilot#Previous()", { silent = true, expr = true })
    end,
    lazy = false,
}
