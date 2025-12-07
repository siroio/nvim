
local signature = require("lsp_signature")

signature.setup({
    hint_enable = true,
    floating_window = true,
    hint_prefix = ">> ",
    handler_opts = {
        border = "rounded",
    },
})
