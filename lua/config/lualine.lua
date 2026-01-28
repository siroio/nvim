-- nvimdots-style lualine config
-- Adapted from: https://github.com/ayamir/nvimdots

local ok, lualine = pcall(require, "lualine")
if not ok then
    return
end

-- Icons (subset from nvimdots/lua/modules/utils/icons.lua)
local icons = {
    diagnostics = {
        Error = " ",
        Warning = " ",
        Information = " ",
        Hint = "󰌶 ",
    },
    git = {
        Add = " ",
        Branch = "",
        Mod = " ",
        Remove = " ",
    },
    misc = {
        LspAvailable = "󱜙 ",
        NoActiveLsp = "󱚧 ",
        PyEnv = "󰢩 ",
    },
    ui = {
        Tab = " ",
        FolderWithHeart = "󱃪 ",
    },
    aichat = {
        Copilot = " ",
    },
}

-- LSP Progress Config
require('lsp-progress').setup({
    client_format = function(client_name, spinner, series_messages)
        if #series_messages == 0 then
            return nil
        end
        return {
            name = client_name,
            body = spinner .. " " .. table.concat(series_messages, ", "),
        }
    end,
    format = function(client_messages)
        --- @param name string
        --- @param msg string?
        --- @return string
        local function stringify(name, msg)
            return msg and string.format("%s %s", name, msg) or name
        end

        local sign = "󱜙" -- nf-md-rocket_launch
        if #client_messages > 0 then
            return sign .. " " .. table.concat(vim.tbl_map(function(client_msg)
                return stringify(client_msg.name, client_msg.body)
            end, client_messages), ", ")
        end
        
        -- Fallback when no progress but clients exist
        local clients = vim.lsp.get_clients({ bufnr = vim.api.nvim_get_current_buf() })
        local client_names = {}
        for _, client in ipairs(clients) do
            if client.name ~= "null-ls" and client.name ~= "copilot" then
                table.insert(client_names, client.name)
            end
        end
        
        if #client_names > 0 then
            return sign .. " [" .. table.concat(client_names, ", ") .. "]"
        end
        
        return ""
    end,
})

-- Get catppuccin palette colors
local function get_colors()
    local has_catppuccin, catppuccin_palettes = pcall(require, "catppuccin.palettes")
    if has_catppuccin then
        return catppuccin_palettes.get_palette("mocha")
    end
    -- Fallback colors
    return {
        rosewater = "#f5e0dc",
        flamingo = "#f2cdcd",
        pink = "#f5c2e7",
        mauve = "#cba6f7",
        red = "#f38ba8",
        maroon = "#eba0ac",
        peach = "#fab387",
        yellow = "#f9e2af",
        green = "#a6e3a1",
        teal = "#94e2d5",
        sky = "#89dceb",
        sapphire = "#74c7ec",
        blue = "#89b4fa",
        lavender = "#b4befe",
        text = "#cdd6f4",
        subtext1 = "#bac2de",
        subtext0 = "#a6adc8",
        overlay2 = "#9399b2",
        overlay1 = "#7f849c",
        overlay0 = "#6c7086",
        surface2 = "#585b70",
        surface1 = "#45475a",
        surface0 = "#313244",
        base = "#1e1e2e",
        mantle = "#181825",
        crust = "#11111b",
    }
end

local colors = get_colors()

-- Custom theme matching nvimdots style
local function custom_theme()
    local c = get_colors()
    return {
        normal = {
            a = { fg = c.lavender, bg = c.surface0, gui = "bold" },
            b = { fg = c.text, bg = c.mantle },
            c = { fg = c.text, bg = c.mantle },
        },
        command = {
            a = { fg = c.peach, bg = c.surface0, gui = "bold" },
        },
        insert = {
            a = { fg = c.green, bg = c.surface0, gui = "bold" },
        },
        visual = {
            a = { fg = c.flamingo, bg = c.surface0, gui = "bold" },
        },
        terminal = {
            a = { fg = c.teal, bg = c.surface0, gui = "bold" },
        },
        replace = {
            a = { fg = c.red, bg = c.surface0, gui = "bold" },
        },
        inactive = {
            a = { fg = c.subtext0, bg = c.mantle, gui = "bold" },
            b = { fg = c.subtext0, bg = c.mantle },
            c = { fg = c.subtext0, bg = c.mantle },
        },
    }
end

-- LSP component
local lsp_component = {
    function()
        -- invoke lsp-progress
        local progress = require('lsp-progress').progress({
            max_size = 80,
            format = function(messages)
                 -- Checks if any progress messages exist
                if #messages > 0 then
                    return require('lsp-progress').progress()
                end
                
                -- If no progress, check for active clients
                local clients = vim.lsp.get_clients({ bufnr = vim.api.nvim_get_current_buf() })
                local client_names = {}
                for _, client in ipairs(clients) do
                    if client.name ~= "null-ls" and client.name ~= "copilot" then
                        table.insert(client_names, client.name)
                    end
                end

                if #client_names > 0 then
                    return "󱜙 [" .. table.concat(client_names, ", ") .. "]"
                else
                    return "󱚧 No Active LSP"
                end
            end
        })
        return progress
    end,
    color = { fg = colors.blue, gui = "bold" },
}

-- File location component
local file_location = {
    function()
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
    end,
}

-- CWD component
local cwd_component = {
    function()
        local cwd = vim.uv.cwd() or vim.fn.getcwd()
        local home = vim.env.HOME or vim.env.USERPROFILE or ""
        if cwd:find(home, 1, true) == 1 then
            cwd = "~" .. cwd:sub(#home + 1)
        end
        return icons.ui.FolderWithHeart .. cwd
    end,
    color = { fg = colors.subtext0, gui = "bold" },
}

-- Separator component
local separator = {
    function()
        return "│"
    end,
    padding = 0,
    color = { fg = colors.surface1 },
}

-- Python venv component
local python_venv = {
    function()
        if vim.bo.filetype == "python" then
            local venv = vim.env.CONDA_DEFAULT_ENV or vim.env.VIRTUAL_ENV
            if venv then
                local final_venv = venv:match("([^/\\]+)$") or venv
                return icons.misc.PyEnv .. final_venv
            end
        end
        return ""
    end,
    color = { fg = colors.green },
    cond = has_enough_room,
}

-- Tab width component
local tabwidth = {
    function()
        return icons.ui.Tab .. vim.bo.tabstop
    end,
    padding = 1,
}

lualine.setup({
    options = {
        icons_enabled = true,
        theme = custom_theme(),
        disabled_filetypes = { statusline = { "alpha", "dashboard", "starter" } },
        component_separators = "",
        section_separators = { left = "", right = "" },
    },
    sections = {
        lualine_a = { "mode" },
        lualine_b = {
            {
                "filetype",
                colored = true,
                icon_only = false,
                icon = { align = "left" },
            },
            file_status,
        },
        lualine_c = {
            {
                "branch",
                icon = icons.git.Branch,
                color = { fg = colors.subtext0, gui = "bold" },
                cond = has_git,
            },
            {
                "diff",
                symbols = {
                    added = icons.git.Add,
                    modified = icons.git.Mod,
                    removed = icons.git.Remove,
                },
                source = diff_source,
                colored = false,
                color = { fg = colors.subtext0 },
                cond = has_git,
                padding = { right = 1 },
            },
            {
                function()
                    return "%="
                end,
            },
            {
                "diagnostics",
                sources = { "nvim_diagnostic" },
                sections = { "error", "warn", "info", "hint" },
                symbols = {
                    error = icons.diagnostics.Error,
                    warn = icons.diagnostics.Warning,
                    info = icons.diagnostics.Information,
                    hint = icons.diagnostics.Hint,
                },
            },
            lsp_component,
        },
        lualine_x = {
            {
                "encoding",
                show_bomb = true,
                fmt = string.upper,
                padding = { left = 1 },
                cond = has_enough_room,
            },
            {
                "fileformat",
                symbols = {
                    unix = "LF",
                    dos = "CRLF",
                    mac = "CR",
                },
                padding = { left = 1 },
            },
            tabwidth,
        },
        lualine_y = {
            separator,
            python_venv,
            cwd_component,
        },
        lualine_z = { file_location },
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
    extensions = { "nvim-tree", "lazy" },
})
