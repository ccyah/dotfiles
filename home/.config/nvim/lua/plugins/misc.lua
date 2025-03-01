return {
  'tpope/vim-sleuth', -- Detect tabstop and shiftwidth automatically

  {
    'RRethy/vim-illuminate',
    event = 'VeryLazy',
    config = function()
      require('illuminate').configure {
        large_file_cutoff = 50000,
      }
    end,
  },

  {
    'echasnovski/mini.nvim',
    config = function()
      -- Better Around/Inside textobjects
      --
      -- Examples:
      --  - va)  - [V]isually select [A]round [)]paren
      --  - yinq - [Y]ank [I]nside [N]ext [']quote
      --  - ci'  - [C]hange [I]nside [']quote
      require('mini.ai').setup { n_lines = 500 }

      -- Add/delete/replace surroundings (brackets, quotes, etc.)
      --
      -- - saiw) - [S]urround [A]dd [I]nner [W]ord [)]Paren
      -- - sd'   - [S]urround [D]elete [']quotes
      -- - sr)'  - [S]urround [R]eplace [)] [']
      require('mini.surround').setup()

      require('mini.pairs').setup()

      vim.g.minipairs_disable = false
      local toggleAutoPair = function()
        vim.g.minipairs_disable = not vim.g.minipairs_disable
      end

      vim.keymap.set('n', '<leader>op', toggleAutoPair, { desc = 'auto [p]air' })
    end,
  },

  {
    'folke/which-key.nvim',
    config = function()
      local wk = require 'which-key'
      wk.setup {
        preset = 'helix',
        delay = 0,
        icons = {
          rules = false,
        },
        win = {
          wo = {
            -- winblend = 10, -- value between 0-100 0 for fully opaque and 100 for fully transparent
          },
        },
      }
      wk.add {
        { '<leader>p', group = '[p]ick' },
        { '<leader>o', group = '[o]ption' },
        { '<leader>i', group = '[i]nvoke' },
        { '<leader>g', group = '[g]it' },
      }
    end,
  },

  {
    'mbbill/undotree',
    config = function()
      vim.keymap.set('n', '<leader>u', vim.cmd.UndotreeToggle, { desc = '[u]ndo tree' })
    end,
  },

  {
    'aaronik/treewalker.nvim',
    config = function()
      -- The following options are the defaults.
      -- Treewalker aims for sane defaults, so these are each individually optional,
      -- and the whole opts block is optional as well.
      require('treewalker').setup {
        -- Whether to briefly highlight the node after jumping to it
        highlight = true,

        -- How long should above highlight last (in ms)
        highlight_duration = 250,

        -- The color of the above highlight. Must be a valid vim highlight group.
        -- (see :h highlight-group for options)
        highlight_group = 'ColorColumn',
      }

      vim.keymap.set({ 'n', 'v' }, '<M-k>', '<cmd>Treewalker Up<cr>', { noremap = true, silent = true })
      vim.keymap.set({ 'n', 'v' }, '<M-j>', '<cmd>Treewalker Down<cr>', { noremap = true, silent = true })
      vim.keymap.set({ 'n', 'v' }, '<M-l>', '<cmd>Treewalker Right<cr>', { noremap = true, silent = true })
      vim.keymap.set({ 'n', 'v' }, '<M-h>', '<cmd>Treewalker Left<cr>', { noremap = true, silent = true })
    end,
  },

  {
    'nvchad/showkeys',
    cmd = 'ShowkeysToggle',
    opts = {
      timeout = 1,
      maxkeys = 3,
      show_count = true,
    },
  },

  { 'meznaric/key-analyzer.nvim', opts = {} },
}
