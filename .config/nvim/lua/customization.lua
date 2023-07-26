local maincolor = '#8aadf4'
-- Highlight groups aren't initialized in time for this, and using an autocommand to delay it seems like a waste
-- local maincolor = string.format('#%06x', vim.api.nvim_get_hl(0, { name = 'FloatBorder' })['fg'])

local o = vim.o

o.number = true
o.relativenumber = true
-- vim.cmd('autocmd TermOpen * setlocal nonumber norelativenumber')

o.tabstop = 4
o.shiftwidth = 4
o.expandtab = true
vim.cmd('au FileType * set tabstop=4 shiftwidth=4 expandtab') -- I beg neovim why do I have to do this
o.ignorecase = true
o.smartcase = true

o.cursorline = true
-- vim.cmd('hi CursorLine guibg=#0f1416 gui=nocombine')
-- vim.cmd('hi CursorLineNr term=bold ctermfg=11 gui=bold guifg=' .. maincolor)

-- vim.cmd('hi FloatBorder guifg=' .. maincolor)  --.. ' guibg=' .. maincolor)

vim.cmd('au FileType * set fo-=c fo-=r fo-=o') -- Remove auto comment on new line


-- (For transparent background)
-- vim.cmd('hi Normal guibg=NONE ctermbg=NONE')
-- vim.cmd('highlight clear LineNr')
-- vim.cmd('highlight clear SignColumn')


-- lualine
require('lualine').setup {
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
                navic_opts = nil
            }
        }
    }
}
