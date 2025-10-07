return {
  {
    'mfussenegger/nvim-dap',
    keys = {
      {
        '<F5>',
        function()
          require('dap').continue()
        end,
        desc = 'DAP Continue',
      },
      {
        '<F10>',
        function()
          require('dap').step_over()
        end,
        desc = 'DAP Step Over',
      },
      {
        '<F11>',
        function()
          require('dap').step_into()
        end,
        desc = 'DAP Step Into',
      },
      {
        '<F12>',
        function()
          require('dap').step_out()
        end,
        desc = 'DAP Step Out',
      },
      {
        '<leader>db',
        function()
          require('dap').toggle_breakpoint()
        end,
        desc = '[D]AP Toggle [B]reakpoint',
      },
      {
        '<leader>dB',
        function()
          require('dap').set_breakpoint(vim.fn.input 'Breakpoint condition: ')
        end,
        desc = '[D]AP Conditional [B]reakpoint',
      },
      {
        '<leader>dr',
        function()
          require('dap').repl.open()
        end,
        desc = '[D]AP [R]EPL',
      },
    },
  },

  -- UI
  {
    'rcarriga/nvim-dap-ui',
    dependencies = { 'mfussenegger/nvim-dap', 'nvim-neotest/nvim-nio' },
    opts = {},
    keys = {
      {
        '<leader>du',
        function()
          require('dapui').toggle()
        end,
        desc = '[D]AP [U]I',
      },
    },
    config = function(_, opts)
      local dap = require 'dap'
      local dapui = require 'dapui'
      dapui.setup(opts)
      dap.listeners.after.event_initialized['dapui_open'] = function()
        dapui.open()
      end
      dap.listeners.before.event_terminated['dapui_close'] = function()
        dapui.close()
      end
      dap.listeners.before.event_exited['dapui_close'] = function()
        dapui.close()
      end
    end,
  },

  -- mason bridge: installs/sets up debugpy + codelldb automatically
  {
    'jay-babu/mason-nvim-dap.nvim',
    dependencies = { 'williamboman/mason.nvim', 'mfussenegger/nvim-dap' },
    opts = {
      automatic_setup = true,
      ensure_installed = { 'debugpy', 'codelldb' },
      handlers = {},
    },
  },
}
