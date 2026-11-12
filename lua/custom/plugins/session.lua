vim.pack.add { 'https://github.com/folke/persistence.nvim' }
local persistence = require 'persistence'
persistence.setup {}

vim.keymap.set('n', '<leader>qs', function() persistence.load() end, { desc = 'Restore session' })
vim.keymap.set('n', '<leader>qS', function() persistence.select() end, { desc = 'Select session' })
vim.keymap.set('n', '<leader>ql', function() persistence.load { last = true } end, { desc = 'Restore last session' })
vim.keymap.set('n', '<leader>qd', function() persistence.stop() end, { desc = 'Stop saving the session' })
