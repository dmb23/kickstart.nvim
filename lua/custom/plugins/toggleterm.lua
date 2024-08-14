return {
  {
    'akinsho/toggleterm.nvim',
    version = '*',
    opts = {
      -- open_mapping = [[<leader>tt]],
      open_mapping = nil,
    },
    config = function()
      require('toggleterm').setup()

      -- Add a `lazygit` terminal
      local Terminal = require('toggleterm.terminal').Terminal
      local lazygit = Terminal:new {
        cmd = 'lazygit',
        hidden = true,
        direction = 'float',
      }
      -- Toggle the state of the `lazygit` terminal
      local function lazygit_toggle()
        -- Sync the current directories of the editor and the terminal
        lazygit.dir = vim.fn.getcwd()
        lazygit:toggle()
      end

      -- Setup the keybindings
      vim.keymap.set({ 'n', 'i', 't' }, '<C-t>l', lazygit_toggle, { noremap = true, silent = true, desc = '[T]oggleterm: [L]azygit' })
      -- v:count defaults the count to 0 but if a count is passed in uses that instead
      vim.keymap.set({ 'n', 'i', 't' }, '<C-t>t', '<Cmd>execute v:count . "ToggleTerm"<CR>', {
        desc = '[T]oggleterm: Terminal',
        silent = true,
      })
      -- exit terminal mode along the lines of <C-t>
      vim.keymap.set('t', '<C-t>x', '<C-\\><C-n>', { desc = '[T]oggleterm: get finally out of terminal mode' })
    end,
  },
}
