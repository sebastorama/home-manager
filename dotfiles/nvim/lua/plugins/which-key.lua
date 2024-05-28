return {
  {
    'folke/which-key.nvim',
    event = 'VeryLazy',
    config = function()
      local wk = require('which-key')
      vim.opt.timeoutlen = 200
      wk.setup {
        plugins = {
          marks = false, -- shows a list of your marks on ' and `
          registers = false, -- shows your registers on ' in NORMAL or <C-r> in INSERT mode
          spelling = {
            enabled = false, -- enabling this will show WhichKey when pressing z= to select spelling suggestions
            suggestions = 20, -- how many suggestions should be shown in the list?
          },
          -- the presets plugin, adds help for a bunch of default keybindings in Neovim
          -- No actual key bindings are created
          presets = {
            operators = false, -- adds help for operators like d, y, ... and registers them for motion / text object completion
            motions = false, -- adds help for motions
            text_objects = true, -- help for text objects triggered after entering an operator
            windows = true, -- default bindings on <c-w>
            nav = true, -- misc bindings to work with windows
            z = true, -- bindings for folds, spelling and others prefixed with z
            g = true, -- bindings for prefixed with g
          },
        },
        -- add operators that will trigger motion and text object completion
        -- to enable all native operators, set the preset / operators plugin above
        operators = { gc = 'Comments' },
        key_labels = {
          -- override the label used to display some keys. It doesn't effect WK in any other way.
          -- For example:
          -- ["<space>"] = "SPC",
          -- ["<CR>"] = "RET",
          -- ["<tab>"] = "TAB",
        },
        icons = {
          breadcrumb = '»', -- symbol used in the command line area that shows your active key combo
          separator = '➜', -- symbol used between a key and it"s label
          group = '+', -- symbol prepended to a group
        },
        popup_mappings = {
          scroll_down = '<c-d>', -- binding to scroll down inside the popup
          scroll_up = '<c-u>', -- binding to scroll up inside the popup
        },
        window = {
          border = 'none', -- none, single, double, shadow
          position = 'bottom', -- bottom, top
          margin = { 1, 0, 1, 0 }, -- extra window margin [top, right, bottom, left]
          padding = { 2, 2, 2, 2 }, -- extra window padding [top, right, bottom, left]
          winblend = 0,
        },
        layout = {
          height = { min = 4, max = 25 }, -- min and max height of the columns
          width = { min = 20, max = 50 }, -- min and max width of the columns
          spacing = 3, -- spacing between columns
          align = 'left', -- align columns left, center or right
        },
        ignore_missing = false, -- enable this to hide mappings for which you didn't specify a label
        hidden = { '<silent>', '<cmd>', '<Cmd>', '<CR>', 'call', 'lua', '^:', '^ ' }, -- hide mapping boilerplate
        show_help = true, -- show help message on the command line when the popup is visible
        triggers = 'auto', -- automatically setup triggers
        -- triggers = {"<leader>"} -- or specify a list manually
        triggers_blacklist = {
          -- list of mode / prefixes that should never be hooked by WhichKey
          -- this is mostly relevant for key maps that start with a native binding
          -- most people should not need to change this
          i = { 'j', 'k' },
          v = { 'j', 'k' },
        },
      }

      wk.register({
        -- QUICKFIX
        c = {
          name = 'Quickfix',
          c = { '<cmd>ccl<CR>', 'Close Quickfix' },
          o = { '<cmd>copen<CR>', 'Open Quickfix' },
        },
        d = {
          name = 'Debug',
          b = { "<cmd>lua require'dap'.toggle_breakpoint()<CR>", 'Toggle Breakpoint' },
          B = {
            "<cmd>lua require'dap'.set_breakpoint(vim.fn.input('Breakpoint condition: '))<CR>",
            'Set Conditional Breakpoint',
          },
          c = { "<cmd>lua require'dap'.continue()<CR>", 'Continue/Run' },
          d = { "<cmd>lua require'dapui'.eval()<CR>", 'DapUI Eval' },
          u = { "<cmd>lua require'dapui'.toggle()<CR>", 'DapUI Toggle' },
          j = { "<cmd>lua require'dap'.step_into()<CR>", 'Step Into' },
          k = { "<cmd>lua require'dap'.step_out()<CR>", 'Step Out' },
          l = { "<cmd>lua require'dap'.step_over()<CR>", 'Step Over' },
        },
        -- FIND
        f = {
          name = 'Find',
          f = { '<cmd>Telescope find_files hidden=false<CR>', 'Find File' },
          b = { "<cmd>lua require('telescope.builtin').buffers({ layout_config={ width=0.5 }})<CR>", 'Find Buffers' },
          g = { '<cmd>Telescope git_files hidden=true<CR>', 'Find GIT files' },
          l = { '<cmd>Telescope live_grep use_regex=true<CR>', 'LiveGrep' },
        },
        F = {
          name = 'Global Find',
          F = { "<cmd>lua require('telescope.builtin').find_files({ cwd='~/dev'})<CR>", 'Find File' },
        },
        -- GIT
        g = {
          name = 'GIT',
          g = { '<cmd>Neogit<CR>', 'Open Neogit' },
          s = { '<cmd>DiffviewOpen<CR>', 'File History' },
          h = { '<cmd>DiffviewFileHistory<CR>', 'File History' },
          x = { '<cmd>DiffviewClose<CR>', 'Close Diffview' },
        },
        -- LSP
        l = {
          name = 'LSP',
          a = {
            name = 'Actions',
            r = { '<cmd>lua vim.lsp.buf.rename()<CR>', silent = false, noremap = false, 'Rename with LSP' },
            o = {
              '<cmd>lua vim.lsp.buf.execute_command({command = "_typescript.organizeImports", arguments = {vim.fn.expand("%:p")}})<CR>',
              silent = false,
              noremap = false,
              'Typescript organize imports',
            },
          },
          f = { '<cmd>lua vim.lsp.buf.format({ async = true })<CR>', 'Format File' },
          d = { '<cmd>Telescope lsp_definitions<CR>', 'Find Definitions' },
          l = { '<cmd>Telescope diagnostics<CR>', 'Show Diagnostics' },
          r = { '<cmd>Telescope lsp_references<CR>', 'Find References' },
          s = { '<cmd>Telescope lsp_document_symbols<CR>', 'Find Document Symbols' },
          S = { '<cmd>Telescope lsp_dynamic_workspace_symbols<CR>', 'Find Workspace Symbols' },
          o = { '<cmd>AerialToggle<CR>', 'Toggle Outline' },
        },
        o = {
          name = 'Obsidian',
          n = { '<cmd>ObsidianNew<CR>', 'New Note' },
          r = { '<cmd>ObsidianRename<CR>', 'Rename Note' },
        },
        t = {
          name = 'Typescript',
          o = { '<cmd>TypescriptOrganizeImports<CR>', 'Organize Imports' },
        },
      }, { prefix = '<leader>' })

      wk.register({
        a = {
          '<cmd>AerialToggle<CR>',
          'Aerial Toggle',
        },
        d = {
          name = 'Diffview',
          d = { '<cmd>DiffviewOpen<CR>', 'Diffview Open' },
          c = { '<cmd>DiffviewClose<CR>', 'Diffview Open' },
          t = { '<cmd>DiffviewToggleFiles<CR>', 'Diffview Toggle Files' },
        },
        b = {
          '<cmd>buffers<CR>',
          'Buffers (neovim native)',
        },
        n = {
          '<cmd>Navbuddy<CR>',
          'Navbuddy Toggle',
        },
      }, { prefix = ',' })
    end,
  },
}
