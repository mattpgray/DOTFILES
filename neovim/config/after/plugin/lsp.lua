local lsp = require('lsp-zero')
lsp.preset('recommended')

-- Fix Undefined global 'vim'
lsp.configure('lua_ls', {
    settings = {
        Lua = {
            diagnostics = {
                globals = { 'vim' }
            }
        }
    }
})

lsp.ensure_installed({
    'lua_ls',
    'rust_analyzer'
})

local cmp = require('cmp')
local cmp_select = { behavior = cmp.SelectBehavior.Select }
local cmp_mappings = lsp.defaults.cmp_mappings({
    ['<C-p>'] = cmp.mapping.select_prev_item(cmp_select),
    ['<C-n>'] = cmp.mapping.select_next_item(cmp_select),
    ['<C-y>'] = cmp.mapping.confirm({ select = true }),
    ["<C-Space>"] = cmp.mapping.complete(),
})

lsp.setup_nvim_cmp({
    mapping = cmp_mappings
})

function OnAttach(_client, bufnr)
    local opts = { buffer = bufnr, remap = false }

    vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
    vim.keymap.set("n", "gD", vim.lsp.buf.declaration, opts)
    vim.keymap.set("n", "gs", vim.lsp.buf.signature_help, opts)
    vim.keymap.set("n", "gI", vim.lsp.buf.implementation, opts)
    vim.keymap.set("n", "gt", vim.lsp.buf.type_definition, opts)
    vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
    vim.keymap.set("n", "<leader>ws", vim.lsp.buf.workspace_symbol, opts)
    vim.keymap.set("n", "<leader>vd", vim.diagnostic.open_float, opts)
    vim.keymap.set("n", "[d", vim.diagnostic.goto_next, opts)
    vim.keymap.set("n", "]d", vim.diagnostic.goto_prev, opts)
    vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, opts)
    vim.keymap.set("n", "<leader>rr", vim.lsp.buf.references, opts)
    vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)
    vim.keymap.set("i", "<C-h>", vim.lsp.buf.signature_help, opts)
end

lsp.on_attach(OnAttach)

lsp.setup()

local cfg = { bind = true }
require "lsp_signature".setup(cfg)

vim.diagnostic.config({
    -- This seems to be too slow unfortunately.
    -- update_in_insert = true,
    virtual_text = true
})

local null_ls = require('null-ls')
local cspell = require('cspell')
local fn = vim.fn

local cspell_file = os.getenv("HOME") .. "/.cspell.json"
local f = io.open(cspell_file, "r")
if f ~= nil then
    io.close(f)
else
    print(string.format("Creating new cspell file at %s", cspell_file))
    f = io.open(cspell_file, "w")
    assert(f ~= nil, string.format("Could not open file for writing %s", cspell_file))
    f:write("{}")
    f:close()
end

local cspell_config = {
    find_json = function(cwd)
        return cspell_file
    end,
}

null_ls.setup({
    sources = {
        cspell.diagnostics.with({ config = cspell_config }),
        cspell.code_actions.with({ config = cspell_config }),
    }
})
