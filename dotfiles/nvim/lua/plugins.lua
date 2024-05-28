return {
  -- LSP & TreeSitter
  { 'neovim/nvim-lspconfig', event = 'VeryLazy' }, -- enable LSP
  { 'mfussenegger/nvim-lint', event = 'VeryLazy' },
  { 'tamago324/nlsp-settings.nvim', event = 'VeryLazy' }, -- language server settings defined in json for
  'nvim-lua/plenary.nvim',
  {
    'jose-elias-alvarez/typescript.nvim',
    ft = { 'typescript', 'javascript', 'typescriptreact' },
    config = function()
      require('typescript').setup {
        server = { -- pass options to lspconfig's setup method
          on_attach = require('user.lsp.handlers').on_attach,
          capabilities = require('user.lsp.handlers').capabilities,
        },
      }
    end,
  },

  -- DX
  { 'github/copilot.vim', event = 'InsertEnter' },
  -- {
  --   'supermaven-inc/supermaven-nvim',
  --   event = 'InsertEnter',
  --   config = function()
  --     require('supermaven-nvim').setup({
  --       keymaps = {
  --         accept_suggestion = '<M-i>',
  --         accept_word = '<M-o>',
  --         clear_suggestion = '<C-]>',
  --       },
  --     })
  --   end,
  -- },
  { 'kazhala/close-buffers.nvim', event = 'BufRead' },
  { 'tpope/vim-surround', event = 'InsertEnter' },
  { 'folke/zen-mode.nvim', opts = {}, cmd = 'ZenMode' },
  {
    'numToStr/Comment.nvim',
    config = function()
      require('Comment').setup()
    end,
  },
  { 'junegunn/vim-easy-align', cmd = 'EasyAlign' },
  { 'mhinz/vim-grepper', cmd = 'Grepper' },
  {
    'kyazdani42/nvim-tree.lua',
    event = 'VeryLazy',
    config = function()
      require('nvim-tree').setup {
        view = {
          side = 'right',
        },
      }
    end,
  },
  { 'kyazdani42/nvim-web-devicons', event = 'VeryLazy' },
  {
    'norcalli/nvim-colorizer.lua',
    event = 'VeryLazy',
    config = function()
      require('colorizer').setup()
    end,
  },
}
