local hop = require("hop")

hop.setup({})

local opts = { silent = true, noremap = true }

vim.keymap.set("n", "s", function()
    hop.hint_words()
end, opts)

vim.keymap.set("n", "S", function()
    hop.hint_patterns()
end, opts)

