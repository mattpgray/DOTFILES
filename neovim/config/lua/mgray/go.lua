function SetGoTag(tag)
end

function GoBuild(tag)
    os.execute("mkdir -p /tmp/go-build")
    local cache_makeprg = vim.opt.makeprg
    local cache_errorformat = vim.opt.errorformat
    vim.opt.makeprg = "go build -o /tmp/go-build -tags \"" .. tag .. "\" ./..."
    vim.opt.errorformat = "vet: %f:%l:%c: %m, %f:%l:%c: %m"
    vim.cmd [[:make]]
    vim.opt.makeprg = cache_makeprg
    vim.opt.errorformat = cache_errorformat
end

function GoVet(tag)
    local cache_makeprg = vim.opt.makeprg
    local cache_errorformat = vim.opt.errorformat
    vim.opt.makeprg = "go vet -tags \"" .. tag .. "\" ./..."
    vim.opt.errorformat = "vet: %f:%l:%c: %m, %f:%l:%c: %m"
    vim.cmd [[:make]]
    vim.opt.makeprg = cache_makeprg
    vim.opt.errorformat = cache_errorformat
end

function GoTest(tag)
    local cache_makeprg = vim.opt.makeprg
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

vim.keymap.set("n", "<leader>gi", GoImports, { silent = true })
vim.cmd [[autocmd BufWritePre *.go lua vim.lsp.buf.format()]]
