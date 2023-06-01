require("nvim-tree").setup({
    view = {
        width = 50,
    },
    git = {
        -- I prefer to be able to see my ignored files by default.
        ignore = false,
    },
})

vim.keymap.set("n", "<C-e>", "<cmd>NvimTreeFindFileToggle<cr>")
vim.keymap.set("n", "<leader>e", "<cmd>NvimTreeToggle<cr>")
