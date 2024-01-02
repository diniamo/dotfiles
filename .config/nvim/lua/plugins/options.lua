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
}
