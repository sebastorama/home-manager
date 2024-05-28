local filetypes = { 'sql', 'mysql', 'plsql' }

return {
  {
    'tpope/vim-dadbod',
    ft = filetypes,
    config = function()
      vim.g.db_ui_use_nerd_fonts = 1
      vim.cmd [[
        autocmd FileType sql,mysql,plsql lua require('cmp').setup.buffer({ sources = {{ name = 'vim-dadbod-completion' }} })
      ]]
    end,
  },
  { 'kristijanhusak/vim-dadbod-ui', ft = filetypes },
  { 'kristijanhusak/vim-dadbod-completion', ft = filetypes },
  { 'vim-scripts/dbext.vim', ft = filetypes },
}
