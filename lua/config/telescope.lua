local telescope = require("telescope")
local actions = require("telescope.actions")

telescope.setup({
    defaults = {
        vimgrep_arguments = {
            "rg",
            "--no-heading",
            "--with-filename",
            "--line-number",
            "--column",
            "--smart-case",
        },
        initial_mode = "insert",
        prompt_prefix = "  ",  -- Search icon
        selection_caret = "> ",  -- > icon for selection
        entry_prefix = "  ",
        scroll_strategy = "limit",
        layout_strategy = "flex",
        path_display = { "absolute" },
        selection_strategy = "reset",
        color_devicons = true,
        file_ignore_patterns = { ".git/", ".cache", "build/", "%.class", "%.pdf", "%.mkv", "%.mp4", "%.zip" },
        layout_config = {
            horizontal = {
                preview_width = 0.55,
            },
            vertical = {
                mirror = false,
            },
            width = 0.85,
            height = 0.92,
            preview_cutoff = 120,
        },
        file_previewer = require("telescope.previewers").vim_buffer_cat.new,
        grep_previewer = require("telescope.previewers").vim_buffer_vimgrep.new,
        qflist_previewer = require("telescope.previewers").vim_buffer_qflist.new,
        file_sorter = require("telescope.sorters").get_fuzzy_file,
        generic_sorter = require("telescope.sorters").get_generic_fuzzy_sorter,
        buffer_previewer_maker = require("telescope.previewers").buffer_previewer_maker,
        mappings = {
            i = {
                ["<C-n>"] = actions.move_selection_next,
                ["<C-p>"] = actions.move_selection_previous,
                ["<C-c>"] = actions.close,
                ["<Esc>"] = actions.close,
            },
            n = {
                ["q"] = actions.close,
                ["<Esc>"] = actions.close,
            },
        },
    },
    pickers = {
        find_files = {
            prompt_title = "Files",
        },
        live_grep = {
            prompt_title = "Grep Preview",
        },
        buffers = {
            prompt_title = "Buffers",
        },
    },
})

-- Keymaps
local builtin = require("telescope.builtin")
vim.keymap.set("n", "<leader>ff", builtin.find_files, { desc = "Find Files" })
vim.keymap.set("n", "<leader>fg", builtin.live_grep, { desc = "Live Grep" })
vim.keymap.set("n", "<leader>fb", builtin.buffers, { desc = "Buffers" })
vim.keymap.set("n", "<leader>fh", builtin.help_tags, { desc = "Help Tags" })
