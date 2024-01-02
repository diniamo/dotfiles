return {
    {
        "LazyVim/LazyVim",
        opts = {
            colorscheme = function()
                require("catppuccin").load("macchiato")
            end,

            news = {
                neovim = true,
            },
        },
    },
    {
        "folke/noice.nvim",
        opts = {
            presets = {
                bottom_search = false,
            },
        },
    },
    {
        "stevearc/conform.nvim",
        opts = {
            formatters = {
                shfmt = {
                    prepend_args = { "-i", "4" },
                },
            },
        },
    },
    {
        "nvimdev/dashboard-nvim",
        opts = function(_, opts)
            table.insert(opts.config.center, 4, {
                action = "Telescope zoxide list",
                desc = " Zoxide List",
                icon = " ",
                key = "z",
                key_format = "  %s",
            })
            return opts
        end,
    },
}
