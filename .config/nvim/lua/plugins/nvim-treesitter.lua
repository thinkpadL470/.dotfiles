return { 
    {
        'nvim-treesitter/nvim-treesitter',
        event = { 'BufReadPre', 'BufNewFile' },
        build = ':TSUpdate',
        main = 'nvim-treesitter.configs',
        opts = {
            ensure_installed = { 'c', 'lua', 'vim', 'vimdoc', 'query', 'elixir', 'heex', 'javascript', 'html' },
            sync_install = false,
            highlight = { enable = 'lua', 'vim' },
            indent = { enable = true },
        },
    },
}
