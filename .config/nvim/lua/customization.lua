require('everblush').setup()
local maincolor = require('everblush.core').get_colors().color2


local o = vim.opt

o.number = true
vim.cmd('autocmd TermOpen * setlocal nonumber norelativenumber')
o.tabstop = 4
o.shiftwidth = 4
o.ignorecase = true
o.smartcase = true

o.cursorline = true
vim.cmd('hi CursorLine guibg=#0f1416 gui=nocombine')
vim.cmd('hi CursorLineNr term=bold ctermfg=11 gui=bold guifg=' .. maincolor)

vim.cmd('hi FloatBorder guifg=' .. maincolor) --.. ' guibg=' .. maincolor)

vim.cmd('au FileType * set fo-=c fo-=r fo-=o')	-- Remove auto comment on new line


-- (For transparent background)
-- vim.cmd('hi Normal guibg=NONE ctermbg=NONE')
-- vim.cmd('highlight clear LineNr')
-- vim.cmd('highlight clear SignColumn')


-- lualine
local navic = require('nvim-navic')
require('lualine').setup {
	options = { theme = 'everblush' },
	sections = {
		lualine_c = {
			{ navic.get_location, cond = navic.is_available },
		}
	}
}

-- cokeline
local is_picking_focus = require("cokeline/mappings").is_picking_focus
local is_picking_close = require("cokeline/mappings").is_picking_close
local get_hex = require("cokeline/utils").get_hex

local red = vim.g.terminal_color_1
local yellow = vim.g.terminal_color_4
local space = {text = " "}
local dark = get_hex("Normal", "bg")
local text = get_hex("Comment", "fg")
local grey = get_hex("ColorColumn", "bg")
local light = get_hex("Comment", "fg")
local high = maincolor

require("cokeline").setup(
    {
        default_hl = {
            fg = function(buffer)
                if buffer.is_focused then
                    return dark
                end
                return text
            end,
            bg = function(buffer)
                if buffer.is_focused then
                    return high
                end
                return grey
            end
        },
        components = {
            {
                text = function(buffer)
                    if buffer.index ~= 1 then
                        return ""
                    end
                    return ""
                end,
                bg = function(buffer)
                    if buffer.is_focused then
                        return high
                    end
                    return grey
                end,
                fg = dark
            },
            space,
            {
                text = function(buffer)
                    if is_picking_focus() or is_picking_close() then
                        return buffer.pick_letter .. " "
                    end

                    return buffer.devicon.icon
                end,
                fg = function(buffer)
                    if is_picking_focus() then
                        return yellow
                    end
                    if is_picking_close() then
                        return red
                    end

                    if buffer.is_focused then
                        return dark
                    else
                        return light
                    end
                end,
                style = function(_)
                    return (is_picking_focus() or is_picking_close()) and "italic,bold" or nil
                end
            },
            {
                text = function(buffer)
                    return buffer.unique_prefix .. buffer.filename .. "⠀"
                end,
                style = function(buffer)
                    return buffer.is_focused and "bold" or nil
                end
            },
            {
                text = "",
                fg = function(buffer)
                    if buffer.is_focused then
                        return high
                    end
                    return grey
                end,
                bg = dark
            }
        }
    }
)
