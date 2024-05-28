-- autocommands
--- This function is taken from https://github.com/norcalli/nvim_utils
local function nvim_create_augroups(definitions)
  for group_name, definition in pairs(definitions) do
    vim.api.nvim_command('augroup ' .. group_name)
    vim.api.nvim_command 'autocmd!'
    for _, def in ipairs(definition) do
      local command = table.concat(vim.iter({ 'autocmd', def }):flatten():totable(), ' ')
      vim.api.nvim_command(command)
    end
    vim.api.nvim_command 'augroup END'
  end
end

local autocmds = {
  global = {
    { 'BufRead', 'env.*', 'setlocal filetype=sh' },
    { 'BufNewFile', 'env.*', 'setlocal filetype=sh' },
  },
  terminal_job = {
    { 'TermOpen', '*', [[tnoremap <buffer> <Esc> <c-\><c-n>]] },
    { 'TermOpen', '*', 'startinsert' },
    { 'TermOpen', '*', 'setlocal listchars= nonumber norelativenumber' },
  },
  remember_folds = {
    { 'BufwinLeave', '*.*', 'mkview' },
    { 'BufWinEnter', '*.*', 'silent! loadview' },
  },
}

nvim_create_augroups(autocmds)
-- autocommands END
