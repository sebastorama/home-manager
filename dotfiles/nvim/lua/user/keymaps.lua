local opts = { noremap = true, silent = true }

local keymap = vim.api.nvim_set_keymap

vim.g.mapleader = ' '
vim.g.maplocalleader = '\\'

-- Command
keymap('c', '<C-o>', '%:p:h', opts)

keymap('', '<F1>', '<Nop>', opts)
keymap('n', '<F5>', ':cclose <cr>', opts)

-- Better window navigation
keymap('n', '<C-h>', '<C-w>h', opts)
keymap('n', '<C-j>', '<C-w>j', opts)
keymap('n', '<C-k>', '<C-w>k', opts)
keymap('n', '<C-l>', '<C-w>l', opts)

keymap('n', '<leader>S', ':setlocal spell!<CR>', opts)

-- Navigate tabs and buffers
keymap('n', '<S-l>', ':tabn<CR>', opts)
keymap('n', '<S-h>', ':tabp<CR>', opts)

keymap('n', '<S-Left>', ':bn<CR>', opts)
keymap('n', '<S-Right>', ':bp<CR>', opts)

-- Arrow keys for resizing
keymap('n', '<Up>', ':resize +3<CR>', opts)
keymap('n', '<Down>', ':resize -3<CR>', opts)

-- Buffers
keymap('n', '<leader>bb', "<cmd>lua require('telescope.builtin').buffers({ layout_config={ width=0.5 }})<CR>", opts)
keymap('n', '<leader>bd', ':bp | sp | bn | bd<CR>', opts)
keymap('n', '<localleader>d', ':bp | sp | bn | bd<CR>', opts)
keymap('n', '<leader>bD', ':%bd|e#<CR>', opts)
keymap('n', '<localleader>n', ':bn<CR>', opts)
keymap('n', '<localleader>p', ':bp<CR>', opts)
keymap('n', '<localleader>b', ':BDelete ', opts)

-- Folding
keymap('n', '<localleader>1', ':set foldlevel=0<CR>', opts)
keymap('n', '<localleader>2', ':set foldlevel=1<CR>', opts)
keymap('n', '<localleader>3', ':set foldlevel=2<CR>', opts)
keymap('n', '<localleader>4', ':set foldlevel=3<CR>', opts)
keymap('n', '<localleader>5', ':set foldlevel=4<CR>', opts)
keymap('n', '<localleader>6', ':set foldlevel=5<CR>', opts)
keymap('n', '<localleader>7', ':set foldlevel=6<CR>', opts)
keymap('n', '<localleader>8', ':set foldlevel=7<CR>', opts)
keymap('n', '<localleader>9', ':set foldlevel=99<CR>', opts)

-- Resize with arrows
keymap('n', '<C-S-Up>', ':resize +3<CR>', opts)
keymap('n', '<C-S-Down>', ':resize -3<CR>', opts)
keymap('n', '_', ':vertical resize -3<CR>', opts)
keymap('n', '+', ':vertical resize +3<CR>', opts)

-- Misc Actions
keymap('n', '<Left>', ':cp<CR>', opts)
keymap('n', '<Right>', ':cn<CR>', opts)
keymap('n', '<leader>e', ':NvimTreeToggle<CR>', opts)
keymap('n', '<localleader><localleader>', ':nohl<CR>', opts)
keymap('n', '<localleader>=', '<c-w>=', opts)
keymap('n', '<leader><leader>s', ':source ~/.config/nvim/lua/user/luasnip.lua<CR>', opts)
keymap('n', '<leader><leader>r', ':luafile %<CR>', opts)
keymap(
  'n',
  '<leader>/',
  ':lua require("telescope.builtin").current_buffer_fuzzy_find({ sorter = require(\'telescope.sorters\').get_substr_matcher({})})<CR>',
  opts
)
keymap('n', '<leader><leader>/', ":lua require('spectre').open()<CR>", opts)
keymap('n', '<leader><leader>e', ':e <C-r>=expand("%:p:h")<CR>/', opts)
keymap('n', '<localleader>cd', ':Copilot disable<CR>', opts)
keymap('n', '<localleader>ce', ':Copilot enable<CR>', opts)
keymap('n', '<localleader>e', ':Exp<CR>', opts)
keymap('n', '<localleader>t', ':tabe term://zsh<CR>', opts)
keymap('n', ',p', ':let @+ = expand("%")<cr>', opts)
keymap('n', '[b', ':bp<CR>', opts)
keymap('n', ']b', ':bn<CR>', opts)

keymap('n', '<localleader>z', ':ZenMode<CR>', opts)

-- VISUAL

-- Stay in ident mode
keymap('v', '<', '<gv', opts)
keymap('v', '>', '>gv', opts)

-- CLIPBOARD Actions
keymap('v', '<leader>y', '"+y', opts)
keymap('n', '<leader>p', '"+p', opts)

-- INSERT
keymap('i', '<C-f>', '<Right>', opts)
keymap('i', '<C-b>', '<Left>', opts)

-- Option Do stuff like emacs in insert mode
keymap('i', '<M-f>', '<Esc>wwi', opts)
keymap('i', '<M-b>', '<Esc>bi', opts)
keymap('i', '<M-d>', '<Esc>dw', opts)

-- Copilot Mapping
vim.api.nvim_set_keymap('i', '<M-i>', 'copilot#Accept("<CR>")', { silent = true, expr = true })
vim.g.copilot_no_tab_map = true
vim.g.copilot_assume_mapped = true
vim.g.copilot_tab_fallback = ''

-- Mouse
vim.api.nvim_set_keymap(
  'n',
  '<LeftMouse>',
  '<LeftMouse><cmd>lua vim.lsp.buf.hover({border = "single"})<CR>',
  { noremap = true, silent = true }
)
vim.api.nvim_set_keymap(
  'n',
  '<RightMouse>',
  '<LeftMouse><cmd>lua vim.lsp.buf.definition()<CR>',
  { noremap = true, silent = true }
)
