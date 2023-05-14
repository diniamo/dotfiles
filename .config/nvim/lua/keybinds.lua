vim.g.mapleader = " "
local vimp = require('vimp')

-- Yes im hungarian
-- vim.cmd(':set langmap=jh,kj,lk,él,JH,KJ,LK,ÉL')

vimp.nnoremap('<CR>', 'o<ESC>')
vimp.nnoremap('<S-CR>', 'O<ESC>')
-- vimp.nnoremap('<CR>', 'i<CR><ESC>')
vimp.nnoremap('<leader>;', function()
	local cursor = vim.api.nvim_win_get_cursor(0)
	vim.cmd(':normal A;')
	vim.api.nvim_win_set_cursor(0, cursor)
end) -- '$a;<ESC>j')

vimp.inoremap('<C-BS>', '<C-W>')
vimp.nnoremap('<C-A>', 'ggVG')

-- Line moving
vimp.nnoremap('<A-j>', ':m .+1<CR>==')
vimp.nnoremap('<A-k>', ':m .-2<CR>==')
vimp.inoremap('<A-j>', '<Esc>:m .+1<CR>==gi')
vimp.inoremap('<A-k>', '<Esc>:m .-2<CR>==gi')
vimp.vnoremap('<A-j>', ":m '>+1<CR>gv=gv")
vimp.vnoremap('<A-k>', ":m '<-2<CR>gv=gv")

-- Neotree
vimp.nnoremap('<leader>n', '<Cmd>Neotree<CR>')
vimp.nnoremap('<leader>s', '<Cmd>Neotree source=git_status position=float<CR>')

-- Trouble
vimp.nnoremap('<Leader>tr', '<Cmd>TroubleToggle<CR>')

-- Telescope
vimp.nnoremap('<leader>tf', '<Cmd>Telescope find_files<cr>')
vimp.nnoremap('<leader>tg', '<Cmd>Telescope live_grep<cr>')
vimp.nnoremap('<leader>tb', '<Cmd>Telescope buffers<cr>')
vimp.nnoremap('<leader>th', '<Cmd>Telescope help_tags<cr>')

-- Buffers
vimp.nnoremap({ 'silent' }, '<Tab>', '<Cmd>BufferNext<CR>')
vimp.nnoremap({ 'silent' }, '<S-Tab>', '<Cmd>BufferPrevious<CR>')

vimp.nnoremap({ 'silent' }, '<A-<Right>>', '<Cmd>BufferMoveNext<CR>')
vimp.nnoremap({ 'silent' }, '<A-<Left>>', '<Cmd>BufferMovePrevious<CR>')

vimp.nnoremap({ 'silent' }, '<Leader>p', '<Cmd>BufferPick<CR>')

for i = 1, 9 do
	vimp.nmap({ 'silent' }, ('A-%s'):format(i), ('<Cmd>BufferGoto %s<CR>'):format(i))
end
vimp.nmap({ 'silent' }, 'A-0', '<Cmd>BufferLast<CR>')

vimp.nnoremap('<leader>w', '<Cmd>BufferClose<CR>')
