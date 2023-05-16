-- Impatient has to be initialized at the beginning
require('impatient')

-- Has to be called before colorizer is set up
vim.opt.termguicolors = true

-- Workaround for #21856
vim.api.nvim_create_autocmd({ "VimLeave" }, {
  callback = function()
    vim.cmd('!notify-send  ""')
    vim.cmd('sleep 10m')
  end,
})
vim.api.nvim_create_autocmd({ 'VimLeave' }, {
	callback = function()
		vim.fn.jobstart('notify-send ""', { detach = true })
	end,
})

-- Remove kitty padding while in editor
vim.cmd [[
augroup kitty_mp
    autocmd!
    au VimLeave * :silent !kitty @ --to=$KITTY_LISTEN_ON set-spacing padding=5
	au VimEnter * :silent !kitty @ --to=$KITTY_LISTEN_ON set-spacing padding=0
augroup END
]]

-- For CursorHold
vim.o.updatetime = 500

-- Setting other plugins to use nvim-notify
vim.notify = require('notify')

-- Plugins
require 'plugins'

-- Lsp config and nvim-cmp completion
require 'lsp_completion'

-- Keybinds
require 'keybinds'

-- Customization
require 'customization'
