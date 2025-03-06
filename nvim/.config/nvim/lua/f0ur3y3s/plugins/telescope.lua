return {
    { "nvim-telescope/telescope-ui-select.nvim" },
    {
        "nvim-telescope/telescope.nvim",
        tag = "0.1.8",
        dependencies = { "nvim-lua/plenary.nvim" },
        config = function()
            local actions = require("telescope.actions")
            require("telescope").setup({
                defaults = {
                    mappings = {
                        n = {
                            ["jk"] = actions.close,
                        },

                        i = {
                            ["<leader>fc"] = actions.close,
                            ["<leader>db"] = actions.delete_buffer,
                        },
                    },
                },
                extensions = {
                    ["ui-select"] = {
                        require("telescope.themes").get_dropdown({}),
                    },
                },
            })

            local builtin = require("telescope.builtin")
            local kmp = vim.keymap

            kmp.set("n", "<leader>ff", builtin.find_files, { desc = "Telescope find files" })
            kmp.set("n", "<leader>fg", builtin.live_grep, { desc = "Telescope live grep" })
            kmp.set("n", "<leader>fb", builtin.buffers, { desc = "Telescope buffers" })
            kmp.set("n", "<leader>fh", builtin.help_tags, { desc = "Telescope help tags" })
            -- kmp.set("n", "<leader>fp", builtin.git_commits , { desc = "Telescope preview git diff" })
            kmp.set(
                "n",
                "<leader>/",
                builtin.current_buffer_fuzzy_find,
                { desc = "Telescope current buffer fuzzy find" }
            )

            -- local previewers = require("telescope.previewers")
            -- kmp.set("n", "<leader>fp", previewers.git_commit_diff_to_parent)

            require("telescope").load_extension("ui-select")
        end,
    },
}
