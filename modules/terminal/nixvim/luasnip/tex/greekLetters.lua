local ls = require("luasnip")
local snippet = ls.snippet
local text = ls.text_node

ls.add_snippets("tex", {
	snippet({ trig = ";a", snippetType = "autosnippet", desc = "alpha", wordTrig = false }, {
		text("\\alpha"),
	}),
	snippet({ trig = ";b", snippetType = "autosnippet", wordTrig = false }, {
		text("\\beta"),
	}),
	snippet({ trig = ";d", snippetType = "autosnippet", wordTrig = false }, {
		text("\\Delta"),
	}),
	snippet({ trig = ";m", snippetType = "autosnippet", wordTrig = false }, {
		text("\\mu"),
	}),
	snippet({ trig = ";p", snippetType = "autosnippet", wordTrig = false }, {
		text("\\pi"),
	}),
	snippet({ trig = ";f", snippetType = "autosnippet", wordTrig = false }, {
		text("\\phi"),
	}),
	snippet({ trig = ";o", snippetType = "autosnippet", wordTrig = false }, {
		text("\\omega"),
	}),
})
