return {
    {
        'nvim-lualine/lualine.nvim',
        priotity = 999,
        opts = {
            options = {
                theme = 'tokyodark',
                component_separators = { left = '', right = '' },
                section_separators = { left = '', right = '' },
                icons_enabled = true,
                globalstatus = true,
                always_show_tabline = true,
            },
            sections = {
                lualine_a = { 'mode' },
                lualine_b = { { 'filetype' },
                    {
                        'filename',
                        path = 1,
                        symbols = {
                            modified = '',
                            readonly = '',
                            unnamed = '',
                            newfile = '', 
                        },
                    },
                },
                lualine_c = {},
                lualine_x = { { 'diff' }, { 'diagnostics' },
                    { 'branch', icon = '' },
                },
                lualine_y = {},
                lualine_z = { { 'location' }, },
            },
            inactive_sections = {
                lualine_a = {},
                lualine_b = {},
                lualine_c = {},
                lualine_x = {},
                lualine_y = {},
                lualine_z = {},
            },
            tabline = {
                lualine_a = {
                    {
                        'tabs',
                        mode = 0,
                        show_modified_status = false,
                    },
                },
                lualine_b = {},
                lualine_c = {},
                lualine_x = {},
                lualine_y = {
                    {
                        require("lazy.status").updates,
                        cond = require("lazy.status").has_updates,
                        color = { fg = "#ff9e64" },
                    },
                },
                lualine_z = {
                    function ()
                        return [[Lazy]]
                    end,
                },
            },
            winbar = {
                lualine_a = {},
                lualine_b = {},
                lualine_c = {},
                lualine_x = {},
                lualine_y = {},
                lualine_z = {},
            },
        },
    },
}
