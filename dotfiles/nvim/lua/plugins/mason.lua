return {
  {
    'williamboman/mason.nvim',
    event = 'VeryLazy',
    config = function()
      require('mason').setup()
    end,
  },
  { 'williamboman/mason-lspconfig.nvim', event = 'VeryLazy' },
  {
    'jay-babu/mason-nvim-dap.nvim',
    event = 'VeryLazy',
    config = function()
      require('mason-nvim-dap').setup()
    end,
  },
}
