-- for Go Templ
vim.filetype.add { extension = { templ = 'templ' } }

return {
  'neovim/nvim-lspconfig',
  event = 'VeryLazy',
  dependencies = {
    -- Useful status updates for LSP
    { 'j-hui/fidget.nvim', config = true },

    -- Additional lua configuration, makes nvim stuff amazing!
    {
      'folke/lazydev.nvim',
      ft = 'lua', -- only load on lua files
      config = true,
    },

    -- lsp completion capabilities
    'saghen/blink.cmp',

    -- need it for kemaps and vim.ui.select
    'ibhagwan/fzf-lua',
  },
  config = function()
    --[[------------------- My LSP configs ---------------------------]]
    local servers = {
      markdown_oxide = {},
      gopls = {}, -- go install golang.org/x/tools/gopls@latest
      golangci_lint_ls = {}, -- go install github.com/nametake/golangci-lint-langserver@latest
      lua_ls = {
        settings = {
          Lua = {
            hint = {
              enable = true,
            },
          },
        },
      },
      ocamllsp = {}, -- opam
      elixirls = {
        cmd = { 'elixir-ls' },
      }, -- opam
      clangd = {},
      pyright = {},
      ruff = {},
      tinymist = {
        -- offset_encoding = 'utf-8', -- https://github.com/Myriad-Dreamin/tinymist/issues/638#issuecomment-2395941103
        settings = {
          exportPdf = 'onSave',
          -- outputPath = '$root/target/$dir/$name',
          formatterMode = 'typstyle',
        },
      },
      typos_lsp = {
        autostart = false,
        init_options = {
          -- How typos are rendered in the editor, can be one of an Error, Warning, Info or Hint.
          -- Defaults to error.
          diagnosticSeverity = 'Hint',
        },
      },
    }

    --[[--------- Setup servers using configs above ------------------]]
    for server_name, config in pairs(servers) do
      -- This handles overriding only values explicitly passed
      -- by the server configuration above. Useful when disabling
      -- certain features of an LSP (for example, turning off formatting for tsserver)
      config.capabilities = require('blink.cmp').get_lsp_capabilities(config.capabilities)
      require('lspconfig')[server_name].setup(config)
    end

    --[[-------------------- LSP keymaps -----------------------------]]
    local fzf = require 'fzf-lua'

    -- unset gr-defaults in nvim v0.11.0
    vim.keymap.set('n', 'gr', 'gr', { nowait = true })

    vim.keymap.set('n', 'gr', fzf.lsp_references, { desc = '[g]oto [r]eferences' })
    vim.keymap.set('n', 'gI', fzf.lsp_implementations, { desc = '[g]oto [I]mplementation' })
    vim.keymap.set('n', 'gd', vim.lsp.buf.definition, { desc = '[g]oto [d]efinition' })
    vim.keymap.set('n', 'gD', vim.lsp.buf.type_definition, { desc = '[g]oto type [D]efinition' })

    vim.keymap.set('n', '<leader>s', fzf.lsp_document_symbols, { desc = '[s]ymbols' })
    vim.keymap.set('n', '<leader>S', fzf.lsp_live_workspace_symbols, { desc = 'workspace [S]ymbols' })
    vim.keymap.set('n', '<leader>x', fzf.lsp_finder, { desc = '[x]ray' })
    vim.keymap.set('n', '<leader>r', vim.lsp.buf.rename, { desc = '[r]ename' })
    vim.keymap.set({ 'n', 'v' }, '<leader>c', vim.lsp.buf.code_action, { desc = '[c]ode action' })

    vim.keymap.set('i', '<C-s>', vim.lsp.buf.signature_help, { desc = '[s]ignature_help' })

    vim.keymap.set('n', '<leader>oh', function()
      vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled())
    end, { desc = 'inlay [h]int' })

    vim.keymap.set('n', '<leader>l', function()
      local lsp_names = vim.tbl_keys(servers)
      table.sort(lsp_names)

      vim.ui.select(lsp_names, {
        prompt = 'LSP> ',
      }, function(lsp_choice)
        if not lsp_choice then
          return
        end

        -- have to nest it because on_choice funcs are async??
        vim.ui.select({ 'Start', 'Stop', 'Restart' }, {
          prompt = 'Action> ',
        }, function(action_choice)
          if not action_choice then
            return
          end

          vim.cmd('Lsp' .. action_choice .. ' ' .. lsp_choice)
        end)
      end)
    end, { desc = '[l]sp start/stop/restart' })
  end,
}
