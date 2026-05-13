local ls = require("luasnip")
local s = ls.snippet
local t = ls.text_node
local i = ls.insert_node
local c = ls.choice_node

local function in_mathzone()
	return vim.api.nvim_eval("vimtex#syntax#in_mathzone()") == 1
end

ls.add_snippets("tex", {
	s({
		trig = "lmm",
		dscr = "Expands to \\lim command in math mode",
		condition = in_mathzone,
		hidden = true,
		priority = 1000,
	}, {
		t("\\lim_{x\\to"),
		c(1, { t("+\\infty"), t("-\\infty"), t(" 0") }),
		t("} "),
		i(2),
	}),
})
