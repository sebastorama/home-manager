local lint_ok, lint = pcall(require, 'lint')

if not lint_ok then
  return
end

lint.linters_by_ft = {
  typescript = { 'eslint_d' },
  typescriptreact = { 'eslint_d' },
  javascript = { 'eslint_d' },
  javascriptreact = { 'eslint_d' },
  lua = { 'luacheck' },
  python = { 'flake8' },
  sh = { 'shellcheck' },
  vim = { 'vint' },
  yaml = { 'yamllint' },
  markdown = { 'markdownlint' },
  json = { 'jsonlint' },
  cpp = { 'cppcheck' },
  c = { 'cppcheck' },
  go = { 'golangci_lint' },
  rust = { 'rustc' },
  ruby = { 'rubocop' },
  java = { 'checkstyle' },
  kotlin = { 'ktlint' },
  scala = { 'scalafmt' },
  php = { 'phpcs' },
  html = { 'tidy' },
  css = { 'stylelint' },
  scss = { 'stylelint' },
  less = { 'stylelint' },
  graphql = { 'eslint_d' },
  svelte = { 'eslint_d' },
  vue = { 'eslint_d' },
  haskell = { 'hlint' },
  fish = { 'fish' },
  dockerfile = { 'hadolint' },
  docker = { 'hadolint' },
  nix = { 'nixfmt' },
  zig = { 'ziglint' },
}
