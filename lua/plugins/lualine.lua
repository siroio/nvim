return {
    "nvim-lualine/lualine.nvim",
    event = "VeryLazy",
    dependencies = { 
        "nvim-tree/nvim-web-devicons",
        "linrongbin16/lsp-progress.nvim"
    },

    config = function()
        require("config.lualine")
    end,
}
