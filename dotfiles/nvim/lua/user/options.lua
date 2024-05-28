-- :help options

vim.g.markdown_recommended_style = 0 -- disable markdown expandtab
vim.opt.backup = false -- creates a backup file
vim.opt.cmdheight = 1 -- stick to the standard thing
vim.opt.completeopt = { 'menuone', 'noselect' } -- mostly just for cmp
vim.opt.conceallevel = 2 -- so that `` is visible in markdown files
vim.opt.cursorline = false -- highlight the current line
vim.opt.expandtab = true -- convert tabs to spaces
vim.opt.fileencoding = 'utf-8' -- the encoding written to a file
vim.o.foldlevel = 99 -- Using ufo provider need a large value, feel free to decrease the value
vim.o.foldlevelstart = 99
vim.o.foldenable = true
vim.opt.guifont = 'Jetbrainsmono Nerd Font:h13' -- the font used in graphical neovim applications
vim.opt.hlsearch = true -- highlight all matches on previous search pattern
vim.opt.ignorecase = false -- ignore case in search patterns
vim.opt.list = true
vim.opt.listchars = { trail = '‿', tab = ' ⇝', eol = '¬' }
vim.opt.mouse = 'a' -- allow the mouse to be used in neovim
vim.opt.number = true -- set numbered lines
vim.opt.relativenumber = true -- set relative numbered lines
vim.opt.numberwidth = 2 -- set number column width to 2 {default 4}
vim.opt.pumheight = 10 -- pop up menu height
vim.opt.scrolloff = 8 -- is one of my fav
vim.opt.shiftwidth = 2 -- the number of spaces inserted for each indentation
vim.opt.showmode = false -- we don't need to see things like -- INSERT -- anymore
vim.opt.showtabline = 1 -- always show tabs
vim.opt.sidescrolloff = 8
vim.opt.signcolumn = 'yes' -- always show the sign column, otherwise it would shift the text each time
vim.opt.smartcase = true -- smart case
vim.opt.smartindent = true -- make indenting smarter again
vim.opt.spell = false
vim.opt.spelllang = { 'en_us', 'pt' }
vim.opt.splitbelow = true -- force all horizontal splits to go below current window
vim.opt.splitright = true -- force all vertical splits to go to the right of current window
vim.opt.swapfile = false -- creates a swapfile
vim.opt.tabstop = 4 -- insert 4 spaces for a tab
vim.opt.termguicolors = true -- set term gui colors (most terminals support this)
vim.opt.timeoutlen = 200 -- time to wait for a mapped sequence to complete (in milliseconds)
vim.opt.undofile = true -- enable persistent undo
vim.opt.updatetime = 300 -- faster completion (4000ms default)
vim.opt.wrap = false -- display lines as one long line
vim.opt.writebackup = false -- if a file is being edited by another program (or was written to file while editing with another program), it is not allowed to be edited
vim.opt.shortmess:append { I = true }
vim.o.winbar = '%f%m%=%n'
vim.o.laststatus = 3

vim.cmd [[
  let g:vimwiki_list = [{ "path": "~/Dropbox/vimwiki/", "syntax": "markdown", "ext": ".md" }]
]]

vim.cmd 'set whichwrap+=<,>,[,],h,l'
vim.cmd [[autocmd BufWritePre * :%s/\s\+$//e]] -- Always strip trailing whitespaces
vim.cmd [[set iskeyword+=-]]
vim.cmd [[set formatoptions-=cro]] -- TODO: this doesn't seem to work

-- folding options
vim.cmd [[set foldmethod=indent]]

vim.cmd [[let g:ftplugin_sql_omni_key = '<C-s>']]
vim.cmd [[packadd cfilter]]
