return {
  {
    'mfussenegger/nvim-dap',
    event = 'BufEnter',
    config = function()
      local dap = require('dap')

      local exts = { 'javascript', 'javascriptreact', 'typescript', 'typescriptreact' }

      dap.adapters['pwa-node'] = {
        type = 'server',
        host = 'localhost',
        port = '${port}', --let both ports be the same for now...
        executable = {
          command = 'node',
          -- -- 💀 Make sure to update this path to point to your installation
          args = {
            vim.fn.stdpath('data') .. '/mason/packages/js-debug-adapter/js-debug/src/dapDebugServer.js',
            '${port}',
          },
          -- command = "js-debug-adapter",
          -- args = { "${port}" },
        },
      }

      dap.adapters['pwa-chrome'] = {
        type = 'executable',
        command = 'node',
        port = '${port}',
        args = { vim.fn.stdpath('data') .. '/mason/packages/chrome-debug-adapter/out/src/chromeDebug.js', '${port}' },
      }

      for i, ext in ipairs(exts) do
        dap.configurations[ext] = {
          {
            type = 'pwa-node',
            request = 'attach',
            name = 'Auto Attach',
            cwd = vim.fn.getcwd(),
          },
          {
            type = 'pwa-chrome',
            request = 'launch',
            name = 'Launch Chrome with "localhost"',
            url = 'http://localhost:3000',
            webRoot = '${workspaceFolder}',
            runtimeArgs = { '--disable-gpu' },
          },
          {
            type = 'pwa-node',
            request = 'attach',
            name = 'Attach Program (pwa-node)',
            cwd = vim.fn.getcwd(),
            processId = require('dap.utils').pick_process,
            skipFiles = { '<node_internals>/**' },
          },
        }
      end

      vim.cmd [[hi DapBreakpointLine ctermbg=0 guibg=#222436]]
      vim.cmd [[hi DapLogPointLine ctermbg=0 guibg=#222436]]
      vim.cmd [[hi DapStoppedLine ctermbg=0 guibg=#222436]]

      vim.cmd [[hi DapBreakpointNum ctermbg=0 guifg=#993939 guibg=#222436]]
      vim.cmd [[hi DapLogPointNum ctermbg=0 guifg=#61afef guibg=#222436]]
      vim.cmd [[hi DapStoppedNum ctermbg=0 guifg=#98c379 guibg=#222436]]

      vim.fn.sign_define(
        'DapBreakpoint',
        { text = '', texthl = 'DapBreakpointNum', linehl = 'DapBreakpointLine', numhl = 'DapBreakpointNum' }
      )
      vim.fn.sign_define(
        'DapBreakpointCondition',
        { text = 'ﳁ', texthl = 'DapBreakpointNum', linehl = 'DapBreakpointLine', numhl = 'DapBreakpointNum' }
      )
      vim.fn.sign_define(
        'DapBreakpointRejected',
        { text = '', texthl = 'DapBreakpointNum', linehl = 'DapBreakpointLine', numhl = 'DapBreakpointNum' }
      )
      vim.fn.sign_define(
        'DapLogPoint',
        { text = '', texthl = 'DapLogPointNum', linehl = 'DapLogPointLine', numhl = 'DapLogPointNum' }
      )
      vim.fn.sign_define(
        'DapStopped',
        { text = '', texthl = 'DapStoppedNum', linehl = 'DapStoppedLine', numhl = 'DapStoppedNum' }
      )
    end,
  },
}
