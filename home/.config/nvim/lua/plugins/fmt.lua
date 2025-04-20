return {
  'stevearc/conform.nvim',
  event = 'VeryLazy',
  config = function()
    local conform = require 'conform'
    conform.setup {
      -- Map of filetype to formatters
      formatters_by_ft = {
        lua = { 'stylua' },
        ocaml = { 'ocamlformat' }, -- opam
        json = { 'prettier' },
        markdown = { 'prettier' },
        yaml = { 'prettier' },
        html = { 'prettier' },
        tex = { 'latexindent' },
        -- Use the "*" filetype to run formatters on all filetypes.
        -- ['*'] = { 'codespell' },
        -- Use the "_" filetype to run formatters on filetypes that don't
        -- have other formatters configured.
      },
      -- If this is set, Conform will run the formatter on save.
      -- It will pass the table to conform.format().
      -- This can also be a function that returns the table.
      format_on_save = {
        -- I recommend these options. See :help conform.format for details.
        lsp_format = 'fallback',
        timeout_ms = 500,
      },
      -- Set the log level. Use `:ConformInfo` to see the location of the log file.
      log_level = vim.log.levels.WARN,
      -- Conform will notify you when a formatter errors
      notify_on_error = true,
      -- Conform will notify you when no formatters are available for the buffer
      notify_no_formatters = true,
    }

    local fmt = function()
      conform.format({ lsp_format = 'fallback' }, nil)
    end

    vim.keymap.set('n', '<leader>if', fmt, { desc = '[f]ormatter' })

    local toggleFormatOnSave = function()
      vim.g.disable_autoformat = not vim.g.disable_autoformat
    end

    vim.keymap.set('n', '<leader>of', toggleFormatOnSave, { desc = 'auto [f]ormat' })
  end,
}
