return {
  {
    'CopilotC-Nvim/CopilotChat.nvim',
    dependencies = {
      { 'github/copilot.vim' }, -- or zbirenbaum/copilot.lua
      { 'nvim-lua/plenary.nvim', branch = 'master' }, -- for curl, log and async functions
    },
    build = 'make tiktoken', -- Only on MacOS or Linux
    opts = {
      prompts = {
        Rename = {
          prompt = 'Rename the variable correctly in given selection based on context',
          selection = function(source)
            local select = require 'CopilotChat.select'
            return select.visual(source)
          end,
        },
      },
    },
    keys = {
      { '<leader>cc', '<cmd>CopilotChatToggle<cr>', mode = 'n', desc = 'Copilot Chat Toggle' },
      { '<leader>cr', '<cmd>CopilotChatReset<cr>', mode = 'n', desc = 'Copilot Chat Reset' },
      { '<leader>co', '<cmd>CopilotChatOptimize<cr>', mode = 'v', desc = 'Copilot Chat Optimize' },
      { '<leader>cR', '<cmd>CopilotChatReview<cr>', mode = 'v', desc = 'Copilot Chat Review' },
      { '<leader>ct', '<cmd>CopilotChatTests<cr>', mode = 'v', desc = 'Generate Tests' },
    },
    -- See Commands section for default commands if you want to lazy load on them
  },
}
