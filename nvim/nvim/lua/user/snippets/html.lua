local ls = require"luasnip"
local s = ls.snippet
local t = ls.text_node
local i = ls.insert_node
local f = ls.function_node
local c = ls.choice_node

ls.config.setup({ enable_autosnippets = true })

-- LISTS
-- enumerate-style lists{~
ls.add_snippets(nil, {
    html = {
        s({
            trig = "enuml",
            namr = "enumerate list",
            dscr = "html enumerate-style list",
            snippetType = "autosnippet",
        }, {
            t({"<ol>"}),
            t({"", ""}),
            t({"    <li>"}),
            i(1, ""),
            t({"</li>", ""}),
            t({"</ol>"}),
        }),
    },
})-- ~}

-- itemize-style lists{~
ls.add_snippets(nil, {
    html = {
        s({
            trig = "iteml",
            namr = "itemize list",
            dscr = "html itemize-style list",
            snippetType = "autosnippet",
        }, {
            t({"<ul>"}),
            t({"", ""}),
            t({"    <li>"}),
            i(1, ""),
            t({"</li>", ""}),
            t({"</ul>"}),
        }),
    },
})-- ~}

-- paragraph tag
ls.add_snippets(nil, {
    html = {
        s({
            trig = "ppp",
            namr = "itemize list",
            dscr = "html itemize-style list",
            snippetType = "autosnippet",
        }, {
            t({"<p>"}),
            t({"", "    "}),
            i(1, ""),
            t({"", ""}),
            t({"</p>"}),
        }),
    },
})
