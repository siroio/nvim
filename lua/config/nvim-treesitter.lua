vim.g.ts_install = {
    "lua",
    "vimdoc",
    "markdown",
}

local ts_install = vim.g.ts_install or {}
local ts_filetypes = vim
    .iter(ts_install)
    :map(function(lang)
        return vim.treesitter.language.get_filetypes(lang)
    end)
    :flatten()
    :totable()

-- Also include norg (manually built, not via nvim-treesitter install)
table.insert(ts_filetypes, "norg")

require("nvim-treesitter").install(ts_install)

vim.api.nvim_create_autocmd("FileType", {
    desc = "Setup treesitter for a buffer",
    pattern = ts_filetypes,
    group = vim.api.nvim_create_augroup("ts_setup", { clear = true }),
    callback = function(e)
        vim.treesitter.start(e.buf)
        vim.wo.foldmethod = "expr"
        vim.wo.foldexpr = "v:lua.vim.treesitter.foldexpr()"
        vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
        -- Force injections to resolve (e.g. norg-meta injection inside @document.meta)
        local ok, parser = pcall(vim.treesitter.get_parser, e.buf)
        if ok and parser then
            parser:parse(true)
        end
        -- Enable conceal for norg
        if vim.bo[e.buf].filetype == "norg" then
            vim.wo.conceallevel = 2
            vim.wo.concealcursor = "nc"
        end
    end,
})
