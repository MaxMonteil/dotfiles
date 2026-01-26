return {
  'ibhagwan/fzf-lua',
  keys = {
    { '<Leader>f',  '<cmd>FzfLua git_files<CR>',    desc = 'Find git-aware files' },
    { '<Leader>F',  '<cmd>FzfLua files<CR>',        desc = 'Find files' },
    { '<Leader>ls', '<cmd>FzfLua buffers<CR>',      desc = 'Find buffers' },
    { '<Leader>/',  '<cmd>FzfLua grep_project<CR>', desc = 'Search project' },
  },
  opts = {},
}
