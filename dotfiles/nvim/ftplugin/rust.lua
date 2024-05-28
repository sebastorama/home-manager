-- Create augroup to format on save using rustfmt
vim.cmd [[augroup Format]]
vim.cmd [[autocmd!]]
vim.cmd [[autocmd BufWritePost *.rs :silent! !rustfmt %]]
vim.cmd [[augroup END]]
