return {
    {
        "kylechui/nvim-surround",
        event = "VeryLazy"
    },
    {
        "numToStr/Comment.nvim",
        event = "VeryLazy",
        config = function()
            require("Comment").setup()
        end
    },
    {
        "ZhiyuanLck/smart-pairs",
        event = "InsertEnter",
        config = function()
            require('pairs'):setup {
                enter = {
                    enable_mapping = false
                }
            }
        end
    },
    {
        "ggandor/leap.nvim",
        event = "VeryLazy",
        config = function() require('leap').add_default_mappings() end
    },
    {
        "tpope/vim-repeat",
        event = "VeryLazy",
    },
    {
        "max397574/better-escape.nvim",
        event = "InsertEnter",
    },
}
