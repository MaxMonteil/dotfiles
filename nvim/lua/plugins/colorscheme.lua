return {
  'catppuccin/nvim',
  name = 'catppuccin',
  lazy = false,
  priority = 1000,
  opts = { auto_integrations = true },
  config = function(_, opts)
    require('catppuccin').setup(opts)

    -- vim.cmd.colorscheme 'catppuccin-latte'
    -- vim.cmd.colorscheme 'catppuccin-frappe'
    -- vim.cmd.colorscheme 'catppuccin-macchiato'
    vim.cmd.colorscheme 'catppuccin-mocha'
  end
}
