local barbar = require("barbar")

barbar.setup({})

local opts = { noremap = true, silent = true }

vim.keymap.set("n", "<A-,>", "<Cmd>BufferPrevious<CR>", opts)
vim.keymap.set("n", "<A-.>", "<Cmd>BufferNext<CR>", opts)
vim.keymap.set("n", "<A-c>", "<Cmd>BufferClose<CR>", opts)
vim.keymap.set("n", "<A-p>", "<Cmd>BufferPin<CR>", opts)

