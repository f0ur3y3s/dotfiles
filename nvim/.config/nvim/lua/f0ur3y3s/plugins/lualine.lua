return {
    { "archibate/lualine-time" },
    { "AndreM222/copilot-lualine" },
    {
        "nvim-lualine/lualine.nvim",
        dependencies = { "nvim-tree/nvim-web-devicons", "archibate/lualine-time" },
        config = function()
            require("lualine").setup({
                options = {
                    theme = "auto",
                    icons_enabled = true,
                },
                sections = {
                    lualine_a = { "mode" },
                    lualine_b = { "branch", "diff", "diagnostics" },
                    lualine_c = { "%=", { "filename", path = 1, separator = { left = "|" } } },
                    lualine_x = {
                        { "ctime" },
                        { "cdate" },
                        {
                            "copilot",
                            show_colors = false,
                            show_loading = true,
                            --                            symbols = {
                            --                                status = {
                            --                                    icons = {
                            --                                        enabled = "✅",
                            --                                        sleep = "💤",
                            --                                        error = "❌",
                            --                                        disabled = "👇",
                            --                                        unknown = "❔",
                            --                                    },
                            --                                },
                            --                            },
                        },
                    },
                    lualine_y = { "progress" },
                    lualine_z = { "location" },
                },
                inactive_sections = {
                    lualine_a = {},
                    lualine_b = {},
                    lualine_c = {},
                    lualine_x = {},
                    lualine_y = {},
                    lualine_z = {},
                },
                tabline = {},
                winbar = {},
                inactive_winbar = {},
                extensions = {},
            })
        end,
    },
}
