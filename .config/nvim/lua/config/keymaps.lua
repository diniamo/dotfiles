local set = vim.keymap.set

set('n', '<CR>', 'o<ESC>')
set('n', '<S-CR>', 'O<ESC>')

-- HACK: defer_fn makes this a bit slow visually
set('i', '<S-CR>', function()
    local cursor = vim.api.nvim_win_get_cursor(0)
    vim.api.nvim_feedkeys('\r', 'i', false)
    vim.defer_fn(function()
        vim.api.nvim_win_set_cursor(0, cursor)
    end, 0)
end)

set('n', '<Leader><CR>', 'i<CR><ESC>')
set('n', '<Leader><S-CR>', 'i<S-CR><ESC>')

set('n', '<leader>;', function()
    local cursor = vim.api.nvim_win_get_cursor(0)
    vim.cmd(':normal A;')
    vim.api.nvim_win_set_cursor(0, cursor)
end)

set('i', '<C-h>', '<C-w>')
set('i', '<C-Del>', '<C-o>de')
set('n', '<C-a>', 'ggVG')

set('n', '<A-i>', '<C-a>')
set('n', '<A-d>', '<C-x>')

-- Line moving
set('n', '<C-j>', ':m .+1<CR>==')
set('n', '<C-k>', ':m .-2<CR>==')
set('i', '<C-j>', '<Esc>:m .+1<CR>==gi')
set('i', '<C-k>', '<Esc>:m .-2<CR>==gi')
set('v', '<C-j>', ":m '>+1<CR>gv=gv")
set('v', '<C-k>', ":m '<-2<CR>gv=gv")

set('n', '<Leader>q', '<Cmd>q<CR>')
