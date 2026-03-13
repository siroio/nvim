return {
  "epwalsh/obsidian.nvim",
  version = "*",
  lazy = true,
  ft = "markdown",
  -- vault内のmarkdownでのみロードしたい場合
  -- event = {
  --   "BufReadPre " .. vim.fn.expand "~" .. "/Documents/Obsidian/**.md",
  --   "BufNewFile " .. vim.fn.expand "~" .. "/Documents/Obsidian/**.md",
  -- },
  dependencies = {
    -- Required.
    "nvim-lua/plenary.nvim",
  },
  opts = {
    workspaces = {
      {
        name = "Work",
        path = "D:/horiuchi/Tasks/Work",
      },
      {
        name = "any",
        path = function()
          return assert(vim.fn.getcwd())
          -- or, path = function() return assert(vim.fs.dirname(vim.api.nvim_buf_get_name(0))) end
        end,
        overrides = {
          notes_subdir = vim.NIL,  -- have to use 'vim.NIL' instead of 'nil'
          new_notes_location = "current_dir",
          templates = {
            folder = vim.NIL,
          },
          disable_frontmatter = true,
        },
      },
    },
    ui = {
      enable = true,
    },
    mappings = {
      -- "ObsidianToggleCheckbox" の機能: <leader>ch でトグル
      ["<leader>ch"] = {
        action = function()
          return require("obsidian").util.toggle_checkbox()
        end,
        opts = { buffer = true },
      },
      -- タイムスタンプ付きのTODOを追加
      ["<leader>td"] = {
        action = function()
          local time = os.date("%H:%M")
          -- 'o' で下の行に新しい行を作り、Insertモードに入りながら "- [ ] HH:MM " を入力する
          vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("o- [ ] " .. time .. " ", true, false, true), "n", false)
        end,
        opts = { buffer = true, desc = "Add TODO with timestamp" },
      },
      -- Enterキーでスマートアクション（チェックボックスのトグルやリンク追従）
      ["<CR>"] = {
        action = function()
          return require("obsidian").util.smart_action()
        end,
        opts = { buffer = true, expr = true },
      }
    },
    -- notes_subdir = "notes",
    -- new_notes_location = "notes_subdir",
    -- disable_frontmatter = false,
  },
}
