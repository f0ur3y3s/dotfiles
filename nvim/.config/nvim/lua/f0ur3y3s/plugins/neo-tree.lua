return {
    "nvim-neo-tree/neo-tree.nvim",
    branch = "v3.x",
    dependencies = {
        "nvim-lua/plenary.nvim",
        "nvim-tree/nvim-web-devicons",
        "MunifTanjim/nui.nvim",
    },
    config = function()
        local kmp = vim.keymap
        kmp.set("n", "<C-n>", ":Neotree toggle<CR>", {})
        kmp.set("n", "<leader>gp", "<cmd>Neotree float git_status<CR> ", {})
    end,
}
