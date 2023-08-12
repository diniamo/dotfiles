return {
    {
        "folke/trouble.nvim",
        opts = {
            height = 17,
            mode = "document_diagnostics",
        },
        cmd = "Trouble",
        keys = {
            { '<leader>xx', '<cmd>TroubleToggle document_diagnostics<cr>' },
            { '<leader>xd', '<cmd>TroubleToggle document_diagnostics<cr>' },
            { '<leader>xw', '<cmd>TroubleToggle workspace_diagnostics<cr>' },
            { '<leader>xq', '<cmd>TroubleToggle quickfix<cr>' },
            { '<leader>xl', '<cmd>TroubleToggle loclist<cr>' },
        }
    },
    {
        "folke/todo-comments.nvim",
        event = "VeryLazy",
        keys = {
            { "<Leader>xt", "<Cmd>TodoTrouble<CR>" },
            { "<Leader>tt", "<Cmd>TodoTelescope<CR>" },
        },
        config = function()
            require("todo-comments").setup()
        end
    },
    {
        "nvim-telescope/telescope.nvim",
        keys = {
            { "<leader>o", "<Cmd>Telescope find_files<cr>" },
            { "<leader>g", "<Cmd>Telescope live_grep<cr>" },
            -- { "<leader>b", "<Cmd>Telescope buffers<cr>" },
            { "<leader>h", "<Cmd>Telescope help_tags<cr>" },
        },
        cmd = "Telescope"
    },
    {
        "SmiteshP/nvim-navbuddy",
        opts = {
            window = {
                border = "rounded"
            }
        },
        keys = {
            { "<leader>s", "<cmd>Navbuddy<cr>" }
        }
    },
    {
        "akinsho/git-conflict.nvim",
        event = "VeryLazy",
        keys = {
            { "<Leader>co", "<Cmd>GitConflictChooseOurs<CR>" },
            { "<Leader>ct", "<Cmd>GitConflictChooseTheirs<CR>" },
            { "<Leader>cb", "<Cmd>GitConflictChooseBoth<CR>" },
            { "<Leader>c0", "<Cmd>GitConflictChooseNone<CR>" },
            { "<Leader>]", "<Cmd>GitConflictNextConflict<CR>" },
            { "<Leader>[", "<Cmd>GitConflictPrevConflict<CR>" },
        },
        opts = {
            default_mappings = false
        }
    }
}
