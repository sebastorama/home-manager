return {
  {
    'nvim-telescope/telescope.nvim',
    cmd = 'Telescope',
    dependencies = { 'nvim-lua/plenary.nvim', 'nvim-telescope/telescope-ui-select.nvim' },
    config = function()
      local telescope = require('telescope')

      telescope.setup {
        defaults = {
          -- Default configuration for telescope goes here:
          -- config_key = value,
          layout_config = {
            horizontal = { width = 0.99 },
            -- other layout configuration here
          },
          layout_strategy = 'horizontal',
          mappings = {},
          border = true,
          vimgrep_arguments = {
            'rg',
            '--color=never',
            '--no-heading',
            '--with-filename',
            '--line-number',
            '--column',
            '--case-sensitive',
          },
          find_command = {
            'fd',
            '--type',
            'f',
            '--color',
            'never',
          },
        },
        file_ignore_patterns = { 'node_modules' },
        pickers = {
          buffers = {
            theme = 'dropdown',
            previewer = false,
            border = true,
          },
          lsp_references = {
            disable_coordinates = true,
            show_line = false,
          },
          -- Default configuration for builtin pickers goes here:
          -- picker_name = {
          --   picker_config_key = value,
          --   ...
          -- }
          -- Now the picker_config_key will be applied every time you call this
          -- builtin picker
        },
        extensions = {
          lsp = {
            find_command = { 'rg', '--hidden', '--files', '--exclude', 'node_modules' },
          },
          ['ui-select'] = {
            require('telescope.themes').get_dropdown {
              -- even more opts
            },

            -- pseudo code / specification for writing custom displays, like the one
            -- for "codeactions"
            -- specific_opts = {
            --   [kind] = {
            --     make_indexed = function(items) -> indexed_items, width,
            --     make_displayer = function(widths) -> displayer
            --     make_display = function(displayer) -> function(e)
            --     make_ordinal = function(e) -> string
            --   },
            --   -- for example to disable the custom builtin "codeactions" display
            --      do the following
            --   codeactions = false,
            -- }
          },
        },
      }

      telescope.load_extension('ui-select')
    end,
  },
}
