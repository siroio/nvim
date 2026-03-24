return {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",

    config = function()
        require('config.nvim-treesitter')
        local install = require('nvim-treesitter.install')
        install.prefer_git = true
        install.compilers = { "zig", "gcc", "clang" }
    end,
}
