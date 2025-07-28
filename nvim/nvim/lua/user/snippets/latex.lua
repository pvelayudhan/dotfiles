local ls = require"luasnip"
local s = ls.snippet
local t = ls.text_node
local i = ls.insert_node
local f = ls.function_node

ls.config.setup({ enable_autosnippets = true })

-- general text ---------------------------------------------------------------

-- superscripts ---------------------------------------------------------------{{{
ls.add_snippets(nil, {
    tex = {
        s({
            trig = "supr",
            wordTrig = false,
            namr = "superscript",
            dscr = "superscript outside of math mode",
            snippetType = "autosnippet",
        }, {
            t({"\\textsuperscript{"}),
            i(1, ""),
            t({"}"}),
        }),
    },
})
-- }}}

-- spacing --------------------------------------------------------------------

-- vspace{{{
ls.add_snippets(nil, {
    tex = {
        s({
            trig = "vs",
            namr = "vspace",
            dscr = "vertical space",
        }, {
            t({"\\vspace{"}),
            i(1, "4"),
            t({"mm}"}),
            i(2,""),
        }),
    },
})
-- }}}

-- lists ----------------------------------------------------------------------

-- enumerate-style lists{{{
ls.add_snippets(nil, {
    tex = {
        s({
            trig = "enuml",
            namr = "enumerate list",
            dscr = "latex enumerate-style list",
            snippetType = "autosnippet",
        }, {
            t({"\\begin{enumerate}"}),
            t({"", ""}),
            t({"    \\item "}),
            i(1, ""),
            t({"", ""}),
            t({"\\end{enumerate}"}),
        }),
    },
})
-- }}}

-- item-style lists{{{
ls.add_snippets(nil, {
    tex = {
        s({
            trig = "iteml",
            namr = "itemize list",
            dscr = "latex itemize-style list",
            snippetType = "autosnippet",
        }, {
            t({"\\begin{itemize}"}),
            t({"", ""}),
            t({"    \\item "}),
            i(1, ""),
            t({"", ""}),
            t({"\\end{itemize}"}),
        }),
    },
})
-- }}}

-- beamer ---------------------------------------------------------------------

-- New beamer slide frames with title{{{
ls.add_snippets(nil, {
    tex = {
        s({ trig = "framel (.*)%.",
            namr = "New titled frame",
            dscr = "New beamer slide frame with title",
            snippetType = "autosnippet",
            regTrig = true}, {
            f(function(_, snip)
                return ("% " .. snip.captures[1])
            end),
            t({"", ""}),
            t({"\\begin{frame}"}),
            t({"", ""}),
            f(function(_, snip)
                return ("    \\frametitle{" .. snip.captures[1] .. "}")
            end),
            t({"", ""}),
            i(1, ""),
            t({"", ""}),
            t({"\\end{frame}"}),
        }),
    },
})
-- }}}

-- New beamer slide frames with no title{{{
ls.add_snippets(nil, {
    tex = {
        s({ trig = "framen (.*)%.",
            namr = "New untitled frame",
            dscr = "New beamer slide frame without title",
            snippetType = "autosnippet",
            regTrig = true}, {
            f(function(_, snip)
                return ("% " .. snip.captures[1])
            end),
            t({"", ""}),
            t({"\\begin{frame}"}),
            i(1, ""),
            t({"", ""}),
            t({"\\end{frame}"}),
        }),
    },
})
-- }}}

-- figures --------------------------------------------------------------------

-- Figure with a caption{{{
ls.add_snippets(nil, {
    tex = {
        s({
            trig = "lfigc",
            namr = "latex figure with caption",
            snippetType = "autosnippet",
        }, {
            t({"\\begin{figure}"},""),
            t({"",""}),
            t({"    \\centering"},""),
            t({"",""}),
            t({"    \\includegraphics[width=\\textwidth]{}"},""),
            t({"",""}),
            t({"    \\caption{}"},""),
            t({"",""}),
            t({"\\end{figure}"},""),
        }),
    },
})
-- }}}

-- Figure without a caption{{{
ls.add_snippets(nil, {
    tex = {
        s({
            trig = "lfignc",
            namr = "latex figure without caption",
            snippetType = "autosnippet",
        }, {
            t({"\\begin{figure}"},""),
            t({"",""}),
            t({"\\centering"},""),
            t({"",""}),
            t({"\\includegraphics[width=\\textwidth]{}"},""),
            t({"",""}),
            t({"\\end{figure}"},""),
        }),
    },
})
-- }}}

-- Side-by-side figure{{{
ls.add_snippets(nil, {
    tex = {
        s({
            trig = "sbys",
            namr = "latex figures side-by-side",
        }, {
            t({"\\begin{center}"}, ""),
            t({"",""}),
            t({"\\begin{figure}"}, ""),
            t({"",""}),
            t({"    \\centering"}, ""),
            t({"",""}),
            t({"    \\begin{minipage}{0.5\\textwidth}"}, ""),
            t({"",""}),
            t({"        \\centering"}, ""),
            t({"",""}),
            t({"        \\includegraphics[width=\\textwidth]{}"}, ""),
            t({"",""}),
            t({"        \\caption{}"}, ""),
            t({"",""}),
            t({"    \\end{minipage}\\hfill"}, ""),
            t({"",""}),
            t({"    \\begin{minipage}{0.5\\textwidth}"}, ""),
            t({"",""}),
            t({"        \\centering"}, ""),
            t({"",""}),
            t({"        \\includegraphics[width=\\textwidth]{}"}, ""),
            t({"",""}),
            t({"        \\caption{}"}, ""),
            t({"",""}),
            t({"    \\end{minipage}"}, ""),
            t({"",""}),
            t({"\\end{figure}"}, ""),
            t({"",""}),
            t({"\\end{center}"}, ""),
        }),
    },
})
-- }}}
