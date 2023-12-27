-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua

local map = vim.keymap.set

map("n", "<CR>", "o<ESC>")
map("n", "<S-CR>", "O<ESC>")

map("i", "<C-BS>", "<C-w>")
map("i", "<C-Del>", "<C-o>de")

map("n", "<C-A>", "ggVG")

map("n", "<leader>;", function()
  local cursor = vim.api.nvim_win_get_cursor(0)
  vim.cmd(":normal A;")
  vim.api.nvim_win_set_cursor(0, cursor)
end, { desc = "Appends a ; to the current line" })
