require('which-key').add({
    -- ["<leader>p"] = { group = "picker" },
    -- ["<leader>f"] = { group = "file" }
    { "<leader>f", group = "file" },
    { "<leader>p", group = "picker" },
})

local telescope = require('telescope')
local builtin = require('telescope.builtin')
local actions = require('telescope.actions')
vim.keymap.set('n', '<leader>pf', function()
    builtin.find_files({
        hidden = true,
    })
end, { desc = '(P)ick (F)ile' })
vim.keymap.set('n', '<leader>pi', function()
    builtin.find_files({
        prompt_title = 'find all files including hidden and ignore and following symlinks',
        hidden = true,
        no_ignore = true,
        no_ignore_parent = true,
        follow = true,
    })
end, { desc = '(P)ick file with (I)gnored' })
vim.keymap.set('n', '<leader>gf', builtin.git_files, { desc = '(G)it (F)iles' })
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
            '--hidden',         -- Normally, I want .dot files to show up in the search if they are checked in.
            '--glob', '!.git/', -- The exception to the above rule is .git folders
        }
    })
end, { desc = '(F)ile (G)rep' })

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
            '-u' -- This allows for searching in ignored files. It means "unrestricted".
        }
    })
end, { desc = '(F)ile grep with (I)gnored' })
vim.keymap.set('n', '<leader>ps', function()
    builtin.grep_string({ search = vim.fn.input("Grep > ") });
end, { desc = 'static file grep' })
vim.keymap.set('n', '<leader>pb', builtin.buffers, { desc = '(P)ick (B)uffers' })
vim.keymap.set('n', '<leader>pp', builtin.pickers, { desc = '(P)ick (P)ickers' })
vim.keymap.set('n', '<leader>pr', function()
    -- the default settings truncate the file path. The preview contains the contents, so I think
    -- being able to see the file path is more useful.
    builtin.lsp_references({ show_line = false })
end, { desc = '(P)ick (R)eferences' })
vim.keymap.set('n', '<leader>pm', builtin.marks, { desc = '(P)ick (M)arks' })
vim.keymap.set('n', '<leader>pc', builtin.current_buffer_fuzzy_find , { desc = '(P)ick (C)urrent buffer fuzzy' })
vim.keymap.set('n', '<leader>pt', builtin.builtin , { desc = '(P)ick (T)elescope builtin pickers' })

-- This function is a copy of the default buffer_previewer_maker, but it only
-- previews files that are less than 100kb.
local previewers = require('telescope.previewers')

-- Skipping highlighting on preview on large js files as it causes nvim to freeze for several
-- seconds.
--
-- https://github.com/nvim-telescope/telescope.nvim/issues/623#issuecomment-792233601
local _bad = { '.*%.standalone.js', '.*%.min.js' }
local bad_files = function(filepath)
    for _, v in ipairs(_bad) do
        if filepath:match(v) then
            return false
        end
    end

    return true
end

local new_maker = function(filepath, bufnr, opts)
    opts = opts or {}
    if opts.use_ft_detect == nil then opts.use_ft_detect = true end
    opts.use_ft_detect = opts.use_ft_detect == false and false or bad_files(filepath)
    previewers.buffer_previewer_maker(filepath, bufnr, opts)
end

require('telescope').setup {
    defaults = {
        buffer_previewer_maker = new_maker,
    }
}

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
        },
        buffer_previewer_maker = new_maker,
        cache_picker = {
            num_pickers = 50,
            limit_entries = 1000
        },
    },
}

telescope.load_extension("live_grep_args")

vim.keymap.set("n", "<leader>fa", ":lua require('telescope').extensions.live_grep_args.live_grep_args()<CR>",
    { desc = "(F)ile grep with (A)rgs" })
