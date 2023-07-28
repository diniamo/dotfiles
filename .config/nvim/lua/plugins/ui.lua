return {
    {
        "romgrk/barbar.nvim",
        event = "VeryLazy",
        config = function()
            vim.g.barbar_auto_setup = false

            require('barbar').setup {
                auto_hide = true,
                focus_on_close = "previous",
                icons = {
                    button = ''
                }
            }

            vim.keymap.set('n', '<Tab>', '<Cmd>BufferNext<CR>')
            vim.keymap.set('n', '<S-Tab>', '<Cmd>BufferPrevious<CR>')

            vim.keymap.set('n', '<A-Right>', '<Cmd>BufferMoveNext<CR>')
            vim.keymap.set('n', '<A-Left>', '<Cmd>BufferMovePrevious<CR>')

            vim.keymap.set('n', 'gt', '<Cmd>BufferPick<CR>')

            vim.keymap.set('n', 'g0', '<Cmd>BufferLast<CR>')
            vim.keymap.set('n', '<A-0>', '<Cmd>BufferLast<CR>')

            vim.keymap.set('n', '<Leader>w', '<Cmd>BufferClose<CR>')
            vim.keymap.set('n', '<Leader>x', '<Cmd>w<CR><Cmd>BufferClose<CR>')
            vim.keymap.set('n', '<Leader>e', '<Cmd>bufdo :BufferClose<CR>')

            for i = 1, 9 do
                vim.keymap.set('n', ('<A-%s>'):format(i), ('<Cmd>BufferGoto %s<CR>'):format(i))
                vim.keymap.set('n', ('g%s'):format(i), ('<Cmd>BufferGoto %s<CR>'):format(i))
            end
        end
    },
    {
        "nvim-lualine/lualine.nvim",
        event = "VeryLazy",
        dependencies = { "SmiteshP/nvim-navic" },
        opts = {
            options = { theme = 'catppuccin' },
            sections = {
                lualine_c = {
                    {
                        "filename",
                        path = 1,
                        file_status = true,
                    }
                },
                lualine_x = {
                    'filesize',
                    'encoding',
                },
                lualine_y = {
                    'filetype'
                },
                lualine_z = {
                    'progress',
                    'location'
                }
            },
            winbar = {
                lualine_c = {
                    {
                        "navic",
                        color_correction = nil,
                        navic_opts = nil,
                        draw_empty = true,
                        fmt = function(str, _)
                            if (str == nil or str == '') then
                                return '󰍉 Outer scope'
                            else
                                return str
                            end
                        end
                    }
                }
            }
        }
    },
}
