-- keymap --

vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- config/options.lua
local opt = vim.opt

-- === 表示まわり ===
opt.termguicolors = true
opt.number = true          -- 行番号
opt.relativenumber = false -- 相対行番号
opt.signcolumn = "yes"     -- サインカラム常に表示
opt.cursorline = true      -- カーソル行ハイライト
opt.wrap = false           -- 行の折り返しなし
opt.scrolloff = 4          -- 上下に余白を残してスクロール
opt.winborder = "single"   -- Floating Windowにボーターをつける

-- === インデント / タブ設定 ===
opt.expandtab = true   -- Tab をスペースに変換
opt.shiftwidth = 4     -- 自動インデントの幅
opt.tabstop = 4        -- タブ幅（表示上）
opt.softtabstop = 4    -- <Tab>/<BS> の幅
opt.smartindent = true -- 波括弧などで賢くインデント

-- === 検索 ===
opt.ignorecase = true -- 小文字のみの検索で大文字小文字を無視
opt.smartcase = true  -- 大文字を含む検索では大文字小文字を区別
opt.incsearch = true  -- 入力しながらマッチをハイライト
opt.hlsearch = true   -- 検索結果をハイライト

-- === 分割ウィンドウ ===
opt.splitright = true -- 垂直分割は右に開く
opt.splitbelow = true -- 水平分割は下に開く

-- === 操作性 ===
opt.mouse = "a"               -- どのモードでもマウス使用可
opt.clipboard = "unnamedplus" -- システムクリップボード共有
opt.undofile = true           -- undo 履歴をファイル保存
opt.swapfile = false          -- swap ファイル無効（好み）

-- === パフォーマンス系 ===
opt.updatetime = 300 -- CursorHold などの発火までの時間
opt.timeoutlen = 400 -- マッピング待ち時間少し短め

-- === 透明背景ハイライト ===
-- vim.cmd([[
--     highlight Normal guibg=none
--     highlight NonText guibg=none
--     highlight Normal ctermbg=none
--     highlight NonText ctermbg=none
--     highlight NormalNC guibg=none
--     highlight NormalSB guibg=none
-- ]])
