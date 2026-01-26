return {
  'mhinz/vim-startify',
  lazy = false,
  keys = {
    { '<Space>s', '<cmd>Startify<CR>', desc = 'Startify' },
  },
  config = function()
    vim.g.startify_change_to_vcs_root = 1
    vim.g.startify_change_to_dir = 1
    vim.g.startify_session_persistence = 1
    vim.g.startify_files_number = 5
    vim.g.startify_bookmarks = {
      { n = '~/.config/nvim/init.lua' },
      { t = '~/.config/tmux/tmux.conf' },
    }
  end
}
