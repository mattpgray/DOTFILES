require('dap-go').setup({
    delve = {
        build_flags = "-tags=unit,integration",
    }
})

local dap, dapui =require("dap"),require("dapui")

require("dapui").setup()

dap.listeners.before.attach.dapui_config = function()
  dapui.open()
end
dap.listeners.before.launch.dapui_config = function()
  dapui.open()
end
dap.listeners.before.event_terminated.dapui_config = function()
  dapui.close()
end
dap.listeners.before.event_exited.dapui_config = function()
  dapui.close()
end

vim.keymap.set('n', '<F1>', require 'dap'.continue)
vim.keymap.set('n', '<F2>', require 'dap'.step_out)
vim.keymap.set('n', '<F3>', require 'dap'.step_over)
vim.keymap.set('n', '<F4>', require 'dap'.step_into)
vim.keymap.set('n', '<leader>db', require 'dap'.toggle_breakpoint, { desc = 'Toggle (D)ebugging (B)reakpoint'})

-- debugs the nearest go test
vim.keymap.set('n', '<leader>dgt', function ()
    require('dap-go').debug_test()
end)
-- debug the last go test
vim.keymap.set('n', '<leader>dgl', function ()
    require('dap-go').debug_last()
end)

require("nvim-dap-virtual-text").setup()
