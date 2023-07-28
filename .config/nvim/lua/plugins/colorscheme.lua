return {
    {
        "catppuccin/nvim",
        name = "catppuccin",
        lazy = false,
        priority = 1000,
        config = function()
            require("catppuccin").setup {
                flavour = 'macchiato',

                integrations = {
                    barbar = true,
                    gitsigns = true,
                    indent_blankline = {
                        enabled = true,
                        colored_indent_levels = false
                    },
                    leap = true,
                    mason = true,
                    neotree = true,
                    noice = true,
                    cmp = true,
                    native_lsp = {
                        enabled = true,
                        virtual_text = {
                            errors = { "italic" },
                            hints = { "italic" },
                            warnings = { "italic" },
                            information = { "italic" },
                        },
                        underlines = {
                            errors = { "underline" },
                            hints = { "underline" },
                            warnings = { "underline" },
                            information = { "underline" },
                        },
                        inlay_hints = {
                            background = true,
                        },
                    },
                    navic = {
                        enabled = true,
                        custom_bg = "NONE"
                    },
                    notify = true,
                    treesitter = true,
                    rainbow_delimiters = true,
                    telescope = {
                        enabled = true
                    },
                    lsp_trouble = true
                }
            }

            vim.cmd.colorscheme("catppuccin")
        end
    }
}
