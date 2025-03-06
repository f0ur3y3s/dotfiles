return {
    "Mofiqul/vscode.nvim",
    config = function()
        vim.o.background = 'dark'
        require("vscode").setup({
            -- transparent = true,
            italic_comments = true,
            disable_nvimtree_bg = true,
            vim.cmd([[colorscheme vscode]]),
        })

        local vapi = vim.api
        vapi.nvim_set_hl(0, "Normal", { bg = "none" })
        vapi.nvim_set_hl(0, "NormalFloat", { bg = "none" })

        -- "vague2k/vague.nvim",
        -- config = function()
        --     require("vague").setup({
        --         vim.cmd([[colorscheme vague]]),
        --         transparent = true,
        --     })

        --         vim.cmd([[
        --   highlight Normal guibg=none
        --   highlight NonText guibg=none
        --   highlight Normal ctermbg=none
        --   highlight NonText ctermbg=none
        -- ]])
    end,
}
