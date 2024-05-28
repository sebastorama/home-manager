vim.api.nvim_create_user_command('Dfh', function(values)
  P(values.args)
  if values.args == nil then
    vim.cmd 'DiffviewFileHistory'
  else
    vim.cmd('DiffviewFileHistory ' .. values.args)
  end
end, { nargs = '*' })

vim.api.nvim_create_user_command('Dc', 'DiffviewClose', { nargs = 0 })

vim.api.nvim_create_user_command('Do', function(values)
  if values.args == nil then
    vim.cmd 'DiffviewOpen'
  else
    vim.cmd('DiffviewOpen ' .. values.args)
  end
end, { nargs = '*' })

vim.api.nvim_create_user_command('Ao', 'AerialOpen', { nargs = 0 })
vim.api.nvim_create_user_command('Ac', 'AerialClose', { nargs = 0 })

vim.api.nvim_create_user_command('Toi', 'TypescriptOrganizeImports', { nargs = 0 })

vim.api.nvim_create_user_command('Gr', function(args)
  vim.cmd('GrepperRg ' .. args.args)
end, { nargs = '*' })
