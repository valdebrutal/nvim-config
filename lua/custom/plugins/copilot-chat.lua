return {
  {
    'CopilotC-Nvim/CopilotChat.nvim',
    dependencies = {
      {
        'zbirenbaum/copilot.lua',
        lazy = false,
        cmd = 'Copilot',
        event = 'InsertEnter',
        config = function()
          vim.keymap.set('i', '<C-j>', require('copilot.suggestion').accept, { expr = true, replace_keycodes = false })
          require('copilot').setup {
            suggestion = {
              enabled = true,
              auto_trigger = true,
            },
            panel = {
              enabled = true,
            },
          }
        end,
      },
      { 'nvim-lua/plenary.nvim', branch = 'master' }, -- for curl, log and async functions
    },
    build = 'make tiktoken', -- Only on MacOS or Linux
    opts = {
      auto_insert_mode = true,
      -- Keep context across chat sessions
      sticky = {
        '#buffer:active',
        '#glob:**/*',
        '#quickfix',
        '#gitdiff',
        '#gitstatus',
        '$claude-3.5-sonnet',
      },
      -- Custom prompts
      prompts = {
        Explain = {
          prompt = 'Explain how the selected code works in detail',
          selection = true,
        },
        Rename = {
          prompt = 'Rename the variable correctly in given selection based on context',
          selection = true, -- Fixed the deprecated method
        },
        Refactor = {
          prompt = 'Refactor the selected code to improve readability and maintainability',
          selection = true,
        },
        FixIssue = {
          prompt = 'Fix the following issue in my code:',
          selection = true,
        },
        Optimize = {
          prompt = 'Optimize the selected code for better performance',
          selection = true,
        },
        GenerateTests = {
          prompt = 'Generate comprehensive unit tests for the selected code',
          selection = true,
        },
        Document = {
          prompt = 'Add detailed documentation to the selected code',
          selection = true,
        },
      },
    },
    keys = {
      { '<leader>cc', '<cmd>CopilotChatToggle<CR>', mode = 'n', desc = 'Copilot Chat Toggle' },
      { '<leader>ce', '<cmd>CopilotChatClose<CR>', mode = 'n', desc = 'Copilot Chat Close' },
      { '<leader>cr', '<cmd>CopilotChatReset<CR>', mode = 'n', desc = 'Copilot Chat Reset' },
      { '<leader>cm', '<cmd>CopilotChatModels<CR>', mode = 'n', desc = 'Copilot Chat Models' },
    },
    -- Lazy load on specific commands
    cmd = {
      'CopilotChat',
      'CopilotChatToggle',
      'CopilotChatOpen',
    },
  },
}
