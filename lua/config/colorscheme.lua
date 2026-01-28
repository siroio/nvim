require("catppuccin").setup({
    flavour = "mocha",
    background = {
        light = "latte",
        dark = "mocha",
    },
    transparent_background = false,
    show_end_of_buffer = false,
    term_colors = true,
    dim_inactive = {
        enabled = false,
        shade = "dark",
        percentage = 0.15,
    },
    no_italic = false,
    no_bold = false,
    no_underline = false,
    styles = {
        comments = { "italic" },
        conditionals = { "italic" },
        loops = {},
        functions = {},
        keywords = {},
        strings = {},
        variables = {},
        numbers = {},
        booleans = {},
        properties = {},
        types = {},
        operators = {},
    },
    color_overrides = {},
    integrations = {
        cmp = true,
        gitsigns = true,
        nvimtree = true,
        treesitter = true,
        notify = false,
        mini = {
            enabled = true,
            indentscope_color = "",
        },
        telescope = { enabled = true, style = "nvchad" },
    },
    custom_highlights = function(colors)
        return {
            TelescopeBorder = { fg = colors.mantle, bg = colors.mantle },
            TelescopeNormal = { bg = colors.mantle },
            TelescopeSelection = { fg = colors.text, bg = colors.surface0, bold = true },
            TelescopeSelectionCaret = { fg = colors.green, bg = colors.surface0 },
            TelescopePromptBorder = { fg = colors.surface0, bg = colors.surface0 },
            TelescopePromptNormal = { fg = colors.text, bg = colors.surface0 },
            TelescopePromptPrefix = { fg = colors.green, bg = colors.surface0 },
            TelescopePromptTitle = { fg = colors.base, bg = colors.green, bold = true },
            TelescopePromptCounter = { fg = colors.overlay1, bg = colors.surface0 },
            TelescopeResultsBorder = { fg = colors.mantle, bg = colors.mantle },
            TelescopeResultsNormal = { bg = colors.mantle },
            TelescopeResultsTitle = { fg = colors.base, bg = colors.blue, bold = true },
            TelescopePreviewBorder = { fg = colors.mantle, bg = colors.mantle },
            TelescopePreviewNormal = { bg = colors.mantle },
            TelescopePreviewTitle = { fg = colors.base, bg = colors.teal, bold = true },
            TelescopeMatching = { fg = colors.lavender },
        }
    end,
})

-- setup must be called before loading
vim.cmd.colorscheme "catppuccin"
