local ls = require"luasnip"
local s = ls.snippet
local t = ls.text_node
local i = ls.insert_node
local f = ls.function_node

ls.config.setup({ enable_autosnippets = true })

-- Figure with a caption
ls.add_snippets(nil, {
    typst = {
        s({
            trig = "figg",
            namr = "typst figure with caption",
            snippetType = "autosnippet",
        }, {
            t({"#figure("},""),
            t({"",""}),
            t({"    image(\"figures/ch2/\"),"},""),
            t({"",""}),
            t({"    caption:["},""),
            t({"",""}),
            t({"    ]"},""),
            t({"",""}),
            t({")"},""),
        }),
    },
})

