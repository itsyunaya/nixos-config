local ls = require("luasnip")
local s = ls.snippet
local t = ls.text_node
local i = ls.insert_node

local function in_mathzone()
	return vim.api.nvim_eval("vimtex#syntax#in_mathzone()") == 1
end

return {},
{
	s({
		trig = "\\fc",
		dscr = "Expands to \\frac{}{} in math mode",
		condition = in_mathzone,
		hidden = true,
		priority = 1000,
		snippetType = "autosnippet",
	}, {
		t("\\frac{"),
		i(1),
		t("}{"),
		i(2),
		t("} "),
	}),
}