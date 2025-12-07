return {
    {
        "kana/vim-operator-user",
    },
    {
        "kana/vim-operator-replace",
        dependencies = {
            "kana/vim-operator-user",
        },
        config = function()
            require("config.operator_replace")
        end,
    },
}

