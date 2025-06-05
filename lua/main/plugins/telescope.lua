return {
    "nvim-telescope/telescope.nvim",
    tag = "0.1.8",
    dependencies = {
        "nvim-lua/plenary.nvim",
        { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
    },
    opts = function()
        local actions = require("telescope.actions")

        return {
            defaults = {
                prompt_prefix = " ",
                selection_caret = " ",
                path_display = { "smart" },
                vimgrep_arguments = {
                    "rg",
                    "--color=never",
                    "--no-heading",
                    "--with-filename",
                    "--line-number",
                    "--column",
                    "--smart-case",
                    "--hidden",
                },
                file_ignore_patterns = { ".git/" },
                mappings = {
                    i = {
                        ["<C-c>"] = actions.close,

                        ["<C-n>"] = actions.cycle_history_next,
                        ["<C-p>"] = actions.cycle_history_prev,

                        ["<C-j>"] = actions.move_selection_next,
                        ["<C-k>"] = actions.move_selection_previous,
                        ["<Down>"] = actions.move_selection_next,
                        ["<Up>"] = actions.move_selection_previous,

                        -- Open files
                        ["<CR>"] = actions.select_default,
                        -- Open files in a new horzontal window
                        ["<C-x>"] = actions.select_horizontal,
                        -- Open files in a new vertical window
                        ["<C-v>"] = actions.select_vertical,
                        -- Open files in a new tab
                        ["<C-t>"] = actions.select_tab,

                        ["<C-u>"] = actions.preview_scrolling_up,
                        ["<C-d>"] = actions.preview_scrolling_down,

                        ["<PageUp>"] = actions.results_scrolling_up,
                        ["<PageDown>"] = actions.results_scrolling_down,

                        ["<Tab>"] = actions.toggle_selection + actions.move_selection_worse,
                        ["<S-Tab>"] = actions.toggle_selection + actions.move_selection_better,
                        ["<C-l>"] = actions.complete_tag,
                        ["<C-_>"] = actions.which_key,
                        ["<C-q>"] = actions.send_to_qflist,
                        ["<C-S-q>"] = actions.send_selected_to_qflist,
                    },
                    n = {
                        ["<esc>"] = actions.close,

                        ["j"] = actions.move_selection_next,
                        ["k"] = actions.move_selection_previous,
                        ["<Down>"] = actions.move_selection_next,
                        ["<Up>"] = actions.move_selection_previous,

                        ["H"] = actions.move_to_top,
                        ["M"] = actions.move_to_middle,
                        ["L"] = actions.move_to_bottom,
                        ["gg"] = actions.move_to_top,
                        ["G"] = actions.move_to_bottom,

                        ["<CR>"] = actions.select_default,
                        ["<C-x>"] = actions.select_horizontal,
                        ["<C-v>"] = actions.select_vertical,
                        ["<C-t>"] = actions.select_tab,

                        ["<C-u>"] = actions.preview_scrolling_up,
                        ["<C-d>"] = actions.preview_scrolling_down,

                        ["<PageUp>"] = actions.results_scrolling_up,
                        ["<PageDown>"] = actions.results_scrolling_down,

                        ["<Tab>"] = actions.toggle_selection + actions.move_selection_worse,
                        ["<S-Tab>"] = actions.toggle_selection + actions.move_selection_better,
                        ["?"] = actions.which_key,

                        ["<C-q>"] = actions.send_to_qflist,
                        ["<C-S-q>"] = actions.send_selected_to_qflist,
                        -- ["<C-s>w"] = actions.insert_original_cword,
                        -- ["<C-s>W"] = actions.insert_original_cWORD,
                    },
                },
            },
            extensions = {
                fzf = {
                    fuzzy = true,
                    override_generic_sorter = true,
                    override_file_sorter = true,
                    case_mode = "smart_case",
                },
            },
        }
    end,
    config = function(_, opts)
        local telescope = require("telescope")
        telescope.setup(opts)
        telescope.load_extension("fzf")
    end,
    keys = {
        -- Telescope popup windows
        { "<leader>f", ":Telescope find_files hidden=true<CR>", mode = { "n" } },
        { "<leader>t", ":Telescope live_grep hidden=true<CR>", mode = { "n" } },
        { "<leader>l", ":Telescope diagnostics<CR>", mode = { "n" } },
        -- Git popup windows
        { "<leader>gb", ":Telescope git_branches<CR>", mode = { "n" } },
        { "<leader>gc", ":Telescope git_commits<CR>", mode = { "n" } },
        { "<leader>gs", ":Telescope git_status<CR>", mode = { "n" } },
    },
}
