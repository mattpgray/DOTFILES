vim.keymap.set('i', '<C-L>', 'copilot#Accept("\\<CR>")', {
    expr = true,
    replace_keycodes = false
})
vim.g.copilot_no_tab_map = true

vim.api.nvim_create_autocmd('ColorScheme', {
  pattern = 'dracula',
  -- group = ...,
  callback = function()
    vim.api.nvim_set_hl(0, 'CopilotSuggestion', {
      fg = '#ffffff',
      ctermfg = 8,
      force = true
    })
  end
})
