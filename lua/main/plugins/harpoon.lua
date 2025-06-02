return {
    "ThePrimeagen/harpoon",
    branch = "harpoon2",
    dependencies = {
        "nvim-lua/plenary.nvim",
        "nvim-telescope/telescope.nvim",
    },
    config = function()
        local harpoon = require("harpoon")
        harpoon:setup()

        local actions_state = require("telescope.actions.state")
        local finders = require("telescope.finders")
        local pickers = require("telescope.pickers")
        local entry_display = require("telescope.pickers.entry_display")
        local conf = require("telescope.config").values

        -- Yoink from https://github.com/ThePrimeagen/harpoon/blob/harpoon2/lua/telescope/_extensions/marks.lua
        local filter_empty_string = function(list)
            local next = {}
            for idx in pairs(list) do
                if list[idx] and list[idx].value ~= "" then
                    table.insert(next, vim.tbl_extend("force", list[idx], { index = idx }))
                end
            end

            return next
        end

        local generate_new_finder = function()
            return finders.new_table({
                results = filter_empty_string(harpoon:list().items),
                entry_maker = function(entry)
                    local line = entry.value .. ":" .. entry.context.row .. ":" .. entry.context.col
                    local displayer = entry_display.create({
                        separator = " - ",
                        items = {
                            { width = 2 },
                            { width = 50 },
                            { remaining = true },
                        },
                    })
                    local make_display = function()
                        return displayer({
                            string.format("%02.0f", entry.index),
                            line,
                        })
                    end
                    return {
                        value = entry,
                        ordinal = string.format("%02.0f", entry.index) .. line,
                        display = make_display,
                        lnum = entry.context.row,
                        col = entry.context.col,
                        filename = entry.value,
                    }
                end,
            })
        end

        local delete_harpoon_mark = function(bufnr)
            local selection = actions_state.get_selected_entry()
            harpoon:list():remove_at(selection.value.index)

            local current_picker = actions_state.get_current_picker(bufnr)
            current_picker:refresh(generate_new_finder(), { reset_prompt = true })
        end

        local move_mark_up = function(bufnr)
            local selection = actions_state.get_selected_entry()
            local items = harpoon:list().items
            local selection_idx = selection.value.index
            items[selection_idx], items[selection_idx + 1] = items[selection_idx + 1], items[selection_idx]

            local current_picker = actions_state.get_current_picker(bufnr)
            current_picker:refresh(generate_new_finder(), {})
        end

        local move_mark_down = function(bufnr)
            local selection = actions_state.get_selected_entry()
            local items = harpoon:list().items
            local selection_idx = selection.value.index
            if selection_idx == 1 then return end
            items[selection_idx], items[selection_idx - 1] = items[selection_idx - 1], items[selection_idx]

            local current_picker = actions_state.get_current_picker(bufnr)
            current_picker:refresh(generate_new_finder(), {})
        end

        local change_mark_index = function(bufnr)
            local selection = actions_state.get_selected_entry()
            local items = harpoon:list().items
            local selection_idx = selection.value.index
            local new_index = tonumber(vim.fn.input(string.format("New index: ")))

            if new_index and new_index > 0 then
                items[selection_idx], items[new_index] = items[new_index], items[selection_idx]
            else
                vim.notify("New index must be a positive number")
            end

            local current_picker = actions_state.get_current_picker(bufnr)
            current_picker:refresh(generate_new_finder(), {})
        end

        local function toggle_telescope()
            pickers
                .new({
                    selection_strategy = "follow",
                }, {
                    prompt_title = "Harpoon",
                    finder = generate_new_finder(),
                    previewer = conf.file_previewer({}),
                    sorter = conf.generic_sorter({}),
                    attach_mappings = function(_, map)
                        map("i", "<C-S-d>", delete_harpoon_mark)
                        map("n", "<C-S-d>", delete_harpoon_mark)

                        map("i", "<C-S-k>", move_mark_up)
                        map("n", "<C-S-k>", move_mark_up)

                        map("i", "<C-S-j>", move_mark_down)
                        map("n", "<C-S-j>", move_mark_down)

                        map("i", "<C-S-a>", change_mark_index)
                        map("n", "<C-S-a>", change_mark_index)

                        return true
                    end,
                })
                :find()
        end

        vim.api.nvim_create_user_command("HarpoonTelescope", function() toggle_telescope() end, {})
        vim.api.nvim_create_user_command("HarpoonAdd", function() harpoon:list():add() end, {})
        vim.api.nvim_create_user_command(
            "HarpoonQuickMenu",
            function() harpoon.ui:toggle_quick_menu(harpoon:list()) end,
            {}
        )
        vim.api.nvim_create_user_command(
            "HarpoonQuickMenu",
            function() harpoon.ui:toggle_quick_menu(harpoon:list()) end,
            {}
        )
        vim.api.nvim_create_user_command("HarpoonSelect", function(opts)
            local index = tonumber(opts.args)
            if index and index > 0 then harpoon:list():select(index) end
        end, { nargs = 1 })
        vim.api.nvim_create_user_command("HarpoonPrev", function() harpoon:list():prev() end, {})
        vim.api.nvim_create_user_command("HarpoonNext", function() harpoon:list():next() end, {})
    end,
    keys = function()
        local keymaps = {
            { "<leader>h", ":HarpoonTelescope<CR>" },
            { "<leader>a", ":HarpoonAdd<CR>" },
            { "<leader>e", ":HarpoonQuickMenu<CR>" },
            { "<C-S-P>", ":HarpoonPrev<CR>" },
            { "<C-S-N>", ":HarpoonNext<CR>" },
        }

        for i = 1, 9, 1 do
            table.insert(keymaps, {
                "<leader>o" .. tostring(i),
                ":HarpoonSelect " .. tostring(i) .. "<CR>",
            })
        end

        return keymaps
    end,
}
