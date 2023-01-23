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

function GoVet(tag)
    local cache_makeprg= vim.opt.makeprg
    local cache_errorformat = vim.opt.errorformat
    vim.opt.makeprg = "go vet -tags \"" .. tag .. "\" ./..."
    vim.opt.errorformat = "vet: %f:%l:%c: %m, %f:%l:%c: %m"
    vim.cmd [[:make]]
    vim.opt.makeprg = cache_makeprg
    vim.opt.errorformat = cache_errorformat
end

function GoTest(tag)
    local cache_makeprg= vim.opt.makeprg
    local cache_errorformat = vim.opt.errorformat
    vim.opt.makeprg = "go test -tags \"" .. tag .. "\" ./..."
    vim.opt.errorformat = "%f:%l:%c: %m"
    vim.cmd [[:make]]
    vim.opt.makeprg = cache_makeprg
    vim.opt.errorformat = cache_errorformat
end

function GoImports()
    vim.cmd [[:!~/go/bin/goimports -w %]]
end

vim.keymap.set("n", "<leader>gi", GoImports, {silent = true})
vim.cmd [[autocmd BufWritePre *.go lua vim.lsp.buf.formatting_sync()]]

