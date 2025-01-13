-- A set of custom vim commands

local delete_trailing_whitespace = function()
    local saved_view = vim.fn.winsaveview()
    vim.cmd([[keeppatterns %s/\s\+$//e]])
    vim.fn.winrestview(saved_view)
end

vim.api.nvim_create_user_command('DeleteTrailingWhitespace', delete_trailing_whitespace, {})

local uuid = function()
    assert(vim.fn.executable('uuidgen') == 1, 'uuidgen is not installed')
    local uuid = vim.fn.system('uuidgen'):gsub('\n', '')
    vim.fn.setreg('+', uuid)
    vim.cmd('put +')
end

vim.api.nvim_create_user_command('Uuid', uuid, {})

local yank_uuid = function()
    assert(vim.fn.executable('uuidgen') == 1, 'uuidgen is not installed')
    local uuid = vim.fn.system('uuidgen'):gsub('\n', '')
    local reg = '"'
    vim.fn.setreg(reg, uuid)
    print('UUID copied to register ' .. reg)
end

vim.api.nvim_create_user_command('YankUuid', yank_uuid, {})

local scratch = function()
    vim.cmd([[enew]])
    vim.cmd([[noswapfile hide enew]])
    vim.cmd([[setlocal buftype=nofile]])
    vim.cmd([[setlocal bufhidden=hide]])
    vim.cmd([["setlocal nobuflisted]])
    vim.cmd([["lcd ~]])
    vim.cmd([[file scratch]])
end

vim.api.nvim_create_user_command('Scratch', scratch, {})
