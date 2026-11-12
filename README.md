# Neovim for Python

Based on [kickstart.nvim](https://github.com/nvim-lua/kickstart.nvim).

In the devcontainer, put this repository at `${XDG_CONFIG_HOME:-$HOME/.config}/nvim`. Install Neovim 0.11 or newer, Git, LazyGit, and Pyright with Node.js. Make sure `lazygit` and `pyright-langserver` are on the container user's `PATH`. Use the project's Python interpreter and dependencies as you normally would.

Open a Python file to start Pyright. Completion uses Neovim's built-in menu. Press `gd` to go to a definition, `K` for hover, or `<Space>cr` to rename a symbol.

Run `:LazyGit` or press `<Space>gg` from the repository directory.

The first launch downloads the pinned Neovim plugins. Press `<Space>e` to open Neo-tree and `<Space>E` to close it. Neo-tree icons use a Nerd Font in your terminal. Gitsigns shows changed lines and uses `]c` and `[c` to jump between hunks.

Install `ripgrep` for Telescope search. Press `<Space><Space>` to find files, `<Space>/` to grep the project, `<Space>sb` to search the current buffer, or `<Space>ss` to list pickers. The optional native sorter needs `make` and a C compiler.

Use `<Space>h/j/k/l` or `Ctrl+h/j/k/l` to move between Neovim splits.
