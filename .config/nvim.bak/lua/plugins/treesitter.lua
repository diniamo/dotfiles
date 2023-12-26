return {
    {
        'nvim-treesitter/nvim-treesitter',
        event = "BufReadPost",
        dependencies = {
            -- "nvim-treesitter/nvim-treesitter-refactor"
        },
        build = ':TSUpdate',
        config = function()
            local configs = require("nvim-treesitter.configs")

            configs.setup {
                auto_install = true,
                highlight = { enable = true, },
                indent = { enable = true },
                -- refactor = {
                --     highlight_definitions = {
                --         enable = true,
                --         -- Set to false if you have an `updatetime` of ~100.
                --         clear_on_cursor_move = true,
                --     },
                --     highlight_current_scope = { enable = true },
                --     smart_rename = { enable = false },
                --     navigation = { enable = true }
                -- }
            }
        end
    },
}
