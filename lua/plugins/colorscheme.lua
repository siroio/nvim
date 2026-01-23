return {
    {
        'tribela/transparent.nvim',
        lazy = false,
        priority = 1000,
        config = function()
            require("config.colorscheme")
        end,
    },
}
