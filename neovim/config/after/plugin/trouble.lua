vim.keymap.set("n", "<leader>tt", "<cmd>TroubleToggle<cr>",
    { silent = true, noremap = true }
)
vim.keymap.set("n", "<leader>tw", "<cmd>TroubleToggle workspace_diagnostics<cr>",
    { silent = true, noremap = true }
)
vim.keymap.set("n", "<leader>td", "<cmd>TroubleToggle document_diagnostics<cr>",
    { silent = true, noremap = true }
)
vim.keymap.set("n", "<leader>tll", "<cmd>TroubleToggle loclist<cr>",
    { silent = true, noremap = true }
)
vim.keymap.set("n", "<leader>tq", "<cmd>TroubleToggle quickfix<cr>",
    { silent = true, noremap = true }
)
vim.keymap.set("n", "gR", "<cmd>TroubleToggle lsp_references<cr>",
    { silent = true, noremap = true }
)

local trouble = require("trouble");


vim.keymap.set("n", "<leader>[d", function()
        trouble.next({ skip_groups = true, jump = true });
    end,
    { silent = true, noremap = true }
)
vim.keymap.set("n", "<leader>]d", function()
        trouble.prev({ skip_groups = true, jump = true });
    end,
    { silent = true, noremap = true }
)
vim.keymap.set("n", "<leader>[f", function()
        trouble.prev({ skip_groups = true, jump = true });
    end,
    { silent = true, noremap = true }
)
vim.keymap.set("n", "<leader>]l", function()
        trouble.prev({ skip_groups = true, jump = true });
    end,
    { silent = true, noremap = true }
)
