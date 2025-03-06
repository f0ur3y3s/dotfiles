return {
    "akinsho/bufferline.nvim",
    dependencies = "nvim-tree/nvim-web-devicons",

    config = function()
        require("bufferline").setup({
            options = {
                numbers = "none",
                number_style = "superscript",
                mappings = true,
            },
        })
    end,
    enabled = true,
}
