return {
  'nvim-mini/mini.nvim',
  version = '*',
  config = function()
    require('mini.icons').setup()
    require('mini.tabline').setup()
    require('mini.diff').setup()
    require('mini.git').setup()
    require('mini.pairs').setup()
    require('mini.statusline').setup()
    require('mini.surround').setup()

    require('mini.files').setup({
      windows = {
        preview = true,
        width_preview = 75,
      },
    })
    vim.keymap.set('n', '<Leader>e', function()
      if not MiniFiles.close() then MiniFiles.open(vim.api.nvim_buf_get_name(0)) end
    end, { desc = 'Toggle file explorer.' })

    vim.api.nvim_create_autocmd('User', {
      pattern = 'MiniFilesWindowOpen',
      callback = function()
        vim.keymap.set('n', '<ESC>', MiniFiles.close, { desc = 'Close file explorer when open.' })
      end,
    })

    require('mini.comment').setup({
      options = {
        custom_commentstring = function()
          return require('ts_context_commentstring').calculate_commentstring() or vim.bo.commentstring
        end,
      },
    })

    require('mini.completion').setup({
      lsp_completion = {
        source_func = 'omnifunc',
        auto_setup = true,
      },
    })

    require('mini.snippets').setup()

    local mini_keymap = require('mini.keymap')
    mini_keymap.setup()

    local map_multistep = mini_keymap.map_multistep

    local tab_steps = { 'minisnippets_next', 'minisnippets_expand', 'pmenu_next' }
    map_multistep('i', '<Tab>', tab_steps)

    local shifttab_steps = { 'minisnippets_prev', 'pmenu_prev' }
    map_multistep('i', '<S-Tab>', shifttab_steps)

    map_multistep('i', '<CR>', { 'pmenu_accept', 'minipairs_cr' })
    map_multistep('i', '<BS>', { 'minipairs_bs' })
  end
}
