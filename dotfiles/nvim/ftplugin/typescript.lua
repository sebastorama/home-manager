vim.cmd [[set foldmethod=expr]]
-- setup localleader + f to run EslintFixAll
vim.api.nvim_set_keymap('n', '<localleader>f', ':EslintFixAll<CR>', { noremap = true, silent = true })
