local formatters_by_ft = {
    lua = { "stylua" },
    python = { "isort", "black" },
    javascript = { "prettier" },
    json = { "prettier" },
    html = { "prettier" },
    css = { "prettier" },
}

local function flatten(input, result)
    result = result or {}

    for _, v in ipairs(input) do
        if type(v) == "table" then
            flatten(v, result)
        else
            table.insert(result, v)
        end
    end

    return result
end

return {
    "stevearc/conform.nvim",
    event = { "BufReadPre", "BufNewFile" },
    opts = function()
        local formatter_names = {}
        for _, v in pairs(formatters_by_ft) do
            table.insert(formatter_names, v)
        end
        formatter_names = flatten(formatter_names)

        local formatters = {}
        for _, formatter_name in ipairs(formatter_names) do
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
