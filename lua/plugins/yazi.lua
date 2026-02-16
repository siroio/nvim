return {
  "mikavilpas/yazi.nvim",
  event = "VeryLazy",
  keys = {
    -- 👇 in this section, choose your own keymappings!
    {
      "<leader>-",
      function()
        require("yazi").yazi()
      end,
      desc = "Open Yazi",
    },
  },
  ---@type YaziConfig
  opts = {
    -- if you want to open yazi instead of netrw, there is optional advice for that
    -- in the "Configuration" section below
    open_for_directories = false,
  },
}
