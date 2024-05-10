if vim.g.snippets ~= 'luasnip' then
  return
end

local ls = require 'luasnip'
types = require 'luasnip.util.types'
ls.snippets = {
  all = {
    ls.parser.parse_snippet('expand', 'This is expanded'),
  },
  lua = {
    -- Lua specific snippets
  },
}
