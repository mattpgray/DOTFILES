require("neodev").setup({
    library = { plugins = { "nvim-dap-ui" }, types = true },
})

-- inlay hints
-- vim.api.nvim_create_autocmd("LspAttach", {
--     group = vim.api.nvim_create_augroup("UserLspConfig", {}),
--     callback = function(args)
--         local client = vim.lsp.get_client_by_id(args.data.client_id)
--         if client.server_capabilities.inlayHintProvider then
--             vim.lsp.inlay_hint.enable(true, { bufnr = args.buf })
--         end
--         -- whatever other lsp config you want
--     end
-- })

local lsp = require('lsp-zero')
lsp.preset('recommended')

local lspkind = require 'lspkind'
lspkind.init {}

-- Fix Undefined global 'vim'
lsp.configure('lua_ls', {
    settings = {
        Lua = {
            completion = {
                callSnippet = "Replace"
            },
            diagnostics = {
                globals = { 'vim' }
            }
        }
    }
})

--  lsp.ensure_installed({
--      'pyright',
--      'lua_ls',
--      'rust_analyzer',
--      'gopls',
--  })


local goto_severity = function(goto_f, severity)
    return function()
        goto_f({ severity = severity })
    end
end

function OnAttach(client, bufnr)
    local opts = { buffer = bufnr, remap = false }

    vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
    vim.keymap.set("n", "gD", vim.lsp.buf.declaration, opts)
    vim.keymap.set("n", "gs", vim.lsp.buf.signature_help, opts)
    vim.keymap.set("n", "gI", vim.lsp.buf.implementation, opts)
    vim.keymap.set("n", "gt", vim.lsp.buf.type_definition, opts)
    vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
    vim.keymap.set("n", "<leader>ws", vim.lsp.buf.workspace_symbol, opts)
    vim.keymap.set("n", "<leader>vd", vim.diagnostic.open_float, opts)
    -- goto next or prev of any diagnostic
    vim.keymap.set("n", "]d", vim.diagnostic.goto_next, opts)
    vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, opts)
    -- goto next or prev of error diagnostic
    vim.keymap.set("n", "]e", goto_severity(vim.diagnostic.goto_next, vim.diagnostic.severity.ERROR), opts)
    vim.keymap.set("n", "[e", goto_severity(vim.diagnostic.goto_prev, vim.diagnostic.severity.ERROR), opts)
    -- goto next or prev of warning diagnostic
    vim.keymap.set("n", "]w", goto_severity(vim.diagnostic.goto_next, vim.diagnostic.severity.WARNING), opts)
    vim.keymap.set("n", "[w", goto_severity(vim.diagnostic.goto_prev, vim.diagnostic.severity.WARNING), opts)
    -- goto next or prev of info diagnostic
    vim.keymap.set("n", "]i", goto_severity(vim.diagnostic.goto_next, vim.diagnostic.severity.INFO), opts)
    vim.keymap.set("n", "[i", goto_severity(vim.diagnostic.goto_prev, vim.diagnostic.severity.INFO), opts)

    vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, opts)
    vim.keymap.set("v", "<leader>ca", vim.lsp.buf.code_action, opts)
    vim.keymap.set("n", "<leader>rr", vim.lsp.buf.references, opts)
    vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)
    vim.keymap.set("i", "<C-h>", vim.lsp.buf.signature_help, opts)

    -- Takes too long
    --
    -- require("workspace-diagnostics").populate_workspace_diagnostics(client, bufnr)
end

vim.filetype.add {
    pattern = {
        ['api_spec.*%.ya?ml'] = 'yaml.openapi',
    },
}


vim.filetype.add({
    pattern = {
        ['.*/*.gotmpl'] = 'gotmpl',
    },
})

local lspconfig = require 'lspconfig'
lspconfig.gopls.setup {
    -- I am hoping this reattaches the shortcuts that I add at the start.
    on_attach = OnAttach,
    filetypes = { 'go', 'gomod', 'gowork', 'gotmpl' },
    settings = {
        gopls = {
            buildFlags = { "-tags=unit,integration,gml_example" },
            directoryFilters = {
                "-**/node_modules",
                "-**/kard",
            },
            templateExtensions = { "gotmpl" },
            -- usePlaceholders = true,
            analyses = {
                unusedparams = true,
                unreachable = true,
                shadow = true,
            },
            hints = {
                assignVariableTypes    = true,
                constantValues         = true,
                functionTypeParameters = true,
                parameterNames         = true,
                rangeVariableTypes     = true,
            },
        }
    }
}

-- {
--   default_config = {
--     cmd = { 'gopls' },
--     filetypes = { 'go', 'gomod', 'gowork', 'gotmpl' },
--     root_dir = function(fname)
--       -- see: https://github.com/neovim/nvim-lspconfig/issues/804
--       if not mod_cache then
--         local result = async.run_command { 'go', 'env', 'GOMODCACHE' }
--         if result and result[1] then
--           mod_cache = vim.trim(result[1])
--         end
--       end
--       if fname:sub(1, #mod_cache) == mod_cache then
--         local clients = util.get_lsp_clients { name = 'gopls' }
--         if #clients > 0 then
--           return clients[#clients].config.root_dir
--         end
--       end
--       return util.root_pattern('go.work', 'go.mod', '.git')(fname)
--     end,
--     single_file_support = true,
--   },
--   docs = {
--     description = [[
-- https://github.com/golang/tools/tree/master/gopls
--
-- Google's lsp server for golang.
-- ]],
--     default_config = {
--       root_dir = [[root_pattern("go.work", "go.mod", ".git")]],
--     },
--   },
-- }






lspconfig.flux_lsp.setup {
    cmd = { "flux-lsp", "-l", "/tmp/fluxlsp" },
}

lspconfig.pyright.setup {
    -- I am hoping this reattaches the shortcuts that I add at the start.
    on_attach = OnAttach,
    -- Custom logic to be able to use the version of python that is in the virtual env.
    -- Otherwise pyright uses the default python version of the system, which can lead to incorrect
    -- diagnostics about builtins.
    before_init = function(params, config)
        local python_install_path = vim.fn.exepath('python')
        if python_install_path ~= '' then
            config.settings.python.pythonPath = python_install_path
        end
    end,

    handlers = {
        ["textDocument/publishDiagnostics"] = vim.lsp.with(
            vim.lsp.diagnostic.on_publish_diagnostics, {
                -- delay update diagnostics. Unbelievably slow without this.
                -- Updates the diagnostics one character at a time even when I
                -- am done typing.
                update_in_insert = false,
            }
        ),
    }
}

lsp.on_attach(OnAttach)

require('mason').setup({})
require('mason-lspconfig').setup({
    ensure_installed = {
        'pyright',
        'lua_ls',
        'rust_analyzer',
        'gopls',
    },
    handlers = {
        lsp.default_setup,
    },
})

-- lsp.setup()

local cmp = require('cmp')
local cmp_select = { behavior = cmp.SelectBehavior.Select }
local cmp_action = require('lsp-zero').cmp_action()

require('luasnip.loaders.from_vscode').lazy_load()

local cmp_mappings = lsp.defaults.cmp_mappings({
    ['<CR>'] = cmp.mapping.confirm({ select = false }),
    ['<C-p>'] = cmp.mapping.select_prev_item(cmp_select),
    ['<C-n>'] = cmp.mapping.select_next_item(cmp_select),
    ['<C-y>'] = cmp.mapping.confirm({ select = true }),
    ['<C-f>'] = cmp_action.luasnip_jump_forward(),
    ['<C-b>'] = cmp_action.luasnip_jump_backward(),
    ["<C-Space>"] = cmp.mapping.complete(),
})

cmp.setup({
    sources = {
        { name = 'nvim_lsp' },
        { name = 'nvim_lua' },
        { name = 'luasnip' },
        { name = 'path' },
        { name = 'buffer' },
    },
    mapping = {
        -- `Enter` key to confirm completion
        ['<CR>'] = cmp.mapping.confirm({ select = false }),

        -- Ctrl+Space to trigger completion menu
        ['<C-Space>'] = cmp.mapping.complete(),

        -- Navigate between snippet placeholder
        ['<C-f>'] = cmp_action.luasnip_jump_forward(),
        ['<C-b>'] = cmp_action.luasnip_jump_backward(),
    },
    snippet = {
        expand = function(args)
            require("luasnip").lsp_expand(args.body)
        end,
    },
})

local cfg = { bind = true }
require "lsp_signature".setup(cfg)

vim.diagnostic.config({
    -- This seems to be too slow unfortunately.
    update_in_insert = false,
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

require("mason-null-ls").setup({
    ensure_installed = {
        "black",
        "cspell",
    },
})

null_ls.setup({
    sources = {
        --     cspell.diagnostics.with({
        --         diagnostics_postprocess = function(diagnostic)
        --             diagnostic.severity = vim.diagnostic.severity.INFO
        --         end,
        --         config = cspell_config,
        --     }),
        --     cspell.code_actions.with({ config = cspell_config }),
        null_ls.builtins.formatting.black.with({ extra_args = { "--line-length", "99" } }),
    },
    -- A subset of the remaps that we do for all other methods as we want to be able to add
    -- incorrect spelling to the allow list from any file.
    -- NOTE: The code action remap must match the remap in the on_attach method for all other
    -- LSPs.
    on_attach = function(_client, bufnr)
        local opts = { buffer = bufnr, remap = false }
        vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, opts)
    end
})
