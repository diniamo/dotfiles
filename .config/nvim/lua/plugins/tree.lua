return {
    {
        "nvim-neo-tree/neo-tree.nvim",
        opts = {
            popup_border_style = "rounded",
            filesystem = {
                filtered_items = {
                    always_show = {
                        ".gitignore"
                    }
                }
            },
            event_handlers = {
                {
                    event = "file_opened",
                    handler = function(_)
                        -- auto close
                        require("neo-tree.command").execute({ action = "close" })
                    end
                },

            }
        },
        keys = {
            { "<Leader>n", "<Cmd>Neotree<CR>" },
            -- { '<leader>g', '<Cmd>Neotree source=git_status position=float<CR>' },
        }
    }
}
