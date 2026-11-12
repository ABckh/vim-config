vim.g.mapleader = ' '
vim.g.maplocalleader = ','

vim.opt.number = true
vim.opt.mouse = 'a'
vim.opt.breakindent = true
vim.opt.undofile = true
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.timeoutlen = 300
vim.opt.signcolumn = 'yes'
vim.opt.splitright = true
vim.opt.splitbelow = true
vim.opt.cursorline = true

vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>')
vim.keymap.set('n', '<leader>qq', '<cmd>qa<CR>', { desc = 'Quit all' })
vim.keymap.set('n', '<leader>-', '<cmd>split<CR>', { desc = 'Split below' })
vim.keymap.set('n', '<leader>|', '<cmd>vsplit<CR>', { desc = 'Split right' })

local window_directions = { h = 'left', j = 'lower', k = 'upper', l = 'right' }
for key, direction in pairs(window_directions) do
  local command = '<C-w>' .. key
  local opts = { desc = 'Move focus to the ' .. direction .. ' window' }
  vim.keymap.set('n', '<leader>' .. key, command, opts)
  vim.keymap.set('n', '<C-' .. key .. '>', command, opts)
end

vim.keymap.set('t', '<Esc><Esc>', '<C-\\><C-n>', { desc = 'Exit terminal mode' })

vim.api.nvim_create_autocmd('LspAttach', {
  callback = function(event)
    local client = vim.lsp.get_client_by_id(event.data.client_id)
    if client:supports_method 'textDocument/completion' then
      vim.lsp.completion.enable(true, client.id, event.buf, { autotrigger = true })
    end

    local opts = { buffer = event.buf }
    local telescope = require 'telescope.builtin'
    vim.keymap.set('n', 'gd', telescope.lsp_definitions, opts)
    vim.keymap.set('n', 'gr', telescope.lsp_references, opts)
    vim.keymap.set('n', 'gI', telescope.lsp_implementations, opts)
    vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, opts)
    vim.keymap.set('n', '<leader>D', telescope.lsp_type_definitions, opts)
    vim.keymap.set('n', '<leader>ds', telescope.lsp_document_symbols, opts)
    vim.keymap.set('n', '<leader>ws', telescope.lsp_dynamic_workspace_symbols, opts)
    vim.keymap.set({ 'n', 'x' }, '<leader>ca', vim.lsp.buf.code_action, opts)
    vim.keymap.set('n', '<leader>cd', vim.diagnostic.open_float, opts)
    vim.keymap.set('n', '<leader>cr', vim.lsp.buf.rename, opts)
  end,
})

vim.lsp.config('pyright', {
  cmd = { 'pyright-langserver', '--stdio' },
  filetypes = { 'python' },
  root_markers = { 'pyproject.toml', 'pyrightconfig.json', 'setup.py', 'setup.cfg', 'requirements.txt', 'Pipfile', '.git' },
})
if vim.fn.executable 'pyright-langserver' == 1 then
  vim.lsp.enable 'pyright'
end

vim.api.nvim_create_user_command('LazyGit', function()
  if vim.fn.executable 'lazygit' ~= 1 then
    vim.notify('lazygit is missing from PATH', vim.log.levels.ERROR)
    return
  end

  local buffer = vim.api.nvim_create_buf(false, true)
  vim.bo[buffer].bufhidden = 'wipe'
  local window = vim.api.nvim_open_win(buffer, true, {
    relative = 'editor',
    row = 0,
    col = 0,
    width = vim.o.columns,
    height = math.max(1, vim.o.lines - vim.o.cmdheight - 1),
    style = 'minimal',
  })
  vim.fn.jobstart({ 'lazygit' }, {
    term = true,
    on_exit = function(_, status)
      if status == 0 and vim.api.nvim_win_is_valid(window) then
        vim.api.nvim_win_close(window, false)
      end
    end,
  })
  vim.cmd.startinsert()
end, {})
vim.keymap.set('n', '<leader>gg', '<cmd>LazyGit<CR>', { desc = 'Open LazyGit' })

local lazypath = vim.fn.stdpath 'data' .. '/lazy/lazy.nvim'
if not vim.uv.fs_stat(lazypath) then
  local output = vim.fn.system { 'git', 'clone', '--filter=blob:none', '--branch=stable', 'https://github.com/folke/lazy.nvim.git', lazypath }
  if vim.v.shell_error ~= 0 then
    error('Could not install lazy.nvim:\n' .. output)
  end
end
vim.opt.rtp:prepend(lazypath)

require('lazy').setup({
  {
    'luisiacc/gruvbox-baby',
    priority = 1000,
    config = function()
      vim.o.background = 'dark'
      vim.cmd.colorscheme 'gruvbox-baby'
      vim.cmd.hi 'Comment gui=none'
    end,
  },
  {
    'lewis6991/gitsigns.nvim',
    opts = {
      signs = {
        add = { text = '+' },
        change = { text = '~' },
        delete = { text = '_' },
        topdelete = { text = '‾' },
        changedelete = { text = '~' },
      },
    },
  },
  require 'kickstart.plugins.gitsigns',
  require 'kickstart.plugins.neo-tree',
  require 'kickstart.plugins.telescope',
}, {
  pkg = { enabled = false },
  rocks = { enabled = false },
  install = { colorscheme = { 'gruvbox-baby' } },
})
