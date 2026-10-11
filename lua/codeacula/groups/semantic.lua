local M = {}

local LINKS = {
  ["@lsp.type.boolean"] = "@boolean",
  ["@lsp.type.builtinType"] = "@type.builtin",
  ["@lsp.type.class"] = "@type",
  ["@lsp.type.decorator"] = "@attribute",
  ["@lsp.type.deriveHelper"] = "@attribute",
  ["@lsp.type.enum"] = "@type",
  ["@lsp.type.enumMember"] = "@constant",
  ["@lsp.type.escapeSequence"] = "@string.escape",
  ["@lsp.type.event"] = "@type",
  ["@lsp.type.formatSpecifier"] = "@string.escape",
  ["@lsp.type.function"] = "@function",
  ["@lsp.type.interface"] = "@type",
  ["@lsp.type.keyword"] = "@keyword",
  ["@lsp.type.lifetime"] = "@label",
  ["@lsp.type.macro"] = "@function.macro",
  ["@lsp.type.method"] = "@function.method",
  ["@lsp.type.modifier"] = "@keyword",
  ["@lsp.type.namespace"] = "@module",
  ["@lsp.type.number"] = "@number",
  ["@lsp.type.operator"] = "@operator",
  ["@lsp.type.parameter"] = "@variable.parameter",
  ["@lsp.type.property"] = "@property",
  ["@lsp.type.regexp"] = "@string.regexp",
  ["@lsp.type.selfKeyword"] = "@variable.builtin",
  ["@lsp.type.selfTypeKeyword"] = "@variable.builtin",
  ["@lsp.type.string"] = "@string",
  ["@lsp.type.struct"] = "@type",
  ["@lsp.type.type"] = "@type",
  ["@lsp.type.typeAlias"] = "@type.definition",
  ["@lsp.type.typeParameter"] = "@type.definition",
  ["@lsp.typemod.function.defaultLibrary"] = "@function.builtin",
  ["@lsp.typemod.method.defaultLibrary"] = "@function.builtin",
  ["@lsp.typemod.variable.defaultLibrary"] = "@variable.builtin",
  ["@lsp.typemod.keyword.async"] = "@keyword",
}

function M.get(c)
  local hl = {
    -- A2: let treesitter's finer captures win
    ["@lsp.type.variable"] = {},
    ["@lsp.type.comment"] = {},
    ["@lsp.mod.deprecated"] = { strikethrough = true },
    ["@lsp.type.unresolvedReference"] = { sp = c.error, undercurl = true },
  }
  for group, target in pairs(LINKS) do
    hl[group] = { link = target }
  end
  return hl
end

return M
