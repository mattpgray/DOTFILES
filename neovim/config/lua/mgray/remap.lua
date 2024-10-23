-- Allows for highlighted lines to be moved with J and K
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")

-- Keeps the cursor in the same place when using J in normal mode
vim.keymap.set("n", "J", "mzJ`z")

-- Keep the cursor in the middle of the screen when navigating with <C-d> and <C-u>
vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")

-- Keep search terms in the middle of the screen
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")

-- Allow for pasting over text with the yanked buffer without overwriting it.
vim.keymap.set("x", "<leader>p", "\"_dP")

-- Copy to the system clipboard
vim.keymap.set("n", "<leader>y", "\"+y")
vim.keymap.set("v", "<leader>y", "\"+y")
vim.keymap.set("n", "<leader>Y", "\"+Y")

-- Allow for deletion without copying
vim.keymap.set("n", "<leader>d", "\"_d")
vim.keymap.set("v", "<leader>d", "\"_d")

-- Do not allow entering Ex mode
vim.keymap.set("n", "Q", "<nop>")

-- Allow for switching project quickly. Not used for now.
-- vim.keymap.set("n", "<C-f>", "<cmd>silent !tmux neww tmux-sessionizer<CR>")

-- Formatting with <leader>f
vim.keymap.set("n", "<leader>f", function()
    vim.lsp.buf.format()
end)

-- Navigating the items of the quickfix list
-- TODO: This conflicts with the tmux plugin
vim.keymap.set("n", "]q", "<cmd>cnext<CR>zz")
vim.keymap.set("n", "[q", "<cmd>cprev<CR>zz")
vim.keymap.set("n", "]a", "<cmd>lnext<CR>zz")
vim.keymap.set("n", "[a", "<cmd>lprev<CR>zz")

-- Replace the current word in the entire buffer
vim.keymap.set("n", "<leader>s", [[:%sno/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]])
-- Replace the current selection in the entire buffer. Does not work when selection contains '<>'
vim.keymap.set("v", "<leader>s", [["hy:%sno/\<<C-r>h\>/<C-r>h/gI<Left><Left><Left>]])

-- Set the current file to executable
vim.keymap.set("n", "<leader>x", "<cmd>!chmod +x %<CR>", { silent = true })

-- Slightly better horizontal scrolling for long lines without needing to go by word or char
vim.keymap.set("n", "<C-l>", "20zl")
vim.keymap.set("n", "<C-h>", "20zh")

-- Allow for switching out of terminals and exiting terminal mode easily
-- Why aren't these the defaults?
vim.keymap.set('t', '<esc>', [[<C-\><C-n>]], { noremap = true })
vim.keymap.set('t', '<C-w>', [[<C-\><C-n><C-w>]], { noremap = true })
