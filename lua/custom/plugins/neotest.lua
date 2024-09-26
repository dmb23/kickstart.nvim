return {
  'nvim-neotest/neotest',
  dependencies = {
    'nvim-neotest/nvim-nio',
    'nvim-neotest/neotest-python',
    'nvim-lua/plenary.nvim',
    'antoinemadec/FixCursorHold.nvim',
    'nvim-treesitter/nvim-treesitter',
  },
  config = function()
    require('neotest').setup {
      adapters = {
        require 'neotest-python' {
          dap = { justMyCode = false },
        },
      },
    }
    vim.keymap.set({ 'n' }, '<leader>tt', require('neotest').summary.toggle, { noremap = true, silent = true, desc = '[T]est summary [t]oggle' })
    vim.keymap.set({ 'n' }, '<leader>tr', require('neotest').run.run, { noremap = true, silent = true, desc = '[T]est: [r]un closest method' })
  end,
}
