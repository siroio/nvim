return {
    { 
        "xiyaowong/transparent.nvim" 
    },
    
    { 
        "neanias/everforest-nvim",
        name = "everforest",
        priority = 1000,
        config = function()
            vim.cmd.colorscheme("everforest")
        end,
    },
    {
        "xero/evangelion.nvim",
        lazy = false,
        priority = 1000,
        opts = {
            overrides = {
                keyword = { fg = "#00ff00", bg = "#222222", undercurl = true },
                ["@boolean"] = { link = "Special" },
            },
        },
        init = function()
            vim.cmd.colorscheme("evangelion")
        end,
    }
}

