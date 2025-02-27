vim.cmd.packadd('packer.nvim')

return require('packer').startup(function(use)
    -- Packer can manage itself
    use 'wbthomason/packer.nvim'
    use {
        'nvim-telescope/telescope.nvim', tag = '0.1.4',
        -- or                            , branch = '0.1.x',
        requires = {
            { "nvim-telescope/telescope-live-grep-args.nvim" },
            { 'nvim-lua/plenary.nvim' },
        }
    }
    use 'Mofiqul/dracula.nvim'
    use('nvim-treesitter/nvim-treesitter', { run = 'TSUpdate' })

    use({
        "nvim-treesitter/nvim-treesitter-textobjects",
        after = "nvim-treesitter",
        requires = "nvim-treesitter/nvim-treesitter",
    })

    use 'nvim-treesitter/playground'
    use 'mbbill/undotree'
    use {
        'VonHeikemen/lsp-zero.nvim',
        requires = {
            -- LSP Support
            { 'neovim/nvim-lspconfig' },
            { 'williamboman/mason.nvim' },
            { 'williamboman/mason-lspconfig.nvim' },

            -- Autocompletion
            { 'hrsh7th/nvim-cmp' },
            { 'hrsh7th/cmp-buffer' },
            { 'hrsh7th/cmp-path' },
            { 'saadparwaiz1/cmp_luasnip' },
            { 'hrsh7th/cmp-nvim-lsp' },
            { 'hrsh7th/cmp-nvim-lua' },

            -- Snippets
            { 'L3MON4D3/LuaSnip' },
            -- Snippet Collection (Optional)
            { 'rafamadriz/friendly-snippets' },
            -- prettier icons
            { 'onsails/lspkind.nvim' },
        }
    }
    use 'jose-elias-alvarez/null-ls.nvim'
    use {
        "jay-babu/mason-null-ls.nvim",
        dependencies = {
            "williamboman/mason.nvim",
            "jose-elias-alvarez/null-ls.nvim",
        },
    }
    use 'davidmh/cspell.nvim'
    use({
        "iamcco/markdown-preview.nvim",
        run = "cd app && npm install",
        setup = function() vim.g.mkdp_filetypes = { "markdown" } end,
        ft = { "markdown" },
    })
    -- Allow formatting of markdown tables
    use "godlygeek/tabular"
    -- Markdown support
    use "preservim/vim-markdown"
    use "ray-x/lsp_signature.nvim"
    use 'nvim-tree/nvim-web-devicons'
    -- Adds file nav bar to the top
    use { 'romgrk/barbar.nvim', requires = 'nvim-web-devicons' }
    -- For easy aligning
    use 'junegunn/vim-easy-align'
    -- Replacing with smart case detection
    use 'tpope/vim-abolish'
    -- Surrounding with brackets or functions
    use 'tpope/vim-surround'
    -- git integration
    use 'tpope/vim-fugitive'
    -- trouble for making navigating diagnostics easier
    use {
        "folke/trouble.nvim",
        requires = "nvim-tree/nvim-web-devicons",
        config = function()
            require("trouble").setup {
                -- your configuration comes here
                -- or leave it empty to use the default settings
                -- refer to the configuration section below
            }
        end
    }
    -- Used for changing functions/maps/arrays from being on one line and being on multiple.
    -- <leader>m for toggling
    use({
        'Wansmer/treesj',
        requires = { 'nvim-treesitter' },
    })
    -- Better navigation when using nvim with tmux
    use "christoomey/vim-tmux-navigator"
    -- Editing an ordinary vim buffer to edit the file system.
    use {
        'stevearc/oil.nvim',
        -- config = function() require('oil').setup() end
    }

    use {
        "mfussenegger/nvim-dap",
        requires = {
            "leoluz/nvim-dap-go",
            "rcarriga/nvim-dap-ui",
            -- "theHamsta/nvim-dap-virtual-text",
            "nvim-neotest/nvim-nio",
            'theHamsta/nvim-dap-virtual-text'
        },
    }
    use {
        "folke/which-key.nvim",
        config = function()
            vim.o.timeout = true
            vim.o.timeoutlen = 300
            require("which-key").setup {
                -- your configuration comes here
                -- or leave it empty to use the default settings
                -- refer to the configuration section below
            }
        end
    }
    use 'folke/neodev.nvim'
    -- use 'echasnovski/mini.comment'

    use 'github/copilot.vim'

    use {
        "klen/nvim-config-local",
    }

    use {"artemave/workspace-diagnostics.nvim"}

    -- salt files
    use 'saltstack/salt-vim'
end)
