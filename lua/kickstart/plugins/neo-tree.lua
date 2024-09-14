-- Neo-tree is a Neovim plugin to browse the file system
-- https://github.com/nvim-neo-tree/neo-tree.nvim

return {
  'nvim-neo-tree/neo-tree.nvim',
  version = '*',
  dependencies = {
    'nvim-lua/plenary.nvim',
    'nvim-tree/nvim-web-devicons', -- not strictly required, but recommended
    'MunifTanjim/nui.nvim',
  },
  cmd = 'Neotree',
  keys = {
    { '<leader>e', ':Neotree reveal<CR>', desc = 'NeoTree reveal', silent = true },
    { '<leader>h', ':Neotree close<CR>', desc = 'NeoTree close', silent = true },
  },
  -- neotree auto close
  -- config = function()
  --   require('neo-tree').setup {
  --     event_handlers = {
  --       {
  --         event = 'file_open_requested',
  --         handler = function()
  --           require('neo-tree.command').execute { action = 'close' }
  --         end,
  --       },
  --     },
  --   }
  -- end,
  opts = {
    filesystem = {
      window = {
        mappings = {
          ['\\'] = 'close_window',
        },
      },
    },
  },
}
