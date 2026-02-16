require("mason-null-ls").setup({
    -- Masonでインストールするフォーマッター/リンターを指定
    ensure_installed = {
        -- "prettier",    -- JavaScript/TypeScript/HTML/CSS/JSON
        -- "stylua",      -- Lua
        -- "black",       -- Python
        -- "eslint_d",    -- JavaScript/TypeScript
        -- "shellcheck",  -- Shell
    },
    -- 自動セットアップ（none-lsのsourcesに自動登録）
    automatic_installation = true,
    handlers = {},
})
