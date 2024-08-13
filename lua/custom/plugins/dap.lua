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

      require('dap-python').test_runner = 'pytest'
      vim.fn.sign_define('DapBreakpoint', { text = '🛑', texthl = '', linehl = '', numhl = '' })
      vim.fn.sign_define('DapStopped', { text = '➡️', texthl = '', linehl = '', numhl = '' })

      vim.keymap.set('n', '<leader>b', dap.toggle_breakpoint)
      vim.keymap.set('n', '<leader>gb', dap.run_to_cursor)

      -- Eval var under cursor
      vim.keymap.set('n', '<leader>?', function()
        require('dapui').eval(nil, { enter = true })
      end)

      vim.keymap.set('n', '<leader>1', dap.continue, { desc = 'DAP Continue' })
      vim.keymap.set('n', '<leader>2', dap.step_into, { desc = 'DAP Step Into' })
      vim.keymap.set('n', '<leader>3', dap.step_over, { desc = 'DAP Step Over' })
      vim.keymap.set('n', '<leader>4', dap.step_out, { desc = 'DAP Step Out' })
      vim.keymap.set('n', '<leader>5', dap.step_back, { desc = 'DAP Step Back' })
      vim.keymap.set('n', '<leader>0', dap.restart, { desc = 'DAP Restart' })

      vim.keymap.set('n', '<leader>dm', dpy.test_method, { desc = 'DAP Python Test Method' })
      vim.keymap.set('n', '<leader>dc', dpy.test_class, { desc = 'DAP Python Test Class' })
      vim.keymap.set('n', '<leader>ds', dpy.debug_selection, { desc = 'DAP Python Debug Selection' })

      vim.keymap.set('n', '<leader>dx', ui.close, { desc = 'DAP UI close UI' })

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
