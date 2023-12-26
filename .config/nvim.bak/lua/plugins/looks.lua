return {
    {
        "joeytwiddle/sexy_scroller.vim",
        event = "VeryLazy",
    },
    {
        "rcarriga/nvim-notify",
        event = "VimEnter",
        config = function()
            vim.notify = require("notify")
        end
    },
    {
        "folke/noice.nvim",
        event = "VeryLazy",
        opts = {
            lsp = {
                -- override markdown rendering so that **cmp** and other plugins use **Treesitter**
                override = {
                    ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
                    ["vim.lsp.util.stylize_markdown"] = true,
                    ["cmp.entry.get_documentation"] = true,
                },
            }
        },
    }
}
