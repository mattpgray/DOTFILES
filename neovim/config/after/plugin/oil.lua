local file_is_set = function()
    return vim.api.nvim_buf_get_name(0) == ""
end

-- Stops a scratch buffer from being created when neovim is opened without a file provided, which
-- has its pros and cons.
if file_is_set() then
    vim.cmd [[silent edit .]]
end

local oil = require('oil')

vim.keymap.set("n", "-", oil.open, { desc = "Open parent directory" })

oil.setup({
    columns = {
        "icon",
        "permissions",
        "size",
        "mtime",
    },
    view_options = {
        -- Show files and directories that start with "."
        show_hidden = true,
    }
})
