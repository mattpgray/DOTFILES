local builtin = require('telescope.builtin')
vim.keymap.set('n', '<leader>pf', builtin.find_files, {})
vim.keymap.set('n', '<leader>pi', function()
    builtin.find_files({ no_ignore = true })
end, {})
vim.keymap.set('n', '<C-p>', builtin.git_files, {})
vim.keymap.set('n', '<leader>fg', builtin.live_grep, {})
vim.keymap.set('n', '<leader>fi', builtin.live_grep, {})
vim.keymap.set('n', '<leader>fi', function()
    builtin.live_grep({
        vimgrep_arguments = {
            'rg',
            '--color=never',
            '--no-heading',
            '--with-filename',
            '--line-number',
            '--column',
            '--smart-case',
            '-u' -- This allows for searching in ignored files. It means "unrestricted".
        }
    })
end, {})
vim.keymap.set('n', '<leader>ps', function()
    builtin.grep_string({ search = vim.fn.input("Grep > ") });
end)
