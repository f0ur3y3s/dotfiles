local servers = {
    "clangd",
    "cmake",
    "lua_ls",
    "marksman",
    "pylsp",
    "vimls",
}

return {
    {
        "williamboman/mason.nvim",
        lazy = false,
        config = function()
            require("mason").setup()
        end,
    },
    {
        "williamboman/mason-lspconfig.nvim",
        lazy = false,
        opts = {
            auto_install = true,
        },
        config = function()
            require("mason-lspconfig").setup({
                ensure_installed = servers,
            })
        end,
    },
    {
        "neovim/nvim-lspconfig",
        lazy = false,
        config = function()
            local capabilities = require("cmp_nvim_lsp").default_capabilities()
            local lspconfig = require("lspconfig")

            for _, server in ipairs(servers) do
                lspconfig[server].setup({
                    capabilities = capabilities,
                })
            end

            local kmp = vim.keymap

            kmp.set("n", "K", vim.lsp.buf.hover, {})
            kmp.set("n", "<leader>gd", vim.lsp.buf.definition, {})
            kmp.set("n", "<leader>gr", vim.lsp.buf.references, {})
            kmp.set("n", "<leader>ca", vim.lsp.buf.code_action, {})
        end,
    },
}
