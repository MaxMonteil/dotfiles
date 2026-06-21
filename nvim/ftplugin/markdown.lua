vim.opt_local.foldmethod = 'manual'   -- Use manual folding

-- Save folds in markdown files across sessions
local folds_augroup = vim.api.nvim_create_augroup('Folds', { clear = false })
local last_cursor = {}

vim.api.nvim_create_autocmd({'BufWritePost', 'QuitPre'}, {
  desc = 'Save folds in markdown on write and before quit.',
  group = folds_augroup,
  buffer = 0,
  command = 'mkview',
})

vim.api.nvim_create_autocmd('BufLeave', {
  desc = 'Remember cursor position before leaving this markdown buffer.',
  group = folds_augroup,
  buffer = 0,
  callback = function(args)
    last_cursor[args.buf] = vim.api.nvim_win_get_cursor(0)
  end,
})

vim.api.nvim_create_autocmd('BufWinEnter', {
  desc = 'Restore markdown folds on window enter.',
  group = folds_augroup,
  buffer = 0,
  callback = function(args)
    vim.cmd('silent! loadview | normal! zM')
    local pos = last_cursor[args.buf]
    if pos then pcall(vim.api.nvim_win_set_cursor, 0, pos) end
  end
})
