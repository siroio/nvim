return {
    {
        "xiyaowong/transparent.nvim"
    },

    {
        "neanias/everforest-nvim",
        name = "everforest",
        priority = 1000,
        config = function()
            local palette = {
                bg          = "#1f2322",
                panel       = "#232927",
                panel_alt   = "#2d3330",
                blue        = "#8ab4ff",
                blue_alt    = "#6f9aff",
                cyan        = "#9cf5ff",
                lavender    = "#c8d7ff",
                red         = "#ff6b81",
                amber       = "#f2e88b",
                graphite    = "#9aa6a0",
            }

            local function to_hex(num)
                if not num then
                    return nil
                end
                return string.format("#%06x", num)
            end

            local function blend(fg, bg, alpha)
                local function hex_to_rgb(hex)
                    hex = hex:gsub("#", "")
                    return {
                        tonumber(hex:sub(1, 2), 16),
                        tonumber(hex:sub(3, 4), 16),
                        tonumber(hex:sub(5, 6), 16),
                    }
                end

                local f = hex_to_rgb(fg)
                local b = hex_to_rgb(bg)
                local function channel(i)
                    return math.floor((alpha * f[i]) + ((1 - alpha) * b[i]) + 0.5)
                end

                return string.format("#%02x%02x%02x", channel(1), channel(2), channel(3))
            end

            -- everforest をベースにレイっぽい寒色のアクセントを重ねる
            vim.g.everforest_background = "medium"
            vim.g.everforest_better_performance = 1
            vim.g.everforest_enable_italic = 1
            vim.g.everforest_disable_italic_comment = 0
            vim.g.everforest_ui_contrast = "high"

            vim.cmd.colorscheme("everforest")

            local function apply_rei_overrides()
                local normal = vim.api.nvim_get_hl(0, { name = "Normal", link = false })
                local bg = to_hex(normal.bg) or palette.bg
                local cursorline = blend(palette.panel, bg, 0.55)
                local visual_bg = blend(palette.blue, bg, 0.35)
                local pmenu_sel = blend(palette.blue_alt, bg, 0.4)

                vim.api.nvim_set_hl(0, "Normal", { bg = bg, fg = to_hex(normal.fg) })
                vim.api.nvim_set_hl(0, "CursorLine", { bg = cursorline })
                vim.api.nvim_set_hl(0, "CursorLineNr", { fg = palette.amber, bold = true })
                vim.api.nvim_set_hl(0, "LineNr", { fg = palette.graphite })

                vim.api.nvim_set_hl(0, "Keyword", { fg = palette.blue_alt, bold = true })
                vim.api.nvim_set_hl(0, "Conditional", { fg = palette.blue_alt })
                vim.api.nvim_set_hl(0, "Repeat", { fg = palette.blue_alt })
                vim.api.nvim_set_hl(0, "Function", { fg = palette.blue })
                vim.api.nvim_set_hl(0, "Identifier", { fg = palette.cyan })
                vim.api.nvim_set_hl(0, "Type", { fg = palette.lavender })
                vim.api.nvim_set_hl(0, "Number", { fg = palette.red })
                vim.api.nvim_set_hl(0, "Boolean", { fg = palette.red })
                vim.api.nvim_set_hl(0, "String", { fg = blend(palette.cyan, bg, 0.6) })
                vim.api.nvim_set_hl(0, "DiagnosticHint", { fg = palette.cyan })
                vim.api.nvim_set_hl(0, "DiagnosticInfo", { fg = palette.blue })
                vim.api.nvim_set_hl(0, "DiagnosticWarn", { fg = palette.amber })
                vim.api.nvim_set_hl(0, "DiagnosticError", { fg = palette.red })

                vim.api.nvim_set_hl(0, "Visual", { bg = visual_bg })
                vim.api.nvim_set_hl(0, "Search", { bg = blend(palette.amber, bg, 0.35), fg = bg, bold = true })
                vim.api.nvim_set_hl(0, "IncSearch", { bg = palette.amber, fg = palette.panel, bold = true })
                vim.api.nvim_set_hl(0, "Pmenu", { bg = palette.panel, fg = palette.graphite })
                vim.api.nvim_set_hl(0, "PmenuSel", { bg = pmenu_sel, fg = palette.panel })
                vim.api.nvim_set_hl(0, "StatusLine", { bg = palette.panel, fg = palette.lavender })
                vim.api.nvim_set_hl(0, "StatusLineNC", { bg = palette.panel_alt, fg = palette.graphite })
            end

            apply_rei_overrides()
            vim.api.nvim_create_autocmd("ColorScheme", {
                pattern = "everforest",
                callback = apply_rei_overrides,
            })
        end,
    },
}

