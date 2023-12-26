vim.loader.enable()

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

require("config.options")
require("config.keymaps")
require("config.autocmds")

-- Bootstrap lazy
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.uv.fs_stat(lazypath) then
    vim.fn.system({
        "git",
        "clone",
        "--filter=blob:none",
        "https://github.com/folke/lazy.nvim.git",
        "--branch=stable",
        lazypath,
    })
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup("plugins", {
    debug = false,
    defaults = {
        lazy = true,
    },
    performance = {
        cache = {
            enabled = true,
        },
    },
})

