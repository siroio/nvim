
local wk = require("which-key")

wk.setup({})

wk.add({
    { "<leader>b", group = "buffer" },
    { "<leader>f", group = "file" },
    { "<leader>g", group = "git" },
    { "<leader>l", group = "lsp" },
    { "<leader>x", group = "diagnostics" },
})
