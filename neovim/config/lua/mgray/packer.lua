vim.cmd.packadd('packer.nvim')

return require('packer').startup(function(use)
    -- Packer can manage itself
    use 'wbthomason/packer.nvim'
    use {
        'nvim-telescope/telescope.nvim', tag = '0.1.0',
        -- or                            , branch = '0.1.x',
        requires = { { 'nvim-lua/plenary.nvim' } }
    }
    use 'Mofiqul/dracula.nvim'
    use('nvim-treesitter/nvim-treesitter', { run = 'TSUpdate' })
    use 'nvim-treesitter/playground'
    use 'mbbill/undotree'
    use 'tpope/vim-fugitive'
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
        }
    }
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
    use 'tpope/vim-abolish'
    use 'tpope/vim-surround'
    -- joining the dark side because I am a big dumb idiot that needs to spell check everything.
    use {'neoclide/coc.nvim', branch = 'release', }
end)
