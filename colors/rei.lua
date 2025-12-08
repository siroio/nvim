-- Ayanami Blue inspired palette
local palette = {
    bg = "#050912",
    panel = "#0a1220",
    panel_alt = "#111a2c",
    fg = "#e5edf7",
    muted = "#8fa1c0",
    blue = "#0077cc",
    blue_alt = "#4ca5ff",
    cyan = "#63d8ff",
    purple = "#bfc8ff",
    red = "#ff6b81",
    amber = "#f2d27a",
    green = "#7adab0",
}

local function hex_to_rgb(hex)
    hex = hex:gsub("#", "")
    return {
        tonumber(hex:sub(1, 2), 16),
        tonumber(hex:sub(3, 4), 16),
        tonumber(hex:sub(5, 6), 16),
    }
end

local function blend(fg, bg, alpha)
    if not fg or not bg then
        return fg
    end
    local f = hex_to_rgb(fg)
    local b = hex_to_rgb(bg)
    local function channel(i)
        return math.floor((alpha * f[i]) + ((1 - alpha) * b[i]) + 0.5)
    end
    return string.format("#%02x%02x%02x", channel(1), channel(2), channel(3))
end

local function set(group, opts)
    vim.api.nvim_set_hl(0, group, opts)
end

vim.cmd("highlight clear")
if vim.fn.exists("syntax_on") == 1 then
    vim.cmd("syntax reset")
end
vim.o.termguicolors = true
vim.o.background = "dark"
vim.g.colors_name = "rei"

local transparent = vim.g.rei_transparent == true
local bg = transparent and "none" or palette.bg
local panel = transparent and "none" or palette.panel
local panel_alt = transparent and "none" or palette.panel_alt
local cursorline = blend(palette.panel_alt, palette.bg, 0.65)
local visual_bg = blend(palette.blue_alt, palette.bg, 0.25)
local search_bg = blend(palette.amber, palette.bg, 0.55)
local pmenu_sel = blend(palette.blue_alt, palette.bg, 0.5)

set("Normal", { fg = palette.fg, bg = bg })
set("NormalFloat", { fg = palette.fg, bg = panel })
set("FloatBorder", { fg = palette.blue, bg = panel })
set("SignColumn", { bg = panel, fg = palette.muted })
set("LineNr", { fg = palette.muted, bg = panel })
set("CursorLine", { bg = cursorline })
set("CursorLineNr", { fg = palette.amber, bold = true })
set("Visual", { bg = visual_bg })
set("Search", { bg = search_bg, fg = palette.bg, bold = true })
set("IncSearch", { bg = palette.amber, fg = palette.panel, bold = true })
set("StatusLine", { fg = palette.fg, bg = panel })
set("StatusLineNC", { fg = palette.muted, bg = panel_alt })
set("WinSeparator", { fg = palette.panel_alt, bg = panel })
set("Pmenu", { fg = palette.fg, bg = panel })
set("PmenuSel", { fg = palette.panel, bg = pmenu_sel })
set("PmenuSbar", { bg = palette.panel_alt })
set("PmenuThumb", { bg = palette.blue_alt })
set("NormalSB", { fg = palette.fg, bg = panel })
set("VertSplit", { fg = palette.panel_alt, bg = panel })

set("Comment", { fg = palette.muted, italic = true })
set("Constant", { fg = palette.amber })
set("String", { fg = blend(palette.cyan, palette.fg, 0.45) })
set("Character", { link = "String" })
set("Number", { fg = palette.red })
set("Boolean", { fg = palette.red })
set("Identifier", { fg = palette.cyan })
set("Function", { fg = palette.blue })
set("Statement", { fg = palette.blue_alt, bold = true })
set("Keyword", { fg = palette.blue_alt })
set("Conditional", { link = "Keyword" })
set("Repeat", { link = "Keyword" })
set("Operator", { fg = palette.purple })
set("Type", { fg = palette.purple, bold = true })
set("Special", { fg = palette.green })
set("Todo", { fg = palette.amber, bg = panel_alt, bold = true })

set("DiagnosticError", { fg = palette.red })
set("DiagnosticWarn", { fg = palette.amber })
set("DiagnosticInfo", { fg = palette.blue })
set("DiagnosticHint", { fg = palette.cyan })
set("DiagnosticUnderlineError", { sp = palette.red, undercurl = true })
set("DiagnosticUnderlineWarn", { sp = palette.amber, undercurl = true })
set("DiagnosticUnderlineInfo", { sp = palette.blue, undercurl = true })
set("DiagnosticUnderlineHint", { sp = palette.cyan, undercurl = true })
set("DiagnosticVirtualTextError", { fg = palette.red })
set("DiagnosticVirtualTextWarn", { fg = palette.amber })
set("DiagnosticVirtualTextInfo", { fg = palette.blue })
set("DiagnosticVirtualTextHint", { fg = palette.cyan })

set("DiffAdd", { bg = blend(palette.green, palette.bg, 0.2), fg = palette.green })
set("DiffChange", { bg = blend(palette.amber, palette.bg, 0.15), fg = palette.amber })
set("DiffDelete", { bg = blend(palette.red, palette.bg, 0.15), fg = palette.red })
set("DiffText", { bg = blend(palette.blue, palette.bg, 0.35), fg = palette.fg, bold = true })

set("GitSignsAdd", { fg = palette.green })
set("GitSignsChange", { fg = palette.amber })
set("GitSignsDelete", { fg = palette.red })

set("MatchParen", { fg = palette.amber, bold = true, underline = true })
set("NonText", { fg = palette.muted })
set("Whitespace", { fg = palette.panel_alt })
set("ColorColumn", { bg = palette.panel_alt })

set("LspReferenceText", { bg = blend(palette.blue, palette.bg, 0.2) })
set("LspReferenceRead", { bg = blend(palette.blue, palette.bg, 0.2) })
set("LspReferenceWrite", { bg = blend(palette.blue_alt, palette.bg, 0.2) })
set("LspSignatureActiveParameter", { fg = palette.amber, underline = true })

set("TelescopeNormal", { fg = palette.fg, bg = panel })
set("TelescopeBorder", { fg = palette.panel_alt, bg = panel })
set("TelescopeSelection", { bg = pmenu_sel })
set("TelescopeMatching", { fg = palette.blue_alt, bold = true })
set("TelescopePromptPrefix", { fg = palette.blue })
