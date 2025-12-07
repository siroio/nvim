return {
    {
        "ray-x/lsp_signature.nvim",
        event = "LspAttach",
        config = function()
            require("config.lsp_signature")
        end,
    },
}

