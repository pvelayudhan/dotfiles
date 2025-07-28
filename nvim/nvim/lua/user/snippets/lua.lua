local ls = require"luasnip"
local s = ls.snippet
local t = ls.text_node
local i = ls.insert_node

-- Template for adding a new snippets page
ls.add_snippets(nil, {
    lua = {
        s({
            trig = "init",
            namr = "newsnip",
            dscr = "Date in the form of YYYY-MM-DD",
        }, {
            t("local ls = require\"luasnip\""),
            t({"", "local s = ls.snippet"}),
            t({"", "local sn = ls.snippet_node"}),
            t({"", "local isn = ls.indent_snippet_node"}),
            t({"", "local t = ls.text_node"}),
            t({"", "local i = ls.insert_node"}),
            t({"", "local f = ls.function_node"}),
            t({"", "local c = ls.choice_node"}),
            t({"", "local d = ls.dynamic_node"}),
            t({"", "local r = ls.restore_node"}),
            t({"", "local events = require(\"luasnip.util.events\")"}),
            t({"", "local ai = require(\"luasnip.nodes.absolute_indexer\")"}),
            t({"", "local fmt = require(\"luasnip.extras.fmt\").fmt"}),
            t({"", "local m = require(\"luasnip.extras\").m"}),
            t({"", "local lambda = require(\"luasnip.extras\").l"}),
            t({"", "local postfix = require(\"luasnip.extras.postfix\").postfix"}),
        }),
    },
})

ls.add_snippets("lua", {
    s("keymap", {
        t("keymap(\"n\", \"<leader>"), i(1, "combination"), t("\", \""), i(2, "mapping"), t("\", opts)")
    })
})


-- New plugins
ls.add_snippets(nil, {
    lua = {
        s({
            trig = "plug",
            wordTrig = false,
            namr = "new mason plugin",
        }, {
            t({"local M = {"}),
            t({"", "    \""}),
            i(1, "github_repo"),
            t("\","),
            t({"", "    commit = \""}),
            i(2, "commit"),
            t("\","),
            t({"", "    event = \"VeryLazy\","}),
            t({"", "}"}),
            t({"", ""}),
            t({"", ""}),
            t({"return M"}),
        }),
    },
})
