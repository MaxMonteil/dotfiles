return {
  'tpope/vim-fugitive',
  keys = {
    {
      '<Leader>g',
      function()
        if vim.bo.filetype == 'fugitive' then
          vim.cmd('normal gq')
        else
          vim.cmd('G')
        end
      end,
      desc = 'Toggle Fugitive window',
    },
  },
}
