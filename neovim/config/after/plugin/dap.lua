local function get_tags()
    return coroutine.create(function(dap_run_co)
        local tags = ""
        vim.ui.input({ prompt = "Tags: " }, function(input)
            tags = "-tags=" .. input
            coroutine.resume(dap_run_co, tags)
        end)
    end)
end

require('dap-go').setup({
    delve = {
        build_flags = "-tags=unit,integration",
    },
    dap_configurations = {
        {
            type = "go",
            name = "Debug (Build Flags)",
            request = "launch",
            program = "${file}",
            buildFlags = require("dap-go").get_build_flags,
        },
        {
            type = "go",
            name = "Debug (Tags)",
            request = "launch",
            program = "${file}",
            buildFlags = get_tags,
        },
    },
})

local dap, dapui = require("dap"), require("dapui")

require("dapui").setup({
    controls = {
        element = "repl",
        enabled = true,
        icons = {
            disconnect = "",
            pause = "",
            play = "",
            run_last = "",
            step_back = "",
            step_into = "",
            step_out = "",
            step_over = "",
            terminate = ""
        }
    },
    element_mappings = {},
    expand_lines = true,
    floating = {
        border = "single",
        mappings = {
            close = { "q", "<Esc>" }
        }
    },
    force_buffers = true,
    icons = {
        collapsed = "",
        current_frame = "",
        expanded = ""
    },
    layouts = {
        {
            elements = {
                {
                    id = "breakpoints",
                    size = 0.16
                },
                {
                    id = "stacks",
                    size = 0.16
                },
                {
                    id = "repl",
                    size = 0.16
                },
                {
                    id = "console",
                    size = 0.17
                },
                {
                    id = "watches",
                    size = 0.16
                },
            },
            position = "left",
            size = 40
        },
        {
            elements = {
                {
                    id = "scopes",
                    size = 1
                },
            },
            position = "bottom",
            size = 20
        }
    },
    mappings = {
        edit = "e",
        expand = { "<CR>", "<2-LeftMouse>" },
        open = "o",
        remove = "d",
        repl = "r",
        toggle = "t"
    },
    render = {
        indent = 1,
        max_value_lines = 100
    }
})

dap.listeners.before.attach.dapui_config = function()
    dapui.open()
end
dap.listeners.before.launch.dapui_config = function()
    dapui.open()
end
-- dap.listeners.before.event_terminated.dapui_config = function()
--     dapui.close()
-- end
-- dap.listeners.before.event_exited.dapui_config = function()
--     dapui.close()
-- end


vim.keymap.set('n', '<F1>', require 'dap'.continue)
vim.keymap.set('n', '<F2>', require 'dap'.step_out)
vim.keymap.set('n', '<F3>', require 'dap'.step_over)
vim.keymap.set('n', '<F4>', require 'dap'.step_into)
vim.keymap.set('n', '<leader>db', require 'dap'.toggle_breakpoint, { desc = 'Toggle (D)ebugging (B)reakpoint' })
vim.keymap.set(
    'n',
    '<Leader>dl',
    function() require('dap').set_breakpoint(nil, nil, vim.fn.input('Log point message: ')) end,
    { desc = 'Set (D)ebugging (L)ogpoint' }
)
vim.keymap.set('n', '<leader>de', require 'dapui'.close, { desc = '(D)ebugging ui (E)xit' })

-- debugs the nearest go test
vim.keymap.set('n', '<leader>dgt', function()
    require('dap-go').debug_test()
end)
-- debug the last go test
vim.keymap.set('n', '<leader>dgl', function()
    require('dap-go').debug_last()
end)

require("nvim-dap-virtual-text").setup()
