require("nvim-tree").setup({
    view = {
        width = 50,
    },
})

vim.keymap.set("n", "<C-e>", "<cmd>NvimTreeFindFileToggle<cr>")
vim.keymap.set("n", "<leader>e", "<cmd>NvimTreeToggle<cr>")
