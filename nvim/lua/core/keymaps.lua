vim.g.mapleader = ' ' -- Remap leader to space

vim.keymap.set('n', '<Leader><Leader>', '<cmd>nohls<CR>', { desc = 'Clear search highlighting.' })

--------------------
-- BUFFER & SPLIT --
--------------------

-- Quicker Split Navigation --
vim.keymap.set('n', '<C-h>', '<C-w>h', { desc = 'Move split focus left.' })
vim.keymap.set('n', '<C-j>', '<C-w>j', { desc = 'Move focus down.' })
vim.keymap.set('n', '<C-k>', '<C-w>k', { desc = 'Move focus up.' })
vim.keymap.set('n', '<C-l>', '<C-w>l', { desc = 'Move focus right.' })

vim.keymap.set('n', '<C-c>', '<C-w>c', { desc = 'Close current split.' })
vim.keymap.set('n', '<C-d>', '<cmd>bdelete<CR>', { desc = 'Delete current buffer.' })

-- Tab Through Open Buffers --
vim.keymap.set('n', '<Tab>', '<cmd>bnext<CR>', { desc = 'Cycle to next buffer.' })
vim.keymap.set('n', '<S-Tab>', '<cmd>bprev<CR>', { desc = 'Cycle to previous buffer.' })

vim.keymap.set('n', '<Space>3', '<cmd>b#<CR>', { desc = 'Go to last buffer.' })

-- Close all buffers except the current one
vim.api.nvim_create_user_command('BufOnly', function()
  vim.cmd('silent! %bd|e#|bd#')
end, {})

vim.keymap.set('n', '<Space>bo', '<cmd>BufOnly<CR>',
  { desc = 'Close all buffers except current one.' })

-----------------
-- LSP Keymaps --
-----------------
vim.keymap.set('n', '<Leader>lf', vim.lsp.buf.format, { desc = 'Format current buffer.' })

vim.keymap.del('n', ']d')
vim.keymap.set('n', ']g', '<cmd>lua vim.diagnostic.jump({ count = 1, float = true })<CR>',
  { desc = 'Jump to next diagnostic' })

vim.keymap.del('n', '[d')
vim.keymap.set('n', '[g', '<cmd>lua vim.diagnostic.jump({ count = -1, float = true })<CR>',
  { desc = 'Jump to previous diagnostic.' })

vim.diagnostic.config({
  virtual_text = true,
  virtual_lines = { current_line = true },
})

-----------------
-- Term Keymaps --
-----------------
vim.keymap.set('n', 'tt', function()
  vim.cmd('bel 15 split | term')
  vim.cmd('normal! jli')
end, { silent = true, desc = 'Open a terminal window below in insert mode.' })

vim.keymap.set('t', '<Esc>', '<C-\\><C-n>',
  { desc = 'Map escape to leave insert mode in a terminal.' })

vim.api.nvim_create_autocmd('TermOpen', {
  pattern = '*',
  callback = function()
    vim.keymap.set('n', '<C-d>', ':bd!<CR>', {
      buffer = true,
      silent = true,
      desc = 'Force close the terminal window.',
    })
  end,
})
