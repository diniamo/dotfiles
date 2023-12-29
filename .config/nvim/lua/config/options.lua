-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua

local opt = vim.opt
local api = vim.api
local g = vim.g

opt.tabstop = 4
opt.shiftwidth = 4
opt.expandtab = true

-- These are overridden normally
api.nvim_create_autocmd({ "FileType" }, {
  callback = function()
    opt.formatoptions:remove({ "c", "o" })
  end,
})

-- local api_nvim_open_win = api.nvim_open_win
-- api.nvim_open_win = function(buffer, enter, conf)
--   conf = conf or {}
--   conf.border = "rounded"
--   return api_nvim_open_win(buffer, enter, conf)
-- end

if vim.g.neovide then
  opt.guifont = "Hack Nerd Font Mono:h11"
  g.neovide_remember_window_size = false
end
