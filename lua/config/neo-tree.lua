local neo_tree = require("neo-tree")

neo_tree.setup({
  close_if_last_window = true,
  filesystem = {
    filtered_items = {
      hide_dotfiles = false,
      hide_gitignored = false,
    },
  },
  window = {
    mappings = {
      -- nvim-tree風キーマップ
      ["<CR>"] = "open",
      ["o"] = "open",
      ["<2-LeftMouse>"] = "open",
      ["s"] = "open_split",
      ["v"] = "open_vsplit",
      ["t"] = "open_tabnew",
      ["a"] = {
        "add",
        config = { show_path = "relative" },
      },
      ["d"] = "delete",
      ["r"] = "rename",
      ["c"] = "copy_to_clipboard",
      ["x"] = "cut_to_clipboard",
      ["p"] = "paste_from_clipboard",
      ["y"] = "copy", -- ファイルをコピー（パスではなくファイル自体）
      ["m"] = "move",
      ["q"] = "close_window",
      ["R"] = "refresh",
      ["?"] = "show_help",
      ["<Esc>"] = "cancel",
      ["H"] = "toggle_hidden",
      ["<BS>"] = "navigate_up",
      ["."] = "set_root",
    },
  },
})

vim.keymap.set("n", "<leader>e", "<Cmd>Neotree toggle<CR>", { noremap = true, silent = true })