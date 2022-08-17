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

	-- 	use 'olimorris/onedarkpro.nvim'
	-- 	use 'marko-cerovac/material.nvim'
	-- 	use 'Shatur/neovim-ayu'
	-- 	use 'tanvirtin/monokai.nvim'
	use 'folke/tokyonight.nvim'
	use 'Everblush/everblush.nvim'

	use 'neovim/nvim-lspconfig'
	use {
		'williamboman/mason.nvim',
		config = function() require('mason').setup {
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
	use 'hrsh7th/cmp-path'
	use 'hrsh7th/cmp-nvim-lsp'
	use 'hrsh7th/cmp-nvim-lsp-signature-help'
	use {
		'folke/trouble.nvim',
		cmd = 'Trouble',
		config = function() require('trouble').setup() end
	}
	use 'L3MON4D3/LuaSnip'
	use 'saadparwaiz1/cmp_luasnip'
	use 'rafamadriz/friendly-snippets'
	use 'hrsh7th/nvim-cmp'

	use {
		'nvim-telescope/telescope.nvim',
		requires = 'nvim-lua/plenary.nvim',
		cmd = 'Telescope',
		config = function() require('telescope').setup() end
	}
	use { "akinsho/toggleterm.nvim", tag = 'v2.*', config = function() require("toggleterm").setup() end }

	use { 'nvim-treesitter/nvim-treesitter',
		run = function() require('nvim-treesitter.install').update({ with_sync = true }) end,
		config = function()
			require('nvim-treesitter.configs').setup {
				auto_install = true,
				highlight = { enable = true },

				indent = {
					enable = true
				},
				rainbow = { enable = true,
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
	use {
		'kevinhwang91/nvim-ufo',
		requires = 'kevinhwang91/promise-async',
		config = function()
			-- Folding
			-- vim.o.foldcolumn = '1'
			vim.o.foldlevel = 99 -- Using ufo provider need a large value, feel free to decrease the value
			vim.o.foldlevelstart = 99
			vim.o.foldenable = true

			vim.keymap.set('n', 'zR', require('ufo').openAllFolds)
			vim.keymap.set('n', 'zM', require('ufo').closeAllFolds)

			require('ufo').setup {
				provider_selector = function(bufnr, filetype, buftype)
					return {'treesitter', 'indent'}
				end
			}
		end
	}
	use {
		'SmiteshP/nvim-navic',
		config = function() require('nvim-navic').setup() end
	}
	use 'p00f/nvim-ts-rainbow'
	use 'nvim-treesitter/nvim-treesitter-refactor'
	use {
		'numToStr/Comment.nvim',
		config = function() require('Comment').setup() end
	}
	use {
		'ZhiyuanLck/smart-pairs',
		event = 'InsertEnter',
		config = function() require('pairs'):setup() end
	}
	use 'ggandor/lightspeed.nvim'

	use 'kyazdani42/nvim-web-devicons'
	use {
		'norcalli/nvim-colorizer.lua',
		config = function() require('colorizer').setup() end
	}
	use 'noib3/nvim-cokeline'
	use 'nvim-lualine/lualine.nvim'

	use {
		'lukas-reineke/indent-blankline.nvim',
		config = function()
			require('indent_blankline').setup {
				show_current_context = true,
				use_treesitter = true,
			}
		end
	}
end)
