return {
  {
    'folke/tokyonight.nvim',
    lazy = false,
    config = function()
      local tokyonight = require('tokyonight')

      tokyonight.setup {
        -- your configuration comes here
        -- or leave it empty to use the default settings
        style = 'moon', -- The theme comes in three styles, `storm`, `moon`, a darker variant `night` and `day`
        transparent = true, -- Enable this to disable setting the background color
        terminal_colors = true, -- Configure the colors used when opening a `:terminal` in Neovim
        styles = {
          -- Style to be applied to different syntax groups
          -- Value is any valid attr-list value for `:help nvim_set_hl`
          comments = { italic = true },
          keywords = { italic = true },
          functions = {},
          variables = {},
          -- Background styles. Can be "dark", "transparent" or "normal"
          sidebars = 'transparent', -- style for sidebars, see below
          floats = 'transparent', -- style for floating windows
        },
        sidebars = { 'qf', 'help' }, -- Set a darker background on sidebar-like windows. For example: `["qf", "vista_kind", "terminal", "packer"]`
        day_brightness = 0.1, -- Adjusts the brightness of the colors of the **Day** style. Number between 0 and 1, from dull to vibrant colors
        hide_inactive_statusline = false, -- Enabling this option, will hide inactive statuslines and replace them with a thin border instead. Should work with the standard **StatusLine** and **LuaLine**.
        dim_inactive = true, -- dims inactive windows
        lualine_bold = false, -- When `true`, section headers in the lualine theme will be bold
        --- You can override specific color groups to use other groups or a hex color
        --- function will be called with a ColorScheme table
        ---@param colors ColorScheme
        on_colors = function(colors)
          colors.border = '#333333'
        end,
        --- You can override specific highlights to use other groups or a hex color
        --- function will be called with a Highlights and ColorScheme table
        ---@param highlights Highlights
        ---@param colors ColorScheme
        on_highlights = function(highlights, colors) end,
      }

      vim.cmd [[set bg=dark]]
      vim.cmd [[colorscheme tokyonight-moon]]
      vim.cmd [[hi TablineFill guibg=#222436]]
      vim.cmd [[hi TablineSel guifg=#e0af68 guibg=#222436]]
      vim.cmd [[hi Tabline guifg=#6874A9 guibg=#222436]]
      vim.cmd [[hi Comment guifg=#6874A9]]
      vim.cmd [[hi LineNr guifg=#6874A9]]
      vim.cmd [[hi Substitute guibg=#ffaaaa guifg=#666666]]
      vim.cmd [[hi Folded guibg=#2C2F45]]

      vim.cmd [[hi DiagnosticVirtualTextWarn guifg=#937244 guibg=#222436]]
      vim.cmd [[hi DiagnosticVirtualTextError guifg=#942C3E guibg=#222436]]
      vim.cmd [[hi DiagnosticVirtualTextInfo guifg=#0db9d7 guibg=#222436]]
      vim.cmd [[hi DiagnosticVirtualTextHint guifg=#2B7568 guibg=#222436]]

      vim.cmd [[hi DiagError guifg=#C52C47 guibg=#222436]]
      vim.cmd [[hi DiagWarn guifg=#FFD200  guibg=#222436]]
      vim.cmd [[hi DiagHint guifg=#03DB00  guibg=#222436]]
      vim.cmd [[hi DiagInfo guifg=#0093FF  guibg=#222436]]

      local ib_ok, indent_blankline = pcall(require, 'indent_blankline')

      if not ib_ok then
        return
      end

      vim.opt.termguicolors = true

      vim.cmd [[hi IndentBlanklineIndent1 guibg=#222436 guifg=#30353F gui=nocombine]]
      vim.cmd [[hi RustInlayHints guifg=#535C7E]]
    end,
  },
}
