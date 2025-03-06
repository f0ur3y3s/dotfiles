return {
    "nvimtools/none-ls.nvim",
    config = function()
        local null_ls = require("null-ls")
        null_ls.setup({
            sources = {
                null_ls.builtins.formatting.stylua.with({
                    extra_args = {
                        "--indent-type",
                        "Spaces",
                        "--indent-width",
                        "4",
                    },
                }),
                null_ls.builtins.formatting.prettier,
                null_ls.builtins.code_actions.gitsigns,
                null_ls.builtins.diagnostics.cppcheck,
                null_ls.builtins.formatting.clang_format.with({
                    extra_args = { string.format("-style=file:%s", vim.fn.expand("$HOME/.clang-format")) },
                }),
                null_ls.builtins.diagnostics.pylint.with({
                    extra_args = { string.format("--rcfile=%s", vim.fn.expand("~/.pylintrc")) },
                }),
            },
        })

        vim.keymap.set("n", "<leader>bf", vim.lsp.buf.format, {})
    end,
}
