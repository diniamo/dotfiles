-- Has to be called before colorizer is set up

vim.opt.termguicolors = true

-- Remove kitty padding while in editor
vim.cmd [[
augroup kitty_mp
    autocmd!
    au VimLeave * :silent !kitty @ --to=$KITTY_LISTEN_ON set-spacing padding=5
	au VimEnter * :silent !kitty @ --to=$KITTY_LISTEN_ON set-spacing padding=0
augroup END
]]

-- Plugins
require 'plugins'

-- Lsp config and nvim-cmp completion
require 'lsp_completion'

-- Keybinds
require 'keybinds'

-- Customization
require 'customization'
