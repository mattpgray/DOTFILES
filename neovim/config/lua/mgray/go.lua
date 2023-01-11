function SetGoTag(tag)
    require('lspconfig')['gopls'].setup {
        settings = {
            ["gopls"] = {
                buildFlags = { "-tags=" .. tag },
            }
        }
    }
end

vim.cmd [[autocmd BufWritePre *.go lua vim.lsp.buf.formatting_sync()]]

