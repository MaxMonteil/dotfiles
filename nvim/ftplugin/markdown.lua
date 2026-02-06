vim.opt_local.foldmethod = 'manual'   -- Use manual folding

-- Save folds in markdown files across sessions
local folds_augroup = vim.api.nvim_create_augroup('Folds', { clear = true })

vim.api.nvim_create_autocmd({'BufWritePost', 'QuitPre'}, {
  desc = 'Save folds in markdown on write and before quit.',
  group = folds_augroup,
  command = 'mkview',
})

vim.api.nvim_create_autocmd('BufWinEnter', {
  desc = 'Restore markdown folds on window enter.',
  group = folds_augroup,
  command = 'silent! loadview | normal! zM',
})
