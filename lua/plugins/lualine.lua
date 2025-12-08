-- lua/plugins/lualine.lua
return {
    "nvim-lualine/lualine.nvim",
    event = "VeryLazy",
    dependencies = { "nvim-tree/nvim-web-devicons" },

    config = function()
        local ok, lualine = pcall(require, "lualine")
        if not ok then
            return
        end

        local lsp_state = { progress = "" }
        local spinners = { "", "󰪞", "󰪟", "󰪠", "󰪡", "󰪢", "󰪣", "󰪤", "󰪥", "", "" }

        vim.api.nvim_create_autocmd("LspProgress", {
            group = vim.api.nvim_create_augroup("LualineLspProgress", { clear = true }),
            pattern = { "begin", "report", "end" },
            callback = function(args)
                local data = args.data and args.data.params and args.data.params.value
                if not data then
                    return
                end

                if data.kind == "end" then
                    lsp_state.progress = ""
                else
                    local pct = data.percentage or 0
                    local idx = 1 + ((pct - pct % 10) / 10)
                    idx = math.max(1, math.min(#spinners, idx))
                    local spinner = spinners[idx]

                    local progress = ""
                    if data.message then
                        local start, stop = data.message:find("^%d+/%d+")
                        if start then
                            progress = data.message:sub(start, stop)
                        end
                    end

                    lsp_state.progress = spinner
                        .. " "
                        .. tostring(pct)
                        .. "%% "
                        .. (data.title or "")
                        .. (progress ~= "" and " " .. progress or "")
                end

                pcall(vim.cmd.redrawstatus)
            end,
        })

        local rei_bg       = "#050816" -- ほぼ黒に近い紺
        local rei_panel    = "#0b1020" -- ステータスラインのベース
        local rei_dim      = "#1a2135"
        local rei_dim2     = "#252b3e"
        local rei_blue     = "#8ab4ff" -- 髪色寄りの淡い青
        local rei_blue_alt = "#5f8cff"
        local rei_cyan     = "#9cf5ff"
        local rei_white    = "#e6eef8"
        local rei_red      = "#ff6b81"

        local rei_theme = {
            normal = {
                a = { fg = rei_bg,    bg = rei_blue,     gui = "bold" },
                b = { fg = rei_white, bg = rei_dim2 },
                c = { fg = rei_white, bg = rei_panel },
            },
            insert = {
                a = { fg = rei_bg,    bg = rei_cyan,     gui = "bold" },
                b = { fg = rei_white, bg = rei_dim2 },
                c = { fg = rei_white, bg = rei_panel },
            },
            visual = {
                a = { fg = rei_bg,    bg = "#d0b3ff",    gui = "bold" },
                b = { fg = rei_white, bg = rei_dim2 },
                c = { fg = rei_white, bg = rei_panel },
            },
            replace = {
                a = { fg = rei_bg,    bg = rei_red,      gui = "bold" },
                b = { fg = rei_white, bg = rei_dim2 },
                c = { fg = rei_white, bg = rei_panel },
            },
            command = {
                a = { fg = rei_bg,    bg = "#f2e88b",    gui = "bold" },
                b = { fg = rei_white, bg = rei_dim2 },
                c = { fg = rei_white, bg = rei_panel },
            },
            inactive = {
                a = { fg = "#7c88a8", bg = rei_bg },
                b = { fg = "#7c88a8", bg = rei_bg },
                c = { fg = "#7c88a8", bg = rei_bg },
            },
        }

        ----------------------------------------------------------------------
        -- ユーティリティ & コンポーネント
        ----------------------------------------------------------------------
        local function diff_source()
            local gitsigns = vim.b.gitsigns_status_dict
            if gitsigns then
                return {
                    added    = gitsigns.added,
                    modified = gitsigns.changed,
                    removed  = gitsigns.removed,
                }
            end
        end

        local function lsp_name_with_progress()
            local buf_ft = vim.bo.filetype
            local clients = vim.lsp.get_clients({ bufnr = 0 })
            if not clients or #clients == 0 then
                return ""
            end

            local names = {}
            for _, c in ipairs(clients) do
                local filetypes = c.config.filetypes
                if not filetypes or vim.tbl_contains(filetypes, buf_ft) then
                    table.insert(names, c.name)
                end
            end

            if #names == 0 then
                return ""
            end

            local base = "  " .. table.concat(names, ", ")
            if lsp_state.progress ~= "" then
                base = base .. "  " .. lsp_state.progress
            end
            return base
        end

        local function cwd()
            local cwd_path = vim.loop.cwd() or ""
            -- HOME は ~ 表記に
            local home = vim.loop.os_homedir() or ""
            if cwd_path:find(home, 1, true) == 1 then
                cwd_path = "~" .. cwd_path:sub(#home + 1)
            end
            return " " .. cwd_path
        end

        local function tabwidth()
            return " " .. vim.bo.tabstop
        end

        local function file_location()
            local cursorline = vim.fn.line(".")
            local cursorcol = vim.fn.virtcol(".")
            local filelines = vim.fn.line("$")
            local position
            if cursorline == 1 then
                position = "Top"
            elseif cursorline == filelines then
                position = "Bot"
            else
                position = string.format("%2d%%%%", math.floor(cursorline / filelines * 100))
            end
            return string.format("%s · %3d:%-2d", position, cursorline, cursorcol)
        end

        ----------------------------------------------------------------------
        -- lualine 設定本体
        ----------------------------------------------------------------------
        lualine.setup({
            options = {
                theme = rei_theme,
                icons_enabled = true,
                globalstatus = true,
                -- シャープなエッジでパネル感を出す
                component_separators = { left = "│", right = "│" },
                section_separators   = { left = "", right = "" },
                disabled_filetypes = {
                    statusline = { "alpha", "starter", "dashboard" },
                    winbar = {},
                },
            },

            sections = {
                lualine_a = {
                    {
                        "mode",
                        icon = "",
                        separator = { left = "", right = "" },
                        right_padding = 2,
                    },
                },

                lualine_b = {
                    {
                        "filetype",
                        icon_only = false,
                        icon = { align = "left" },
                    },
                    {
                        function()
                            local filename = vim.fn.expand("%:t")
                            if filename == "" then
                                return "[No Name]"
                            end
                            local flags = {}
                            if vim.bo.modified then
                                table.insert(flags, "+")
                            end
                            if vim.bo.readonly then
                                table.insert(flags, "RO")
                            end
                            if #flags > 0 then
                                return filename .. " [" .. table.concat(flags, ",") .. "]"
                            end
                            return filename
                        end,
                    },
                },

                lualine_c = {
                    {
                        "branch",
                        icon = "",
                    },
                    {
                        "diff",
                        source = diff_source,
                        symbols = {
                            added    = " ",
                            modified = " ",
                            removed  = " ",
                        },
                    },
                    { "%=" }, -- 中央寄せ
                    {
                        "diagnostics",
                        sources = { "nvim_diagnostic" },
                        symbols = {
                            error = " ",
                            warn  = " ",
                            info  = " ",
                            hint  = "󰌵 ",
                        },
                    },
                    {
                        lsp_name_with_progress,
                    },
                },

                lualine_x = {
                    {
                        "encoding",
                        fmt = string.upper,
                        padding = { left = 1, right = 1 },
                        separator = { left = "", right = "" },
                        cond = function()
                            return vim.o.columns > 100
                        end,
                    },
                    {
                        "fileformat",
                        symbols = {
                            unix = "LF",
                            dos  = "CRLF",
                            mac  = "CR",
                        },
                    },
                    { "filetype" },
                    { tabwidth },
                },

                lualine_y = {
                    { cwd },
                },

                lualine_z = {
                    { file_location, separator = { left = "", right = "" } },
                },
            },

            inactive_sections = {
                lualine_a = {},
                lualine_b = {},
                lualine_c = { "filename" },
                lualine_x = { "location" },
                lualine_y = {},
                lualine_z = {},
            },

            tabline = {},
            winbar = {},
            inactive_winbar = {},
            extensions = {},
        })
    end,
}

