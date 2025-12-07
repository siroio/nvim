local trouble = require("trouble")

trouble.setup({})

local opts = { noremap = true, silent = true }

vim.keymap.set("n", "<leader>xx", "<cmd>Trouble diagnostics toggle<cr>", opts)
vim.keymap.set("n", "<leader>xq", "<cmd>Trouble qflist toggle<cr>", opts)

