return {
  'neovim/nvim-lspconfig',
  event = 'VeryLazy',
  dependencies = {
    -- lsp completion capabilities before the automatic lsp capability setup
    'saghen/blink.cmp',

    -- need it for kemaps and vim.ui.select
    'ibhagwan/fzf-lua',

    -- Useful status updates for LSP
    { 'j-hui/fidget.nvim', config = true },

    -- Additional lua configuration, makes nvim stuff amazing!
    {
      'folke/lazydev.nvim',
      ft = 'lua', -- only load on lua files
      config = true,
    },
  },
  config = function()
    --[[------------------- Fav LSPs and their extra configs ---------------------------]]
    local autostart_servers = {
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
    }

    local hold_ur_horse_servers = {
      typos_lsp = {
        init_options = {
          -- How typos are rendered in the editor, can be one of an Error, Warning, Info or Hint.
          -- Defaults to error.
          diagnosticSeverity = 'Hint',
        },
      },
    }

    --[[--------- Setup servers using configs above ------------------]]
    for server_name, extra_config in pairs(autostart_servers) do
      vim.lsp.config(server_name, extra_config)
      vim.lsp.enable(server_name)
    end

    for server_name, extra_config in pairs(hold_ur_horse_servers) do
      vim.lsp.config(server_name, extra_config)
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
      local lsp_names = vim.tbl_keys(vim.tbl_extend('error', autostart_servers, hold_ur_horse_servers))
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

          local lsp_start = function()
            vim.lsp.start(vim.lsp.config[lsp_choice])
          end

          local lsp_stop = function()
            local client = vim.lsp.get_clients {
              bufnr = 0, -- current buf
              name = lsp_choice,
            }

            vim.lsp.stop_client(client)
          end

          local lsp_restart = function()
            lsp_stop()
            lsp_start()
          end

          if action_choice == 'Start' then
            lsp_start()
          elseif action_choice == 'Stop' then
            lsp_stop()
          elseif action_choice == 'Restart' then
            lsp_restart()
          end
        end)
      end)
    end, { desc = '[l]sp start/stop/restart' })
  end,
}
