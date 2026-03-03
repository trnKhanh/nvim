return {
    "CopilotC-Nvim/CopilotChat.nvim",
    dependencies = {
        { "nvim-lua/plenary.nvim", branch = "master" },
    },
    build = "make tiktoken",
    opts = {
        model = "gpt-4.1",
        temperature = 0.1,
        window = {
            layout = "vertical",
            title = "🤖 AI Assistant",
            width = 0.5,
        },

        headers = {
            user = "👤 You",
            assistant = "🤖 Copilot",
            tool = "🔧 Tool",
        },

        separator = "━━",
        auto_fold = true,
    },
    config = function(_, opts)
        -- Auto-command to customize chat buffer behavior
        vim.api.nvim_create_autocmd("BufEnter", {
            pattern = "copilot-*",
            callback = function()
                vim.opt_local.relativenumber = false
                vim.opt_local.number = false
                vim.opt_local.conceallevel = 0

                vim.cmd("let b:copilot_enabled = v:false")
            end,
        })

        vim.keymap.set("n", "<C-S-c>", ":CopilotChat<CR>", { noremap = true, silent = true })

        require("CopilotChat").setup(opts)
    end,
}
