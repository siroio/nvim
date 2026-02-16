local null_ls = require("null-ls")

null_ls.setup({
    sources = {
        -- Formatters
        -- null_ls.builtins.formatting.prettier,
        -- null_ls.builtins.formatting.stylua,

        -- Diagnostics
        -- null_ls.builtins.diagnostics.eslint,

        -- Code Actions
        -- null_ls.builtins.code_actions.gitsigns,
    },
})
