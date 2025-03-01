return {
  'stevearc/conform.nvim',
  event = 'VeryLazy',
  config = function()
    local conform = require 'conform'
    conform.setup {
      notify_on_error = true,
      format_on_save = function(_)
        -- Disable with a global or buffer-local variable
        if vim.g.disable_autoformat then
          return
        end
        return { timeout_ms = 500, lsp_fallback = true }
      end,
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
        ['_'] = { 'trim_whitespace' },
      },
    }

    local fmt = function()
      conform.format({ lsp_fallback = true }, nil)
    end

    vim.keymap.set('n', '<leader>if', fmt, { desc = '[f]ormatter' })

    local toggleFormatOnSave = function()
      vim.g.disable_autoformat = not vim.g.disable_autoformat
    end

    vim.keymap.set('n', '<leader>of', toggleFormatOnSave, { desc = 'auto [f]ormat' })
  end,
}
