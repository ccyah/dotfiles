local use_colorscheme = function(name, opts)
  require(name).setup(opts)
  vim.cmd.colorscheme(name)
end

return {
  {
    'folke/tokyonight.nvim',
    lazy = true,
    opts = {
      -- transparent = true,
    },
    -- config = function(_, opts)
    --   use_colorscheme('tokyonight', opts)
    -- end,
  },

  {
    'catppuccin/nvim',
    name = 'catppuccin',
    priority = 1000,
    opts = {
      transparent_background = true,
      background = { -- :h background
        light = "latte",
        dark = "frappe",
      },
    },
    config = function(_, opts)
      use_colorscheme('catppuccin', opts)
    end,
  },

  {
    'rebelot/kanagawa.nvim',
    lazy = true,
    opts = {
      -- transparent = true,
    },
  },

  {
    'ellisonleao/gruvbox.nvim',
    lazy = true,
  },

  {
    'ribru17/bamboo.nvim',
    lazy = true,
    opts = {
      highlights = {
        ['@comment'] = { fg = '$grey' },
      },
    },
  },

  -- {
  --   -- Set lualine as statusline
  --   'nvim-lualine/lualine.nvim',
  --   -- See `:help lualine.txt`
  --   opts = {
  --     options = {
  --       theme = 'auto',
  --       component_separators = '',
  --       section_separators = '',
  --     },
  --     sections = {
  --       lualine_a = { 'mode' },
  --       -- lualine_b = { 'filename', 'diagnostics' },
  --       lualine_b = {
  --         {
  --           'filename',
  --           path = 1, -- 1: show relative path
  --         },
  --         'diagnostics',
  --       },
  --       lualine_c = { 'branch', 'diff' },
  --       lualine_x = { 'encoding', 'fileformat', 'filetype' },
  --       lualine_y = { 'progress' },
  --       lualine_z = { 'location' },
  --     },
  --     inactive_sections = {
  --       lualine_a = {},
  --       lualine_b = { 'filename' },
  --       lualine_c = {},
  --       lualine_x = { 'location' },
  --       lualine_y = {},
  --       lualine_z = {},
  --     },
  --   },
  -- },
}
