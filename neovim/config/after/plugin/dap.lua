vim.keymap.set('n', '<leader>db', "<cmd> DapToggleBreakpoint <CR>")
vim.keymap.set('n', '<leader>dus', function ()
    local widgets = require('dap.ui.widgets')
    local sidebar = widgets.sidebar(widgets.scopes);
    sidebar.open()
end)

vim.keymap.set('n', '<leader>do', "<cmd> DapStepOver <CR>")
vim.keymap.set('n', '<leader>di', "<cmd> DapStepInto <CR>")
vim.keymap.set('n', '<leader>de', "<cmd> DapStepOut <CR>")
vim.keymap.set('n', '<leader>dc', "<cmd> DapContinue <CR>")

require('dap-go').setup({
    delve = {
        build_flags = "-tags=unit,integration",
    }
})
-- debugs the nearest go test
vim.keymap.set('n', '<leader>dgt', function ()
    require('dap-go').debug_test()
end)
-- debug the last go test
vim.keymap.set('n', '<leader>dgl', function ()
    require('dap-go').debug_last()
end)

