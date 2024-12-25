-- Vars
local setmap = vim.keymap.set
local delmap = vim.keymap.del
--
return {
    {
        'folke/which-key.nvim',
        event = 'VeryLazy',
        opts = {
            plugins = {
                presets = {
                    windows = false,
                },
            },
        },
        config = function()
            local wk = require('which-key')
            wk.add({
                { 'gt', hidden = true },
                { 'gT', hidden = true },
                { '<esc>', hidden = true },
            })
        end,
    },
    {
        -- -- Vim Keymaps
        
        -- disable commands
        setmap('n', 'gt', '<nop>'),
        setmap('n', 'gT', '<nop>'),
        setmap('n', '<C-w>', '<nop>'),
        --
        
        -- Save
        setmap('n', '<C-s>', '<CMD>write<CR>'),
        --
        
        -- Modes
        setmap('i', 'jk', '<ESC>'),
        setmap('n', ';', ':'),
        --
        
        -- Completion
        setmap('i', '<C-f>', '<C-x><C-f>', { desc = 'Dir/File Name Completion' }),
        setmap('i', '<C-k>', '<C-x><C-n>', { desc = 'In Current File Completion' }),
        
        -- Find
        setmap('n', '<leader>ff', '<CMD>FzfLua files<CR>', { desc = 'Find Files' }),
        setmap('n', '<leader>fh', '<CMD>FzfLua helptags<CR>', { desc = 'Find Help' }),
        setmap('n', '<leader>fc', '<CMD>FzfLua commands<CR>', { desc = 'Find Commands' }),
        setmap('n', '<leader>fm', '<CMD>FzfLua keymaps<CR>', { desc = 'Find KeyMaps' }),
        setmap('n', '<leader>fb', '<CMD>FzfLua buffers<CR>', { desc = 'Find KeyMaps' }),
        -- setmap('n', '<leader>mf', '<CMD>Lexplore<CR>', { desc = 'manage files' }),
        setmap('n', '<leader>ml', '<CMD>Lazy<CR>', { desc = 'manage Lazy' }),
        --
        
        -- Windows
        setmap('n', '<leader>h', '<CMD>lefta:vert:new<CR>', { desc = 'New Window Left' }),
        setmap('n', '<leader>j', '<CMD>bel:hor:new<CR>', { desc = 'New Window Down' }),
        setmap('n', '<leader>k', '<CMD>abo:hor:new<CR>', { desc = 'New Window Up' }),
        setmap('n', '<leader>l', '<CMD>rightb:vert:new<CR>', { desc = 'New Window Right' }),
        setmap('n', '<leader>x', '<CMD>bdelete<CR>', { desc = 'Delete Buffer' }),
        setmap('n', '<leader>tw', '<CMD>set wrap !<CR>', { desc = 'Toggle Wrap' }),
        --
        
        -- tabs
        setmap('n', '<leader>ot', '<CMD>tab new<CR>'),
        setmap('n', '<leader><TAB>', '<CMD>tabnext<CR>'),
        setmap('n', '<leader><S-TAB>', '<CMD>tabprevious<CR>'),
        --
        
        -- File systm navigation
        setmap('n', '<leader>od', ':chdir ./'),
        --
        
        -- Window Navigation
        setmap('n', '<esc>l', '<CMD>wincmd l<CR>'),
        setmap('n', '<esc>h', '<CMD>wincmd h<CR>'),
        setmap('n', '<esc>j', '<CMD>wincmd j<CR>'),
        setmap('n', '<esc>k', '<CMD>wincmd k<CR>'),
        --
        
        -- Resize Windows
        setmap('n', '<esc><C-l>', '<C-w><'),
        setmap('n', '<esc><C-h>', '<C-w>>'),
        setmap('n', '<esc><C-j>', '<C-w>+'),
        setmap('n', '<esc><C-k>', '<C-w>-'),
        --
        
        -- --
    },
    {
        'echasnovski/mini.surround',
        opts = {
            mappings = {
                add = 'gsa', delete = 'gsd',
                find = 'gsf', find_left = 'gsF',
                highlight = 'gsh', replace = 'gsr',
                update_n_lines = 'gsn',
            },
        },
        keys = {
            { 'gsa' }, { 'gsd' },
            { 'gsf' }, { 'gsf' },
            { 'gsF' }, { 'gsh' },
            { 'gsr' }, { 'gsn' },
        },
    },
}
