-- [[ Setting options ]]
-- See `:help vim.opt`
-- NOTE: You can change these options as you wish!
--  For more options, you can see `:help option-list`

-- Make line numbers default
vim.opt.number = true
vim.opt.relativenumber = true

-- Keep signcolumn on by default
-- vim.opt.signcolumn = 'number'

-- Enable mouse mode, can be useful for resizing splits for example!
vim.opt.mouse = 'a'

-- Don't show the mode, since it's already in status line
-- vim.opt.showmode = false

-- Sync clipboard between OS and Neovim.
--  Schedule the setting after `UiEnter` because it can increase startup-time.
--  Remove this option if you want your OS clipboard to remain independent.
--  See `:help 'clipboard'`
vim.schedule(function()
  vim.opt.clipboard = 'unnamedplus'
end)

-- Enable break indent
vim.opt.breakindent = true

-- Save undo history
vim.opt.undofile = true

-- Case-insensitive searching UNLESS \C or capital in search
vim.opt.ignorecase = true
vim.opt.smartcase = true

-- don't timeout in keymap sequence
vim.opt.timeout = false

-- Configure how new splits should be opened
vim.opt.splitright = true
vim.opt.splitbelow = true

-- Preview substitutions live, as you type!
vim.opt.inccommand = 'split'

-- Show which line your cursor is on
vim.opt.cursorline = true

-- Minimal number of screen lines to keep above and below the cursor.
vim.opt.scrolloff = 10

-- Set highlight on search, but clear on pressing <Esc> in normal mode
vim.opt.hlsearch = true

-- No more annoying swap file
vim.opt.swapfile = false

-- Show more char info
vim.opt.list = true
vim.opt.listchars = {
  -- eol = '󰌑',
  tab = ' ',
  trail = '·',
  nbsp = '␣',
}

-- Sensible tab because i hate 8 space tab
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4

-- Rounded border for all floating windows
vim.o.winborder = 'rounded'

-- Virtual line is great at pointing out error location and differentiate multiples of them in one line,
-- but it will move my codes around and make it flicker
-- some options are considered:
-- 1. [x] current_line = true -- less noise but not good enough because as I scroll through my codes it will still flicker; so i guess I'll just scroll less and jump more then
-- 2. [ ] vim.diagnostic.open_float() like but show virtual line instead of a floating window

vim.diagnostic.config {
  virtual_lines = {
    current_line = true,
  },
  virtual_text = true,
}

-- vim.keymap.set('n', '<C-w>d', function()
--   vim.diagnostic.config { virtual_lines = { current_line = true }, virtual_text = false }
--
--   vim.api.nvim_create_autocmd('CursorMoved', {
--     -- with a autocmd group and clear=true, we can create as many such autocmds as we want and at most one instance will exist
--     group = vim.api.nvim_create_augroup('line-diagnostics', { clear = true }),
--     callback = function()
--       vim.diagnostic.config { virtual_lines = false, virtual_text = true }
--       return true
--     end,
--   })
-- end)
