local o = vim.o

vim.g.mapleader = " "
vim.opt.termguicolors = true
-- For CursorHold
o.updatetime = 500

-- ufo provider needs high values
vim.o.foldcolumn = '0'
o.foldlevel = 99
o.foldlevelstart = 99
o.foldenable = true


o.number = true
o.relativenumber = true
o.cursorline = true

o.tabstop = 4
o.shiftwidth = 4
o.expandtab = true

o.ignorecase = true
o.smartcase = true

vim.cmd('au FileType * set tabstop=4 shiftwidth=4 expandtab') -- I beg neovim why do I have to do this
vim.cmd('au FileType * set fo-=c fo-=r fo-=o') -- Remove auto comment on new line

local sign = function(opts)
    vim.fn.sign_define(opts.name, {
        texthl = opts.name,
        text = opts.text,
        numhl = ''
    })
end
sign({ name = 'DiagnosticSignError', text = '' })
sign({ name = 'DiagnosticSignWarn', text = '' })
sign({ name = 'DiagnosticSignHint', text = '' })
sign({ name = 'DiagnosticSignInfo', text = '' })

vim.diagnostic.config {
    virtual_text = false,
    signs = true,
    underline = true,
    update_in_insert = false,
    float = {
        border = 'rounded',
        source = 'always',
        header = '',
        prefix = '',
    },
}

-- FIX: vim.lsp.buf.hover rounded border


local keymap_set = vim.keymap.set
---@diagnostic disable-next-line: duplicate-set-field
vim.keymap.set = function(mode, lhs, rhs, opts)
  opts = opts or {}
  opts.silent = opts.silent ~= false
  return keymap_set(mode, lhs, rhs, opts)
end
