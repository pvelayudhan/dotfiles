local ls = require"luasnip"
local s = ls.snippet
local t = ls.text_node
local i = ls.insert_node

-- python fenced code block
ls.add_snippets(nil, {
    quarto = {
        s({
            trig = "`pp",
            namr = "fenced python code block",
            snippetType = "autosnippet",
        }, {
            t({"```{python}"}),
            t({"", ""}),
            i(1,""),
            t({"", ""}),
            t({"```"}),
        }),
    },
})
