vim.g.mapleader = " "
local vimp = require('vimp')

-- vim.cmd(":set langmap=é\\;,É\\:")

vimp.nnoremap('<CR>', 'o<ESC>')
vimp.nnoremap('<S-CR>', 'O<ESC>')
-- vimp.nnoremap('<CR>', 'i<CR><ESC>')
vimp.nnoremap('<leader>;', function() local cursor = vim.api.nvim_win_get_cursor(0)
	vim.cmd(':normal A;')
	vim.api.nvim_win_set_cursor(0, cursor)
end)

vimp.inoremap('<C-BS>', '<C-W>')
vimp.inoremap('<C-Del>', '<C-O>de')
vimp.nnoremap('<C-A>', 'ggVG')

-- Line moving
vimp.nnoremap({ 'silent' }, '<C-j>', ':m .+1<CR>==')
vimp.nnoremap({ 'silent' }, '<C-k>', ':m .-2<CR>==')
vimp.inoremap({ 'silent' }, '<C-j>', '<Esc>:m .+1<CR>==gi')
vimp.inoremap({ 'silent' }, '<C-k>', '<Esc>:m .-2<CR>==gi')
vimp.vnoremap({ 'silent' }, '<C-j>', ":m '>+1<CR>gv=gv")
vimp.vnoremap({ 'silent' }, '<C-k>', ":m '<-2<CR>gv=gv")

-- Neotree
vimp.nnoremap('<leader>n', '<Cmd>Neotree<CR>')
vimp.nnoremap('<leader>s', '<Cmd>Neotree source=git_status position=float<CR>')

-- Trouble
vimp.nnoremap('<leader>xx', '<cmd>TroubleToggle document_diagnostics<cr>')
vimp.nnoremap('<leader>xd', '<cmd>TroubleToggle document_diagnostics<cr>')
vimp.nnoremap('<leader>xw', '<cmd>TroubleToggle workspace_diagnostics<cr>')
vimp.nnoremap('<leader>xq', '<cmd>TroubleToggle quickfix<cr>')
vimp.nnoremap('<leader>xl', '<cmd>TroubleToggle loclist<cr>')
vimp.nnoremap('<leader>xt', '<cmd>TodoTrouble<cr>')

-- Telescope
vimp.nnoremap('<leader>tf', '<Cmd>Telescope find_files<cr>')
vimp.nnoremap('<leader>tg', '<Cmd>Telescope live_grep<cr>')
-- vimp.nnoremap('<leader>b', '<Cmd>Telescope buffers<cr>')
vimp.nnoremap('<leader>th', '<Cmd>Telescope help_tags<cr>')

-- Buffers
vimp.nnoremap({ 'silent' }, '<Tab>', '<Cmd>BufferNext<CR>')
vimp.nnoremap({ 'silent' }, '<S-Tab>', '<Cmd>BufferPrevious<CR>')

vimp.nnoremap({ 'silent' }, '<A-Right>', '<Cmd>BufferMoveNext<CR>')
vimp.nnoremap({ 'silent' }, '<A-Left>', '<Cmd>BufferMovePrevious<CR>')

vimp.nnoremap({ 'silent' }, '<Leader>p', '<Cmd>BufferPick<CR>')

for i = 1, 9 do
	vimp.nmap({ 'silent' }, ('<A-%s>'):format(i), ('<Cmd>BufferGoto %s<CR>'):format(i))
end
vimp.nmap({ 'silent' }, '<A-0>', '<Cmd>BufferLast<CR>')

vimp.nnoremap('<Leader>w', '<Cmd>BufferClose<CR>')
vimp.nnoremap('<Leader>q', '<Cmd>q<CR>')
