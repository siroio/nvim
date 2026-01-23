local ok, blink = pcall(require, "blink.cmp")
if not ok then
    return
end

-- lspkind integration
local lspkind_ok, lspkind = pcall(require, "lspkind")
local kind_icons = nil
if lspkind_ok then
    kind_icons = lspkind.symbol_map or lspkind.presets.default
end

blink.setup({
    snippets = {
        preset = "vsnip",
    },

    appearance = {
        use_nvim_cmp_as_default = false,
        nerd_font_variant = "mono",
        kind_icons = kind_icons,
    },

    keymap = {
        preset = "enter",

        ['<C-Space>'] = { 'show', 'fallback' },

        -- Enterで補完確定
        ['<CR>'] = { 'accept', 'fallback' },

        -- Tabで次の候補に移動
        ['<Tab>'] = {
            function(cmp)
                if cmp.snippet_active() then
                    return cmp.snippet_forward()
                end

                if cmp.is_menu_visible() then
                    return cmp.select_next()
                end

                return true
            end,
            'fallback',
        },

        -- Shift+Tabで前の候補に移動
        ['<S-Tab>'] = {
            function(cmp)
                if cmp.snippet_active() then
                    return cmp.snippet_backward()
                end

                if cmp.is_menu_visible() then
                    return cmp.select_prev()
                end

                return true
            end,
            'fallback',
        },

        ['<C-e>'] = false
    },

    completion = {
        accept = {
            auto_brackets = {
                enabled = true,
            },
        },
        menu = {
            border = "rounded",
            draw = {
                treesitter = { "lsp" },
            },
        },
        documentation = {
            auto_show = true,
            auto_show_delay_ms = 200,
            window = { border = "single" },
        },
        ghost_text = {
            enabled = true,
        },
    },

    signature = {
        enabled = true,
        window = { border = "rounded" },
    },

    sources = {
        default = { "lsp", "path", "snippets", "buffer" },
    },

    cmdline = {
        enabled = true,
        keymap = {
            preset = "cmdline",
        },
        completion = {
            list = {
                selection = { preselect = false },
            },
            ghost_text = { enabled = true },
        },
    },
})
