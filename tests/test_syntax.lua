local T = require("harness")

local function fg(name)
  local spec = vim.api.nvim_get_hl(0, { name = name, link = false })
  return spec.fg and string.format("#%06x", spec.fg) or nil
end

T.test("role mapping per spec", function()
  require("codeacula").setup({})
  vim.cmd.colorscheme("codeacula")
  local c = require("codeacula").colors()
  local expect = {
    ["@variable"] = c.fg, ["@operator"] = c.fg, ["@punctuation.bracket"] = c.fg_dim,
    ["@property"] = c.fg_bright, ["@keyword"] = c.keyword, ["@number"] = c.keyword,
    ["@boolean"] = c.keyword, ["@label"] = c.label, ["@function"] = c.func,
    ["@function.method.call"] = c.func, ["@constructor"] = c.func, ["@tag.attribute"] = c.attr,
    ["@string.regexp"] = c.attr, ["@string"] = c.string, ["@type"] = c.type, ["@tag"] = c.type,
    ["@attribute"] = c.type, ["@property.json"] = c.type, ["@string.escape"] = c.special,
    ["@function.builtin"] = c.special, ["@variable.builtin"] = c.special, ["@comment"] = c.comment,
    ["@comment.documentation"] = c.doc_comment, ["@markup.heading.1"] = c.h1,
    ["@lsp.type.class"] = c.type, ["@lsp.type.method"] = c.func,
    Keyword = c.keyword, Function = c.func, String = c.string, Type = c.type, Comment = c.comment,
  }
  local wrong = {}
  for group, want in pairs(expect) do
    if fg(group) ~= want then
      table.insert(wrong, ("%s = %s, want %s"):format(group, tostring(fg(group)), want))
    end
  end
  table.sort(wrong)
  T.eq(#wrong, 0, table.concat(wrong, "; "))
end)

T.test("lsp variable/comment defer to treesitter", function()
  local hl = require("codeacula.groups.semantic").get(require("codeacula").colors(), require("codeacula.config").options)
  T.eq(next(hl["@lsp.type.variable"]), nil, "@lsp.type.variable empty")
  T.eq(next(hl["@lsp.type.comment"]), nil, "@lsp.type.comment empty")
end)

T.test("styles option reaches Comment", function()
  require("codeacula").setup({ styles = { comments = { italic = false } } })
  vim.cmd.colorscheme("codeacula")
  T.eq(vim.api.nvim_get_hl(0, { name = "Comment" }).italic, nil, "Comment italic off")
  require("codeacula").setup({})
  vim.cmd.colorscheme("codeacula")
  T.eq(vim.api.nvim_get_hl(0, { name = "Comment" }).italic, true, "Comment italic default")
end)
