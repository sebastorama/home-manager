return {
  {
    'L3MON4D3/LuaSnip',
    event = 'InsertEnter',
    config = function()
      local luasnip = require('luasnip')

      ---@diagnostic disable: unused-local
      local s = luasnip.snippet
      local sn = luasnip.snippet_node
      local t = luasnip.text_node
      local i = luasnip.insert_node
      local f = luasnip.function_node
      local c = luasnip.choice_node
      local d = luasnip.dynamic_node
      local r = luasnip.restore_node
      local l = require('luasnip.extras').lambda
      local rep = require('luasnip.extras').rep
      local p = require('luasnip.extras').partial
      local m = require('luasnip.extras').match
      local n = require('luasnip.extras').nonempty
      local dl = require('luasnip.extras').dynamic_lambda
      local fmt = require('luasnip.extras.fmt').fmt
      local fmta = require('luasnip.extras.fmt').fmta
      local types = require('luasnip.util.types')
      local conds = require('luasnip.extras.expand_conditions')
      ---@diagnostic enable: unused-local

      -- load my custom snippets folder
      require('luasnip.loaders.from_vscode').lazy_load({ paths = { './snippets' } })
      require('luasnip.loaders.from_vscode').lazy_load()
      luasnip.filetype_extend('typescript', { 'javascript' })
      luasnip.filetype_extend('typescriptreact', { 'typescript', 'javascript' })

      vim.keymap.set({ 'i', 's' }, '<c-j>', function()
        if luasnip.expand_or_jumpable() then
          luasnip.expand_or_jump()
        end
      end, { silent = true })

      vim.keymap.set({ 'i', 's' }, '<c-k>', function()
        if luasnip.jumpable(-1) then
          luasnip.jump(-1)
        end
      end, { silent = true })

      vim.keymap.set({ 'i' }, '<c-l>', function()
        if luasnip.choice_active() then
          luasnip.change_choice(1)
        end
      end, { silent = true })

      luasnip.setup({
        history = true,
        -- Update more often, :h events for more info.
        update_events = 'TextChanged,TextChangedI',
        -- Snippets aren't automatically removed if their text is deleted.
        -- `delete_check_events` determines on which events (:h events) a check for
        -- deleted snippets is performed.
        -- This can be especially useful when `history` is enabled.
        delete_check_events = 'TextChanged',
        ext_opts = {
          [types.choiceNode] = {
            active = {
              virt_text = { { ' -->  choice node', 'Comment' } },
            },
          },
        },
        -- treesitter-hl has 100, use something higher (default is 200).
        ext_base_prio = 300,
        -- minimal increase in priority.
        ext_prio_increase = 1,
        enable_autosnippets = true,
        -- mapping for cutting selected text so it's usable as SELECT_DEDENT,
        -- SELECT_RAW or TM_SELECTED_TEXT (mapped via xmap).
        store_selection_keys = '<Tab>',
        -- luasnip uses this function to get the currently active filetype. This
        -- is the (rather uninteresting) default, but it's possible to use
        -- eg. treesitter for getting the current filetype by setting ft_func to
        -- require("luasnip.extras.filetype_functions").from_cursor (requires
        -- `nvim-treesitter/nvim-treesitter`). This allows correctly resolving
        -- the current filetype in eg. a markdown-code block or `vim.cmd()`.
        ft_func = function()
          return vim.split(vim.bo.filetype, '.', true)
        end,
      })

      luasnip.add_snippets(nil, {
        javascript = {
          -- function
          s('fun', fmt('function {}({}){} {{\n  {}\n}}\n', { i(1), i(2), i(3), i(4) })),
          -- for
          s('for', fmt('for ({}) {{\n  {}\n}}\n', { i(1), i(2) })),
        },
        lua = {
          -- pcall import
          s(
            'pcall',
            fmt(
              [[
local {}_ok, {} = pcall(require, "{}")

if not {}_ok then
  return
end

  ]],
              { i(1), rep(1), rep(1), rep(1) }
            )
          ),
        },
        typescript = {
          -- interface snippet
          s('iface', fmt('interface {} {{\n  {}\n}}', { i(1), i(2) })),
          s('imr', fmt("import {} from 'react';", { i(1) })),
          s(
            'rfc',
            fmt('const {}: React.FC<{{}}> = () => {{\n  return <></>;\n}};\n\nexport default {};', { i(1), rep(1) })
          ),
          s('afun', fmt('const {} = () => {{\n  {}\n}};\n', { i(1), i(2) })),
          s(
            'useStyles',
            fmt('const useStyles = createStyles((_theme, _params, _getRef) => {{\n  return {{ {} }}\n }});', { i(1) })
          ),
          s('cjson', fmt('console.log(JSON.stringify({}, null, 2))', { i(1) })),
          s('jss', fmt('JSON.stringify({}, null, 2)', { i(1) })),

          --   export type ExpandRecursively<T> = T extends (...args: infer A) => infer R
          -- ? (...args: ExpandRecursively<A>) => ExpandRecursively<R>
          -- : T extends object
          -- ? T extends infer O
          --   ? { [K in keyof O]: ExpandRecursively<O[K]> }
          --   : never
          -- : T;
          s('expt', fmt(require('user.snippets.typescript.expand_type'), {})),
        },
        markdown = {
          s('t', fmt('{}', t('@today'))),
          s('m', fmt('{}', t('@tomorrow'))),
          s('n', fmt('{}', t('@next_week'))),
          s('s', fmt('{}', t('@someday'))),
        },
        zsh = {
          s(
            'psql',
            fmt(
              'psql postgres://{}:{}@{}:{}/{}',
              { i(1, 'postgres'), i(2, 'password'), i(3, 'localhost'), i(4, '5432'), i(5, 'postgres') }
            )
          ),
          s('dops', fmt('docker ps {}', { c(1, { t('-a'), t("-a --format '{{.Names}}'") }) })),
          s('njd', fmt('node --inspect-brk node_modules/.bin/jest --runInBand --watch {}', { i(1) })),
        },
      }, { key = 'global_snippets' })

      luasnip.add_snippets('all', {
        s('ck', fmt('{}', t('✅'))),
        s('uck', fmt('{}', t('❌'))),
      })
    end,
  },
}
