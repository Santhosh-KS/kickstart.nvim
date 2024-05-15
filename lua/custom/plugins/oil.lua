return {
  {
    'stevearc/oil.nvim',
    opts = {},
    -- Optional dependencies
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    config = function()
      local oil = require 'oil'
      oil.setup {
        columns = { 'icon' },
        view_options = {
          show_hidden = true,
        },
      }
      vim.keymap.set('n', '-', '<cmd>Oil<CR>', { desc = 'open parent directory' })
      vim.keymap.set('n', '<leader>-', oil.toggle_float)
    end,
  },
}
