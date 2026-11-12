vim.pack.add { 'https://github.com/kdheepak/lazygit.nvim' }
require('telescope').load_extension 'lazygit'
vim.keymap.set('n', '<leader>gg', '<Cmd>LazyGit<CR>', { desc = 'Open LazyGit', silent = true })
