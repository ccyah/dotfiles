return {
  'ibhagwan/fzf-lua',
  dependencies = { 'nvim-tree/nvim-web-devicons' },
  config = function()
    local fzf = require 'fzf-lua'

    -- configure fzf-lua
    fzf.setup {
      winopts = {
        preview = {
          layout = 'vertical', -- horizontal|vertical|flex
          vertical = 'up:55%',
          delay = 0,
        },
      },
      -- exclude .jj
      fzf_opts = {
        ['--walker-skip'] = '.git,node_modules,.jj',
      },
      files = {
        -- exclude .jj; respsect .gitignore even if this is not a git repo (e.g. a jj repo)
        cmd = 'fd --no-require-git --color=never --hidden --type f --type l --exclude .git --exclude .jj',
      },
      grep = {
        -- exclude .jj; respsect .gitignore even if this is not a git repo (e.g. a jj repo)
        cmd = 'rg --no-require-git --column --line-number --no-heading --color=always --smart-case --max-columns=4096 -e',
      },
    }

    -- register fzf-lua as the UI selector
    -- temporarily disbable it because fzf-lua does not work well with CodeCompanion slash commands
    -- see journals/daily/2025-02-19.md
    -- fzf.register_ui_select()

    -- general fzf-lua commands
    local keymaps = {
      { '<leader>f', fzf.files, '[f]iles' },
      {
        '<leader>F',
        function()
          fzf.files { cwd = vim.fn.expand '%:p:h' }
        end,
        '[F]ile peers',
      },
      { '<leader>b', fzf.buffers, 'buffers' },
      { '<leader>d', fzf.diagnostics_document, '[d]iagnostics' },
      { '<leader>D', fzf.diagnostics_workspace, 'workspace [D]iagnostics' },
      { '<leader>/', fzf.live_grep_native, 'fuzzy search workspace' },
      { '<leader>?', fzf.lgrep_curbuf, 'fuzzy search current buffer' },
      { '<leader>j', fzf.jumps, '[j]ump list' },
    }

    -- lessly used commands
    local project_keymaps = {
      {
        '<leader>po',
        function()
          fzf.oldfiles { cwd_only = true }
        end,
        '[o]ld files',
      },
      { '<leader>pg', fzf.git_files, '[g]it [f]iles' },
      { '<leader>pw', fzf.grep_cword, '[w]ord' },
      { '<leader>ph', fzf.helptags, '[h]elp' },
      { '<leader>pr', fzf.resume, '[r]esume' },
      { '<leader>pm', fzf.builtin, '[m]ore...' },
    }

    -- special directories
    local special_dir_keymaps = {
      {
        '<leader>pc',
        function()
          fzf.files { cwd = '~/.config/' }
        end,
        '[c]onfigs',
      },
      {
        '<leader>pj',
        function()
          fzf.files { cwd = '~/projects/journals/' }
        end,
        '[j]ournals',
      },
    }

    -- apply keymaps
    local apply_keymaps = function(mappings)
      for _, mapping in ipairs(mappings) do
        local mode = mapping.mode or 'n'
        vim.keymap.set(mode, mapping[1], mapping[2], { desc = mapping[3] })
      end
    end

    apply_keymaps(keymaps)
    apply_keymaps(project_keymaps)
    apply_keymaps(special_dir_keymaps)
  end,
}
