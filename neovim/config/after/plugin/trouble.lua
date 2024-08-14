require('which-key').register({
    ["<leader>"] = {
        {
            t = {
                name = "+trouble",
                s = { '+set' },
            },
        },
    },
})

local trouble = require("trouble");

vim.keymap.set("n", "<leader>tt", "<cmd>Trouble diagnostics toggle<cr>",
    { silent = true, noremap = true, desc = "(T)rouble (T)oggle"}
)
vim.keymap.set("n", "<leader>tw", "<cmd>TroubleToggle workspace_diagnostics<cr>",
    { silent = true, noremap = true, desc = "(T)rouble (W)orkspace diagnostics" }
)
vim.keymap.set("n", "<leader>td", "<cmd>TroubleToggle document_diagnostics<cr>",
    { silent = true, noremap = true, desc = "(T)rouble (D)ocument diagnostics" }
)
vim.keymap.set("n", "<leader>tll", "<cmd>TroubleToggle loclist<cr>",
    { silent = true, noremap = true, desc = "(T)rouble (L)loc (L)list" }
)
vim.keymap.set("n", "<leader>tq", "<cmd>TroubleToggle quickfix<cr>",
    { silent = true, noremap = true, desc = "(T)rouble (Q)uickfix" }
)
vim.keymap.set("n", "<leader>tr", "<cmd>TroubleToggle lsp_references<cr>",
    { silent = true, noremap = true, desc = "(T)rouble (R)references" }
)

trouble.setup({
    cmd = "Trouble"
})

local set_diagnostic = function(keymap, severity, desc_suffix)
    vim.keymap.set("n", keymap, function()
            trouble.setup({ severity = severity })
            trouble.refresh()
        end,
        { silent = true, noremap = true, desc = '(T)rouble (S)et level ' .. desc_suffix})
end

set_diagnostic("<leader>tsd", nil, '(D)iagnostic') -- all diagnostics
set_diagnostic("<leader>tse", vim.diagnostic.severity.ERROR, '(E)rror' )
set_diagnostic("<leader>tsw", vim.diagnostic.severity.WARN, '(W)arn')
set_diagnostic("<leader>tsi", vim.diagnostic.severity.INFO, '(I)nfo')

vim.keymap.set("n", "<leader>[d", function()
        trouble.next({ skip_groups = true, jump = true });
    end,
    { silent = true, noremap = true,}
)
vim.keymap.set("n", "<leader>]d", function()
        trouble.prev({ skip_groups = true, jump = true });
    end,
    { silent = true, noremap = true }
)
vim.keymap.set("n", "<leader>[f", function()
        trouble.first({ skip_groups = true, jump = true });
    end,
    { silent = true, noremap = true }
)
vim.keymap.set("n", "<leader>]l", function()
        trouble.prev({ skip_groups = true, jump = true });
    end,
    { silent = true, noremap = true }
)
