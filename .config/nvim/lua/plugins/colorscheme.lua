return {
    {
        "tiagovla/tokyodark.nvim",
        priority = 1000,
        opts = {
            transparent_background = true,
            styles = {
                comments = { italic = false, bold = true },
                keywords = { italic = false, bold = true },
                identifiers = { italic = false, bold = true },
                functions = {},
                variables = {},
            },
        },
        config = function(_, opts)
            require("tokyodark").setup(opts)
            vim.cmd [[colorscheme tokyodark]]
        end,
    },
}
