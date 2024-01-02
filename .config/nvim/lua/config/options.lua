-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua

local opt = vim.opt
local api = vim.api
local g = vim.g

-- opt.softtabstop = 4
opt.tabstop = 4
opt.shiftwidth = 4
opt.expandtab = true

opt.copyindent = true
opt.preserveindent = true

-- These are overridden normally
api.nvim_create_autocmd({ "FileType" }, {
    callback = function()
        opt.formatoptions:remove({ "c", "o" })
    end,
})

if vim.g.neovide then
    opt.guifont = "JetBrainsMono Nerd Font Mono:h11"
    g.neovide_remember_window_size = false
end
