return {
  {
    'mfussenegger/nvim-dap',
    dependencies = {
      'mfussenegger/nvim-dap-python',
      'rcarriga/nvim-dap-ui',
      'theHamsta/nvim-dap-virtual-text',
      'nvim-neotest/nvim-nio',
      'williamboman/mason.nvim',
    },
    config = function()
      local dap = require 'dap'
      local ui = require 'dapui'
      local dpy = require 'dap-python'

      require('dapui').setup()
      require('dap-python').setup 'python'
      require('nvim-dap-virtual-text').setup()

      dpy.test_runner = 'pytest'
      dap.defaults.fallback.exception_breakpoints = { 'raised' }
      vim.fn.sign_define('DapBreakpoint', { text = '🛑', texthl = '', linehl = '', numhl = '' })
      vim.fn.sign_define('DapStopped', { text = '➡️', texthl = '', linehl = '', numhl = '' })

      vim.keymap.set('n', '<leader>db', dap.toggle_breakpoint, { desc = '[D]ap: toggle [B]reakpoint' })
      vim.keymap.set('n', '<leader>dh', dap.run_to_cursor, { desc = '[D]ap: run to [C]ursor' })

      -- Eval var under cursor
      vim.keymap.set('n', '<leader>?', function()
        require('dapui').eval(nil, { enter = true })
      end)

      vim.keymap.set('n', '<leader>d1', dap.continue, { desc = '[D]ap: Continue' })
      vim.keymap.set('n', '<leader>d2', dap.step_into, { desc = '[D]ap: Step Into' })
      vim.keymap.set('n', '<leader>d3', dap.step_over, { desc = '[D]ap: Step Over' })
      vim.keymap.set('n', '<leader>d4', dap.step_out, { desc = '[D]ap: Step Out' })
      vim.keymap.set('n', '<leader>d5', dap.step_back, { desc = '[D]ap: Step Back' })
      vim.keymap.set('n', '<leader>d9', dap.terminate, { desc = '[D]ap: Stop' })
      vim.keymap.set('n', '<leader>d0', dap.restart, { desc = '[D]ap: Restart' })

      vim.keymap.set('n', '<leader>dm', dpy.test_method, { desc = '[D]ap: Python Test Method' })
      vim.keymap.set('n', '<leader>dc', dpy.test_class, { desc = '[D]ap: Python Test Class' })
      -- vim.keymap.set('n', '<leader>ds', dpy.debug_selection, { desc = '[D]ap: Python Debug Selection' })

      vim.keymap.set('n', '<leader>dx', ui.close, { desc = '[D]ap: UI close UI' })

      dap.listeners.before.attach.dapui_config = function()
        ui.open()
      end
      dap.listeners.before.launch.dapui_config = function()
        ui.open()
      end
      -- I didn't like the UI closing before I could see the error message
      -- dap.listeners.before.event_terminated.dapui_config = function()
      --   ui.close()
      -- end
      -- dap.listeners.before.event_exited.dapui_config = function()
      --   ui.close()
      -- end
    end,
  },
}
