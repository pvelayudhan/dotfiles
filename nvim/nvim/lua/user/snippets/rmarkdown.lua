local ls = require"luasnip"
local s = ls.snippet
local t = ls.text_node
local i = ls.insert_node

-- fenced code block{{{
ls.add_snippets(nil, {
    rmd = {
        s({
            trig = "``",
            namr = "fenced code block",
            snippetType = "autosnippet",
        }, {
            t({"```{r}"}),
            t({"", ""}),
            i(1,""),
            t({"", ""}),
            t({"```"}),
        }),
    },
})
-- }}}

-- inverted fenced code block{{{
ls.add_snippets(nil, {
    rmd = {
        s({
            trig = "`..",
            namr = "inverted fenced code block",
            snippetType = "autosnippet",
        }, {
            t({"```"}),
            t({"", ""}),
            i(1,""),
            t({"", ""}),
            t({"```{r}"}),
        }),
    },
})
-- }}}
