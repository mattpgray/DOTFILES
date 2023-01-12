function SetGoTag(tag)
    local lspconfig = require'lspconfig'
    lspconfig.gopls.setup{
        -- I am hoping this reattaches the shortcuts that I add at the start.
        on_attach = OnAttach,
        settings = {
            gopls =  {
                buildFlags =  {"-tags=" .. tag}
            }
        }
    }
end

vim.cmd [[autocmd BufWritePre *.go lua vim.lsp.buf.formatting_sync()]]

