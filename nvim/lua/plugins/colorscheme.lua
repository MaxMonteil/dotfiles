return {
  'catppuccin/nvim',
  name = 'catppuccin',
  lazy = false,
  priority = 1000,
  opts = { auto_integrations = true },
  config = function(_, opts)
    require('catppuccin').setup(opts)

    local theme = os.getenv('MM_THEME') or 'catppuccin-mocha'

    vim.cmd.colorscheme(theme)
  end
}
