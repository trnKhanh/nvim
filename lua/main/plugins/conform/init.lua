local formatters_by_ft = {
    lua = { "stylua" },
    python = { "isort", "black" },
    javascript = { "prettier" },
    json = { "prettier" },
    html = { "prettier" },
    css = { "prettier" },
}

return {
    "stevearc/conform.nvim",
    event = { "BufReadPre", "BufNewFile" },
    opts = function()
        local formatters = {}
        for formatter_name in vim.iter(vim.tbl_values(formatters_by_ft)):flatten() do
            local opts_ok, opts = pcall(require, "main.plugins.conform.settings." .. formatter_name)
            if opts_ok then formatters = vim.tbl_deep_extend("force", formatters, { [formatter_name] = opts }) end
        end

        return {
            formatters_by_ft = formatters_by_ft,
            formatters = formatters,
            default_format_opts = {
                lsp_format = "fallback",
            },
        }
    end,
}
