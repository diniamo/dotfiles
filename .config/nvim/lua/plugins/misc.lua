return {
    {
        "lewis6991/gitsigns.nvim",
        event = "VeryLazy",
    },
    {
        "norcalli/nvim-colorizer.lua",
        event = "VeryLazy",
    },
    {
        "lukas-reineke/indent-blankline.nvim",
        event = "VeryLazy",
        opts = {
            show_current_context = true,
            show_current_context_start = false,
            use_treesitter = true,
        },
        config = function()
            require("ibl").setup()
        end,
        init = function()
            vim.api.nvim_set_hl(0, "IndentBlanklineChar", { bg = "NONE" })
        end
    },
    {
        "jinh0/eyeliner.nvim",
        keys = { 'f', 'F', 't', 'T' },
        opts = { highlight_on_key = true }
    },
    {
        url = "https://gitlab.com/HiPhish/rainbow-delimiters.nvim",
        event = "VeryLazy",
        config = function()
            local rainbow_delimiters = require 'rainbow-delimiters'

            vim.g.rainbow_delimiters = {
                strategy = {
                    [''] = rainbow_delimiters.strategy['global'],
                    commonlisp = rainbow_delimiters.strategy['local'],
                },
                query = {
                    [''] = 'rainbow-delimiters',
                    lua = 'rainbow-blocks',
                },
                highlight = {
                    'RainbowDelimiterRed',
                    'RainbowDelimiterYellow',
                    'RainbowDelimiterBlue',
                    'RainbowDelimiterOrange',
                    'RainbowDelimiterGreen',
                    'RainbowDelimiterViolet',
                    'RainbowDelimiterCyan',
                },
                blacklist = {}
            }
        end
    },
    {
        "kevinhwang91/nvim-ufo",
        event = "VeryLazy",
        config = function()
            local ufo = require("ufo")

            ufo.setup {
                provider_selector = function(_, _, _)
                    return { 'treesitter', 'indent' }
                end
            }

            vim.keymap.set('n', 'zR', ufo.openAllFolds)
            vim.keymap.set('n', 'zM', ufo.closeAllFolds)
        end
    },
    {
        "romainl/vim-cool",
        keys = { '/', '?', ':' },
    },
    {
        'tzachar/local-highlight.nvim',
        event = "VeryLazy",
        config = function()
            local local_highlight = require('local-highlight')
            local_highlight.setup()

            vim.api.nvim_create_autocmd('BufRead', {
                pattern = { '*.*' },
                callback = function(data)
                    local_highlight.attach(data.buf)
                end
            })
        end
    },
    -- FIX: silicon.nvim
    -- {
    --     "krivahtoo/silicon.nvim",
    --     build = "./install.sh",
    --     cmd = "Silicon",
    --     keys = {
    --         { "<Leader>s", "<Cmd>Silicon<CR>", mode = 'v' }
    --     },
    --     config = function()
    --         require("silicon").setup {
    --             theme = "Catppuccin",
    --         }
    --     end
    -- },
    {
        "folke/which-key.nvim",
        init = function()
            vim.o.timeout = true
            vim.o.timeoutlen = 1000
        end,
        event = "VeryLazy",
        opts = {}
    },
}
