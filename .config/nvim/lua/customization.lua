local maincolor = '#8aadf4'

local o = vim.opt

o.number = true
o.relativenumber = true
vim.cmd('autocmd TermOpen * setlocal nonumber norelativenumber')

o.tabstop = 4
o.shiftwidth = 4
o.ignorecase = true
o.smartcase = true

o.cursorline = true
vim.cmd('hi CursorLine guibg=#0f1416 gui=nocombine')
vim.cmd('hi CursorLineNr term=bold ctermfg=11 gui=bold guifg=' .. maincolor)

vim.cmd('hi FloatBorder guifg=' .. maincolor)  --.. ' guibg=' .. maincolor)

vim.cmd('au FileType * set fo-=c fo-=r fo-=o') -- Remove auto comment on new line


-- (For transparent background)
-- vim.cmd('hi Normal guibg=NONE ctermbg=NONE')
-- vim.cmd('highlight clear LineNr')
-- vim.cmd('highlight clear SignColumn')


-- lualine
local navic = require('nvim-navic')
require('lualine').setup {
	options = { theme = 'catppuccin' },
	sections = {
		lualine_c = {
			{ navic.get_location, cond = navic.is_available },
		}
	}
}
