local ok_mason, mason_lspconfig = pcall(require, "mason-lspconfig")

local capabilities = vim.lsp.protocol.make_client_capabilities()

local ok_blink, blink = pcall(require, "blink.cmp")
if ok_blink then
    capabilities = vim.tbl_deep_extend(
        "force",
        capabilities,
        blink.get_lsp_capabilities()
    )
end

local function on_attach(client, bufnr)
    local opts = { buffer = bufnr, silent = true, noremap = true }

    vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
    vim.keymap.set("n", "gr", vim.lsp.buf.references, opts)
    vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
    vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)
    vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, opts)
    vim.keymap.set("n", "<leader>f", function()
        vim.lsp.buf.format({ async = true })
    end, opts)
end

vim.lsp.config("*", {
    capabilities = capabilities,
    on_attach = on_attach,
})

vim.lsp.config("lua_ls", {
    settings = {
        Lua = {
            diagnostics = {
                globals = { "vim" },
            },
            workspace = {
                checkThirdParty = false,
            },
        },
    },
})

if ok_mason then
    mason_lspconfig.setup()

    local servers = mason_lspconfig.get_installed_servers()
    for _, server in ipairs(servers) do
        vim.lsp.enable(server)
    end
else
    vim.lsp.enable("lua_ls")
end

