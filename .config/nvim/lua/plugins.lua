-- Plugins using packer

vim.cmd([[
  augroup packer_user_config
	autocmd!
	autocmd BufWritePost plugins.lua source <afile> | PackerSync
  augroup end
]])

return require('packer').startup(function(use)
    -- Packer can update itself
    use 'wbthomason/packer.nvim'
    use 'svermeulen/vimpeccable'
    use 'lewis6991/impatient.nvim'

    use 'nvim-lua/plenary.nvim'
    use 'MunifTanjim/nui.nvim'
    use 'kevinhwang91/promise-async'

    -- use 'Everblush/everblush.nvim'
    use {
        "catppuccin/nvim", as = "catppuccin",
        config = function()
            require('catppuccin').setup {
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

            vim.cmd.colorscheme "catppuccin"
        end
    }
    -- use '/hdd/dev/everblush.nvim'

    use 'neovim/nvim-lspconfig'
    use {
        "https://git.sr.ht/~whynothugo/lsp_lines.nvim",
        config = function()
            require("lsp_lines").setup()
        end,
    }
    use 'simrat39/rust-tools.nvim'
    use {
        'williamboman/mason.nvim',
        config = function()
            require('mason').setup {
                ui = {
                    icons = {
                        package_installed = "✓",
                        package_pending = "➜",
                        package_uninstalled = "✗"
                    }
                }
            }
        end
    }
    use {
        'williamboman/mason-lspconfig.nvim',
        config = function() require('mason-lspconfig').setup { automatic_installation = true } end
    }
    use 'hrsh7th/cmp-nvim-lua'
    use 'hrsh7th/cmp-buffer'
    use 'hrsh7th/cmp-cmdline'
    use 'dmitmel/cmp-cmdline-history'
    use 'FelipeLema/cmp-async-path'
    use 'hrsh7th/cmp-nvim-lsp'
    use 'hrsh7th/cmp-nvim-lsp-signature-help'
    use {
        'folke/trouble.nvim',
        opts = {
            height = 20,
            mode = "document_diagnostics"
        }
    }
    use {
        "folke/todo-comments.nvim",
        config = function() require('todo-comments').setup() end
    }

    use {
        'L3MON4D3/LuaSnip',
        requires = {
            'rafamadriz/friendly-snippets',
            -- {
            -- 	'molleweide/LuaSnip-snippets.nvim',
            -- 	as = 'luasnip-snippets'
            -- },
        }
    }
    use 'saadparwaiz1/cmp_luasnip'
    use 'hrsh7th/nvim-cmp'

    use {
        'nvim-telescope/telescope.nvim',
        cmd = 'Telescope',
        config = function() require('telescope').setup() end
    }
    use {
        "numToStr/FTerm.nvim",
        config = function()
            require("FTerm").setup {
                border = 'rounded',
            }

            vimp.nmap('<C-t>', '<CMD>lua require("FTerm").toggle()<CR>')
            vimp.tmap('<C-t>', '<C-\\><C-n><CMD>lua require("FTerm").toggle()<CR>')
        end
    }

    use { 'nvim-treesitter/nvim-treesitter',
        run = ':TSUpdate',
        config = function()
            require('nvim-treesitter.configs').setup {
                auto_install = true,
                highlight = { enable = true, },
                indent = {
                    enable = true
                },
                rainbow = {
                    enable = true,
                    extended_mode = true
                },
                highlight_definitions = {
                    enable = true,
                    -- Set to false if you have an `updatetime` of ~100.
                    clear_on_cursor_move = true,
                },
                highlight_current_scope = { enable = true },
                smart_rename = {
                    enable = true
                },
                navigation = {
                    enable = true
                }
            }
        end
    }
    use { 'lewis6991/gitsigns.nvim', config = function() require('gitsigns').setup() end }

    use {
        "nvim-neo-tree/neo-tree.nvim",
        config = function()
            local neo_tree = require('neo-tree')
            neo_tree.setup {
                popup_border_style = "rounded",
                filesystem = {
                    filtered_items = {
                        always_show = {
                            '.gitignore'
                        }
                    }
                },
                event_handlers = {
                    {
                        event = "file_opened",
                        handler = function(file_path)
                            --auto close
                            neo_tree.close_all()
                        end
                    },
                }
            }
        end
    }
    -- use {
    -- 	'iamcco/markdown-preview.nvim',
    -- 	run = function() vim.fn["mkdp#util#install"]() end,
    -- }
    -- use 'https://github.com/mipmip/vim-scimark'

    use {
        "kylechui/nvim-surround",
        tag = "*", -- Use for stability; omit to use `main` branch for the latest features
        config = function() require("nvim-surround").setup() end
    }
    use {
        'kevinhwang91/nvim-ufo',
        config = function()
            -- vim.o.foldcolumn = '1'
            vim.o.foldlevel = 99
            vim.o.foldlevelstart = 99
            vim.o.foldenable = true

            vim.keymap.set('n', 'zR', require('ufo').openAllFolds)
            vim.keymap.set('n', 'zM', require('ufo').closeAllFolds)

            require('ufo').setup {
                provider_selector = function(_, _, _)
                    return { 'treesitter', 'indent' }
                end
            }
        end
    }
    use { 'SmiteshP/nvim-navic', config = function() require('nvim-navic').setup() end }
    use {
        "SmiteshP/nvim-navbuddy",
        config = function()
            require('nvim-navbuddy').setup {
                window = {
                    border = 'rounded'
                }
            }
        end
    }
    use 'https://gitlab.com/HiPhish/rainbow-delimiters.nvim'
    use 'nvim-treesitter/nvim-treesitter-refactor'
    use { 'numToStr/Comment.nvim', config = function() require('Comment').setup() end }
    use {
        'ZhiyuanLck/smart-pairs',
        event = 'InsertEnter',
        config = function()
            require('pairs'):setup {
                enter = {
                    enable_mapping = false
                }
            }
        end
    }
    use { 'ggandor/leap.nvim', config = function() require('leap').add_default_mappings() end }
    use 'tpope/vim-repeat'

    use 'kyazdani42/nvim-web-devicons'
    use { 'norcalli/nvim-colorizer.lua', config = function() require('colorizer').setup() end }
    use {
        'romgrk/barbar.nvim',
        config = function()
            vim.g.barbar_auto_setup = false
            require('barbar').setup {
                icons = {
                    button = ''
                }
            }
        end
    }
    use 'nvim-lualine/lualine.nvim'

    use {
        'lukas-reineke/indent-blankline.nvim',
        config = function()
            vim.cmd(':hi IndentBlanklineChar guibg=NONE')

            require('indent_blankline').setup {
                show_current_context = true,
                use_treesitter = true,
            }
        end
    }
    -- use {
    -- 	"sitiom/nvim-numbertoggle",
    -- 	config = function()
    -- 		require("numbertoggle").setup()
    -- 	end
    -- }
    use {
        "max397574/better-escape.nvim",
        event = 'InsertEnter',
        config = function()
            require("better_escape").setup()
        end,
    }

    use 'joeytwiddle/sexy_scroller.vim'
    use {
        'jinh0/eyeliner.nvim',
        config = function()
            require 'eyeliner'.setup {
                highlight_on_key = true
            }
        end
    }
    use 'romainl/vim-cool'
    use 'rcarriga/nvim-notify'
    use {
        "folke/noice.nvim",
        config = function()
            require("noice").setup({
                lsp = {
                    -- override markdown rendering so that **cmp** and other plugins use **Treesitter**
                    override = {
                        ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
                        ["vim.lsp.util.stylize_markdown"] = true,
                        ["cmp.entry.get_documentation"] = true,
                    },
                }
            })
        end,
    }

    use {
        'tzachar/local-highlight.nvim',
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
    }
end)
