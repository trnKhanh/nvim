local lsp_servers = {
    "lua_ls",
    "pyright",
    "clangd",
}

return {
    "neovim/nvim-lspconfig",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = {
        "mason-org/mason.nvim",
        "mason-org/mason-lspconfig.nvim",
        "hrsh7th/nvim-cmp",
        "hrsh7th/cmp-nvim-lsp",
        "hrsh7th/cmp-buffer",
        "hrsh7th/cmp-path",
        "hrsh7th/cmp-cmdline",
        "stevearc/conform.nvim",
    },
    config = function()
        -- 'mason-lspconfig' will enable all installed LSP server by default
        -- Therefore, we do not need to call 'vim.lsp.enable'
        --
        -- The manual option for <lsp> can be set in lsp/<lsp>.lua since nvim merge
        -- configs in following order: (1) vim.lsp.config, (2) runtimepath, (3) elsewhere
        -- runtimepath is started with $XDG_CONFIG_HOME/nvim
        require("mason").setup()
        require("mason-lspconfig").setup({
            ensure_installed = lsp_servers,
            automatic_enable = true,
        })

        -- Loop through all LSP servers to load manual configs if available
        for s in vim.iter(lsp_servers) do
            local require_ok, config_opts = pcall(require, "main.plugins.lsp.settings." .. s)
            if require_ok then vim.lsp.config(s, config_opts) end
        end

        -- Set up completion
        local cmp = require("cmp")
        local cmp_nvim_lsp = require("cmp_nvim_lsp")
        local capabilities = vim.tbl_deep_extend(
            "force",
            {},
            vim.lsp.protocol.make_client_capabilities(),
            cmp_nvim_lsp.default_capabilities()
        )
        vim.lsp.config("*", { capabilities = capabilities })

        -- Specified here: https://github.com/hrsh7th/nvim-cmp/blob/b5311ab3ed9c846b585c0c15b7559be131ec4be9/lua/cmp/types/lsp.lua#L176
        local kind_icons = {
            Text = "󰊄",
            Method = "m",
            Function = "󰊕",
            Constructor = "",
            Field = "",
            Variable = "󰫧",
            Class = "",
            Interface = "",
            Module = "",
            Property = "",
            Unit = "",
            Value = "",
            Enum = "",
            Keyword = "󰌆",
            Snippet = "",
            Color = "",
            File = "",
            Reference = "",
            Folder = "",
            EnumMember = "",
            Constant = "",
            Struct = "",
            Event = "",
            Operator = "",
            TypeParameter = "󰉺",
        }

        cmp.setup({
            mapping = {
                ["<C-k>"] = cmp.mapping.select_prev_item(),
                ["<C-j>"] = cmp.mapping.select_next_item(),
                ["<Tab>"] = cmp.mapping(cmp.mapping.select_next_item(), { "i" }),
                ["<S-Tab>"] = cmp.mapping(cmp.mapping.select_prev_item(), { "i" }),
                ["<C-u>"] = cmp.mapping(cmp.mapping.scroll_docs(-1), { "i", "c" }),
                ["<C-d>"] = cmp.mapping(cmp.mapping.scroll_docs(1), { "i", "c" }),
                ["<C-Space>"] = cmp.mapping(cmp.mapping.complete(), { "i", "c" }),
                ["<C-c>"] = cmp.mapping({
                    i = cmp.mapping.abort(),
                    c = cmp.mapping.close(),
                }),
                ["<CR>"] = cmp.mapping.confirm({ select = true }),
            },
            formatting = {
                fields = { "kind", "abbr", "menu" },
                format = function(entry, vim_item)
                    vim_item.kind = string.format("%s", kind_icons[vim_item.kind])
                    vim_item.menu = ({
                        nvim_lsp = "[LSP]",
                        buffer = "[Buffer]",
                        path = "[Path]",
                    })[entry.source.name]
                    return vim_item
                end,
            },
            sources = cmp.config.sources({
                { name = "nvim_lsp" },
            }, {
                { name = "buffer" },
                { name = "path" },
            }),
            window = {
                completion = cmp.config.window.bordered(),
                documentation = cmp.config.window.bordered(),
            },
            experimental = {
                ghost_text = true,
            },
        })

        -- Set up diagnostic
        vim.diagnostic.config({
            severity_sort = true,
            signs = {
                text = {
                    [vim.diagnostic.severity.ERROR] = "",
                    [vim.diagnostic.severity.WARN] = "",
                    [vim.diagnostic.severity.INFO] = "",
                    [vim.diagnostic.severity.HINT] = "",
                },
            },
            float = {
                scope = "cursor",
                source = true,
                focusable = false,
                style = "minimal",
                border = "rounded",
                header = "",
                prefix = "",
            },
        })

        -- Set keymaps on 'LspAttach' event
        vim.api.nvim_create_autocmd("LspAttach", {
            callback = function(args)
                local opts = { buffer = args.buf, noremap = true, silent = true, nowait = true }
                local telescope_ok, telescope = pcall(require, "telescope.builtin")

                vim.keymap.set("n", "K", function() vim.lsp.buf.hover({ border = "rounded" }) end, opts)
                vim.keymap.set("n", "gl", function() vim.diagnostic.open_float() end, opts)

                vim.keymap.set("n", "gD", function() vim.lsp.buf.declaration() end, opts)
                vim.keymap.set("n", "grn", function() vim.lsp.buf.rename() end, opts)

                local conform_ok, conform = pcall(require, "conform")
                if conform_ok then
                    vim.keymap.set("n", "gf", function() conform.format({ bufnr = 0, async = true }) end, opts)
                else
                    vim.keymap.set("n", "gf", function() vim.lsp.buf.format() end, opts)
                end

                if telescope_ok then
                    vim.keymap.set("n", "gd", function() telescope.lsp_definitions() end, opts)
                    vim.keymap.set("n", "gr", function() telescope.lsp_references() end, opts)
                    vim.keymap.set("n", "gi", function() telescope.lsp_implementations() end, opts)
                    vim.keymap.set("n", "<leader>l", function() telescope.diagnostics() end, opts)
                else
                    vim.keymap.set("n", "gd", function() vim.lsp.buf.definition() end, opts)
                    vim.keymap.set("n", "gr", function() vim.lsp.buf.references() end, opts)
                    vim.keymap.set("n", "gi", function() vim.lsp.buf.implementation() end, opts)
                end

                -- Highlight words under cursor and related words
                local client_ok, client = pcall(vim.lsp.get_client_by_id, args.data.client_id)
                if client_ok and client:supports_method("textDocument/documentHighlight") then
                    vim.api.nvim_set_hl(0, "LspReferenceRead", {
                        underline = true,
                        cterm = { underline = true },
                    })
                    vim.api.nvim_set_hl(0, "LspReferenceText", {
                        underline = true,
                        cterm = { underline = true },
                    })
                    vim.api.nvim_set_hl(0, "LspReferenceWrite", {
                        bold = true,
                        underline = true,
                        cterm = { underline = true },
                    })

                    local augroup = vim.api.nvim_create_augroup("LSPDocumentHighlight", {})
                    vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
                        buffer = args.buf,
                        group = augroup,
                        callback = function() vim.lsp.buf.document_highlight() end,
                    })
                    vim.api.nvim_create_autocmd("CursorMoved", {
                        buffer = args.buf,
                        group = augroup,
                        callback = function() vim.lsp.buf.clear_references() end,
                    })
                end
            end,
        })
    end,
}
