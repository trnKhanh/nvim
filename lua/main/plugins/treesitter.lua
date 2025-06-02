return {
    "nvim-treesitter/nvim-treesitter",
    event = { "BufReadPre", "BufNewFile" },
    branch = "master",
    build = ":TSUpdate",
    config = function()
        require("nvim-treesitter.configs").setup({
            ensure_installed = {
                "vim",
                "vimdoc",
                "c",
                "python",
                "lua",
                "bash",
                "markdown",
            },
            sync_install = false,
            auto_install = true,
            highlight = {
                enable = true,
                disable = function(_, buf)
                    local max_filesize = 100 * 1024 -- 100 KB
                    local stat_ok, stat = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
                    if stat_ok and stat and stat.size > max_filesize then return true end
                end,
            },
        })
    end,
}
