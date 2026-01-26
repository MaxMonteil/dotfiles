return {
  'nvim-treesitter/nvim-treesitter',
  branch = 'master',
  lazy = false,
  event = { 'BufReadPre', 'BufNewFile' },
  build = ':TSUpdate',
  opts = {
    ensure_installed = {
      'lua',
      'vue',
      'typescript',
      'javascript',
      'html',
      'css',
      'markdown',
      'vimdoc',
    },
    auto_install = true,
    highlight = { enable = true },
    indent = { enable = true },
    incremental_selection = {
      enable = true,
      keymaps = {
        init_selection = 'gv',
        node_incremental = 'g.',
        scope_incremental = 'g>',
        node_decremental = 'g,',
      },
    },
  },
  config = function(_, opts)
    require('nvim-treesitter.configs').setup(opts)
  end
}
