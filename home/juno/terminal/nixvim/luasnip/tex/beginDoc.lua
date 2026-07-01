local ls = require("luasnip")
local fmta = require("luasnip.extras.fmt").fmta
local s = ls.snippet
local i = ls.insert_node

return {},
{
	s(
		{ trig = "vbn", snippetType = "autosnippet", dscr = "Begin Document Snippet" },
		fmta(
			[[
			documentclass[a4paper, 12pt]{article}
			\usepackage{defaultSettings}
			\usepackage{autoHeader}
			\def\subj{<>}
			\def\grade{<>}
			\def\title{<>}
			\pagestyle{head}
			\begin{document}
			  \begin{center}
				\huge\textbf{\title}
			  \end{center}
			  <>
			\end{document}
			]],
			{ i(1, "Subject"), i(2, "Grade"), i(3, "Title"), i(4, "") }
		)
	),
}