return {
    "nvim-lualine/lualine.nvim",
    event = "VeryLazy",
    dependencies = { "nvim-tree/nvim-web-devicons" },

    config = function()
        local ok, lualine = pcall(require, "lualine")
        if not ok then
            return
        end

        local colors = {
            bg      = "#050912",
            panel   = "#0a1220",
            surface = "#111a2c",
            text    = "#e5edf7",
            muted   = "#8fa1c0",
            accent  = "#0077cc",
            accent2 = "#4ca5ff",
            purple  = "#bfc8ff",
            yellow  = "#f2d27a",
            red     = "#ff6b81",
        }

        local theme = {
            normal = {
                a = { fg = colors.bg,    bg = colors.accent2,  gui = "bold" },
                b = { fg = colors.text,  bg = colors.surface },
                c = { fg = colors.text,  bg = colors.panel },
            },
            insert = {
                a = { fg = colors.bg,    bg = colors.accent, gui = "bold" },
                b = { fg = colors.text,  bg = colors.surface },
                c = { fg = colors.text,  bg = colors.panel },
            },
            visual = {
                a = { fg = colors.bg,    bg = colors.purple,  gui = "bold" },
                b = { fg = colors.text,  bg = colors.surface },
                c = { fg = colors.text,  bg = colors.panel },
            },
            replace = {
                a = { fg = colors.bg,    bg = colors.red,     gui = "bold" },
                b = { fg = colors.text,  bg = colors.surface },
                c = { fg = colors.text,  bg = colors.panel },
            },
            command = {
                a = { fg = colors.bg,    bg = colors.yellow,  gui = "bold" },
                b = { fg = colors.text,  bg = colors.surface },
                c = { fg = colors.text,  bg = colors.panel },
            },
            inactive = {
                a = { fg = colors.muted, bg = colors.accent2 },
                b = { fg = colors.muted, bg = colors.accent2 },
                c = { fg = colors.muted, bg = colors.accent2 },
            },
        }

        lualine.setup({
            options = {
                theme = theme,
                icons_enabled = true,
                globalstatus = true,
                component_separators = { left = '', right = ''},
                section_separators = { left = '', right = ''},
                sections = {
                    lualine_a = {'filename'},
                    lualine_b = {'branch'},
                    lualine_c = {
                        {
                            'diff',
                            symbols = {added = ' ', modified = ' ', removed = ' '},
                            separator = "  |  ",
                        },
                        {
                            'diagnostics',
                            symbols = {error = ' ', warn = ' ', info = ' ', hint = ' '},
                        }
                    },
                    lualine_x = {'encoding', 'fileformat'},
                    lualine_y = {'filetype'},
                    lualine_z = { },
                },

                inactive_sections = {
                    lualine_a = {},
                    lualine_b = {},
                    lualine_c = {},
                    lualine_x = {},
                    lualine_y = {},
                    lualine_z = {},
                },
            },
        })
    end,
}
