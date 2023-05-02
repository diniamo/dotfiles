vim.g.mapleader = " "
local vimp = require('vimp')

-- Yes im hungarian
-- vim.cmd(':set langmap=jh,kj,lk,él,JH,KJ,LK,ÉL')

vimp.nnoremap('<CR>', 'o<ESC>')
vimp.nnoremap('<S-CR>', 'O<ESC>')
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
vimp.nnoremap('<leader>n', '<cmd>Neotree<CR>')
vimp.nnoremap('<leader>s', '<cmd>Neotree source=git_status position=float<CR>')

-- Trouble
vimp.nnoremap('<Leader>tr', '<cmd>TroubleToggle<CR>')

-- Telescope
vimp.nnoremap('<leader>tf', '<cmd>Telescope find_files<cr>')
vimp.nnoremap('<leader>tg', '<cmd>Telescope live_grep<cr>')
vimp.nnoremap('<leader>tb', '<cmd>Telescope buffers<cr>')
vimp.nnoremap('<leader>th', '<cmd>Telescope help_tags<cr>')

-- vimp.nnoremap('<C-t>', '<cmd>ToggleTerm<CR>')
-- vimp.tnoremap('<C-t>', '<cmd>ToggleTerm<CR>')

-- cokeline
vimp.nnoremap({ 'silent' }, '<Tab>', '<Plug>(cokeline-focus-next)')
vimp.nnoremap({ 'silent' }, '<S-Tab>', '<Plug>(cokeline-focus-prev)')
for i = 1, 9 do
	vimp.nmap({ 'silent' }, ('<Leader>%s'):format(i), ('<Plug>(cokeline-focus-%s)'):format(i))
	-- vimp.nmap({'silent'}, ('<Leader>s%s'):format(i), ('<Plug>(cokeline-switch-%s)'):format(i))
	-- vimp.nmap({'silent'}, ('<Leader>S%s'):format(i), ('<Plug>(cokeline-switch-%s)'):format(i))
end

vimp.nnoremap('<leader>w', '<cmd>bd<CR>')
