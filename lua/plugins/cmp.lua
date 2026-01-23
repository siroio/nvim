return {
    {
        "saghen/blink.cmp",
        version = not vim.g.lazyvim_blink_main and "*",
        build = vim.g.lazyvim_blink_main and "cargo build --release",
        lazy = true,
        event = { "InsertEnter", "CmdLineEnter" },

        dependencies = {
            "hrsh7th/vim-vsnip",
            "onsails/lspkind.nvim"
        },

        opts_extend = { "sources.default" },

        config = function()
            require("config.cmp")
        end,
    },
}
