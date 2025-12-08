return {
    {
        "xiyaowong/transparent.nvim",
        lazy = false,
        priority = 1000,
        config = function()
            vim.g.rei_transparent = true
            vim.cmd.colorscheme("rei")
        end,
    },
}
