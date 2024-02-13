local telescope = require('telescope')
local builtin = require('telescope.builtin')
local actions = require('telescope.actions')
vim.keymap.set('n', '<leader>pf', function()
    builtin.find_files({
        hidden = true,
    })
end, {})
vim.keymap.set('n', '<leader>pi', function()
    builtin.find_files({
        prompt_title = 'find all files including hidden and ignore and following symlinks',
        hidden = true,
        no_ignore = true,
        no_ignore_parent = true,
        follow = true,
    })
end, {})
vim.keymap.set('n', '<leader>gf', builtin.git_files, {})
vim.keymap.set('n', '<leader>fg', function()
    builtin.live_grep({
        vimgrep_arguments = {
            'rg',
            '--color=never',
            '--no-heading',
            '--with-filename',
            '--line-number',
            '--column',
            '--smart-case',
            '--hidden', -- Normally, I want .dot files to show up in the search if they are checked in.
            '--glob', '!.git/', -- The exception to the above rule is .git folders
        }
    })
end, {})

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
            '--hidden',
            '-u'        -- This allows for searching in ignored files. It means "unrestricted".
        }
    })
end, {})
vim.keymap.set('n', '<leader>ps', function()
    builtin.grep_string({ search = vim.fn.input("Grep > ") });
end)
vim.keymap.set('n', '<leader>pb', builtin.buffers, {})
vim.keymap.set('n', '<leader>pp', builtin.pickers, {})
vim.keymap.set('n', '<leader>pr', builtin.lsp_references, {})

telescope.setup {
    defaults = {
        -- Default configuration for telescope goes here:
        -- config_key = value,
        mappings = {
            n = {
                ['<c-d>'] = actions.delete_buffer
            },
            i = {
                ["<C-h>"] = "which_key",
                ['<c-d>'] = actions.delete_buffer
            }
        }
    },
}
