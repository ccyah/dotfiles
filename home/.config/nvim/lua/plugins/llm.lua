return {
  {
    'olimorris/codecompanion.nvim',
    event = 'VeryLazy',
    dependencies = {
      'nvim-lua/plenary.nvim',
      'nvim-treesitter/nvim-treesitter',
    },
    config = function()
      local deepseek_adapter = function(model)
        return function()
          return require('codecompanion.adapters').extend('openai_compatible', {
            name = model,
            env = {
              api_key = 'cmd:op read op://Personal/deepseek_api_token/credential --no-newline',
              url = 'https://api.deepseek.com',
              chat_url = '/v1/chat/completions',
            },
            schema = {
              model = { default = model },
            },
          })
        end
      end

      local local_deepseek_adapter = function()
        return function()
          return require('codecompanion.adapters').extend('ollama', {
            name = 'local_deepseek',
            schema = {
              model = {
                default = 'deepseek-r1:7b',
              },
              num_ctx = {
                default = 4028,
              },
            },
          })
        end
      end

      require('codecompanion').setup {
        adapters = {
          local_deepseek = local_deepseek_adapter(),
          deepseek_chat = deepseek_adapter 'deepseek-chat',
          deepseek_reasoner = deepseek_adapter 'deepseek-reasoner',
        },
        strategies = {
          chat = {
            adapter = 'deepseek_chat',
            slash_commands = {
              ['file'] = {
                -- Location to the slash command in CodeCompanion
                callback = 'strategies.chat.slash_commands.file',
                description = 'Select a file using fzf_lua',
                opts = {
                  provider = 'default', -- Other options include 'default', 'mini_pick', 'fzf_lua', snacks
                  contains_code = true,
                },
              },
            },
          },
          inline = {
            adapter = 'deepseek_chat',
          },
        },
      }
    end,
  },

  {
    'huggingface/llm.nvim',
    enabled = false,
    event = 'VeryLazy',
    config = function()
      require('llm').setup {
        backend = 'ollama',
        model = 'deepseek-coder-v2:16b',
        url = 'http://localhost:11434', -- llm-ls uses "/api/generate"
        -- cf https://github.com/ollama/ollama/blob/main/docs/api.md#parameters
        request_body = {
          -- Modelfile options for the model you use
          options = {
            temperature = 0.2,
            top_p = 0.95,
          },
          lsp = {
            cmd_env = { LLM_LOG_LEVEL = 'DEBUG' },
          },
        },
      }
    end,
  },
}
