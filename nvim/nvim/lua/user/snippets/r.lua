local ls = require"luasnip"
local s = ls.snippet
local t = ls.text_node
local i = ls.insert_node

-- roxygen --------------------------------------------------------------------

-- new comment{{{
ls.add_snippets(nil, {
    r = {
        s({
            trig = "rox",
            namr = "roxygen",
            dscr = "Template for new roxygen comment",
        }, {
            t({"#' "}),
            i(1, "TITLE"),
            t({"", "#'", ""}),
            t({"#' "}),
            i(2, "SHORT DESCRIPTION"),
            t({"", "#'", "#' @param "}),
            i(3, "PARAM1"),
            t({"", "#'", ""}),
            t({"#' @return "}),
            i(4, "RETURN"),
            t({"", "#'", "#' @export"}),
        }),
    },
})
-- }}}

-- new param{{{
ls.add_snippets(nil, {
    r = {
        s({
            trig = "param",
            namr = "param",
            dscr = "Add a new roxygen param line",
        }, {
            t({"#' @param "}),
            i(1, "PARAM"),
        }),
    },
})
-- }}}


-- dplyr ----------------------------------------------------------------------

-- dplyr::contains{{{
ls.add_snippets(nil, {
    r = {
        s({
            trig = "dpcon",
            namr = "dplyr contains function",
            snippetType = "autosnippet",
        }, {
            t({"dplyr::contains(\""}),
            i(1,""),
            t({"\")"}),
        }),
    },
})
-- }}}

-- dplyr::starts_with{{{
ls.add_snippets(nil, {
    r = {
        s({
            trig = "dpsw",
            namr = "dplyr starts_with function",
            snippetType = "autosnippet",
        }, {
            t({"dplyr::starts_with(\""}),
            i(1,""),
            t({"\")"}),
        }),
    },
})
-- }}}

-- dplyr::ends_with{{{
ls.add_snippets(nil, {
    r = {
        s({
            trig = "dpew",
            namr = "dplyr ends_with function",
            snippetType = "autosnippet",
        }, {
            t({"dplyr::ends_with(\""}),
            i(1,""),
            t({"\")"}),
        }),
    },
})
-- }}}

-- dplyr::rename{{{
ls.add_snippets(nil, {
    r = {
        s({
            trig = "dpre",
            namr = "dplyr rename",
            snippetType = "autosnippet",
        }, {
            t({"dplyr::rename(\""}),
            i(1,""),
            t({"\")"}),
        }),
    },
})
-- }}}

-- dplyr::mutate{{{
ls.add_snippets(nil, {
    r = {
        s({
            trig = "dpmu",
            namr = "dplyr mutate function",
            snippetType = "autosnippet",
        }, {
            t({"dplyr::mutate("}),
            i(1,""),
            t({")"}),
        }),
    },
})
-- }}}

-- dplyr::case_when{{{
ls.add_snippets(nil, {
    r = {
        s({
            trig = "dpcw",
            namr = "dplyr case_when function",
            snippetType = "autosnippet",
        }, {
            t({"dplyr::case_when("}),
            i(1,""),
            t({")"}),
        }),
    },
})
-- }}}

-- dplyr::select{{{
ls.add_snippets(nil, {
    r = {
        s({
            trig = "dpse",
            namr = "dplyr select function",
            snippetType = "autosnippet",
        }, {
            t({"dplyr::select("}),
            i(1,""),
            t({")"}),
        }),
    },
})
-- }}}

-- dplyr::filter{{{
ls.add_snippets(nil, {
    r = {
        s({
            trig = "dpfi",
            namr = "dplyr filter function",
            snippetType = "autosnippet",
        }, {
            t({"dplyr::filter("}),
            i(1,""),
            t({")"}),
        }),
    },
})
-- }}}

-- dplyr::group_by{{{
ls.add_snippets(nil, {
    r = {
        s({
            trig = "dpgb",
            namr = "dplyr group_by function",
            snippetType = "autosnippet",
        }, {
            t({"dplyr::group_by("}),
            i(1,""),
            t({")"}),
        }),
    },
})
-- }}}

-- dplyr::summarize{{{
ls.add_snippets(nil, {
    r = {
        s({
            trig = "dpsu",
            namr = "dplyr summarize function",
            snippetType = "autosnippet",
        }, {
            t({"dplyr::summarize(n = dplyr::n())"}),
        }),
    },
})
-- }}}

-- dplyr::inner_join{{{
ls.add_snippets(nil, {
    r = {
        s({
            trig = "dpij",
            namr = "dplyr inner_join function",
            snippetType = "autosnippet",
        }, {
            t({"dplyr::inner_join("}),
            i(1,""),
            t({")"}),
        }),
    },
})
-- }}}

-- dplyr::full_join{{{
ls.add_snippets(nil, {
    r = {
        s({
            trig = "dpfj",
            namr = "dplyr full_join function",
            snippetType = "autosnippet",
        }, {
            t({"dplyr::full_join("}),
            i(1,""),
            t({")"}),
        }),
    },
})
-- }}}

-- testthat -------------------------------------------------------------------

-- new equal test{{{
ls.add_snippets(nil, {
    r = {
        s({
            trig = "tteq",
            namr = "ttequal",
            snippetType = "autosnippet",
        }, {
            t({"test_that("}),
            t({"", ""}),
            t("    \""),
            i(1, "thing"),
            t("\","),
            t({"", ""}),
            t("    {"),
            t({"", ""}),
            t("        expect_equal("),
            t({"", ""}),
            i(2, "            \"function_call\""),
            t({"", ""}),
            t("        )"),
            t({"", ""}),
            t("    }"),
            t({"", ""}),
            t(")"),
        }),
    },
})
-- }}}

-- new identical test{{{
ls.add_snippets(nil, {
    r = {
        s({
            trig = "ttiden",
            namr = "ttidentical",
            snippetType = "autosnippet",
        }, {
            t({"test_that("}),
            t({"", ""}),
            t("    \""),
            i(1, "thing"),
            t("\","),
            t({"", ""}),
            t("    {"),
            t({"", ""}),
            t("        expect_identical("),
            t({"", ""}),
            i(2, "            \"function_call\""),
            t({"", ""}),
            t("        )"),
            t({"", ""}),
            t("    }"),
            t({"", ""}),
            t(")"),
        }),
    },
})
-- }}}

-- new warning test{{{
ls.add_snippets(nil, {
    r = {
        s({
            trig = "ttw",
            namr = "ttwarn",
            snippetType = "autosnippet",
        }, {
            t({"test_that("}),
            t({"", ""}),
            t("    \""),
            i(1, "thing"),
            t("\","),
            t({"", ""}),
            t("    {"),
            t({"", ""}),
            t("        expect_warn("),
            t({"", ""}),
            i(2, "            \"function_call\""),
            t({"", ""}),
            t("        )"),
            t({"", ""}),
            t("    }"),
            t({"", ""}),
            t(")"),
        }),
    },
})
-- }}}

-- new erroring test{{{
ls.add_snippets(nil, {
    r = {
        s({
            trig = "tter",
            namr = "tterror",
            snippetType = "autosnippet",
        }, {
            t({"test_that("}),
            t({"", ""}),
            t("    \""),
            i(1, "thing"),
            t("\","),
            t({"", ""}),
            t("    {"),
            t({"", ""}),
            t("        expect_error("),
            t({"", ""}),
            i(2, "            \"function_call\""),
            t({"", ""}),
            t("        )"),
            t({"", ""}),
            t("    }"),
            t({"", ""}),
            t(")"),
        }),
    },
})
-- }}}

-- other ----------------------------------------------------------------------

-- column names{{{
ls.add_snippets(nil, {
    r = {
        s({
            trig = "coln",
            namr = "column names",
            snippetType = "autosnippet",
        }, {
            t({"colnames("}),
            i(1,""),
            t({")"}),
        }),
    },
})
-- }}}

-- column names pipe{{{
ls.add_snippets(nil, {
    r = {
        s({
            trig = ".c",
            namr = "to column names",
            snippetType = "autosnippet",
        }, {
            t({"|> colnames("}),
            i(1,""),
            t({")"}),
        }),
    },
})
-- }}}

-- unique{{{
ls.add_snippets(nil, {
    r = {
        s({
            trig = "unq",
            namr = "unique",
            snippetType = "autosnippet",
        }, {
            t({"unique("}),
            i(1,""),
            t({")"}),
        }),
    },
})
-- }}}

-- unique pipe{{{
ls.add_snippets(nil, {
    r = {
        s({
            trig = ".u",
            namr = "to unique",
            snippetType = "autosnippet",
        }, {
            t({"|> unique("}),
            i(1,""),
            t({")"}),
        }),
    },
})
-- }}}

-- table pipe{{{
ls.add_snippets(nil, {
    r = {
        s({
            trig = ".t",
            namr = "to table",
            snippetType = "autosnippet",
        }, {
            t({"|> table("}),
            i(1,""),
            t({")"}),
        }),
    },
})
-- }}}

-- lapply{{{
ls.add_snippets(nil, {
    r = {
        s({
            trig = "laply",
            namr = "lapply",
            snippetType = "autosnippet",
        }, {
            t({"lapply("}),
            t({"", "    "}),
            i(1,""),
            t({","}),
            t({"", "    function(x) {"}),
            t({"", "        x"}),
            t({"", "    "}),
            t({"}"}),
            t({"", ")"}),
        }),
    },
})
-- }}}

-- all.equal{{{
ls.add_snippets(nil, {
    r = {
        s({
            trig = "aeq",
            namr = "all equal",
            snippetType = "autosnippet",
        }, {
            t({"all.equal("}),
            i(1,""),
            t({", check.attributes = FALSE)"}),
        }),
    },
})
-- }}}

-- head{{{
ls.add_snippets(nil, {
    r = {
        s({
            trig = ".h",
            namr = "to head",
            snippetType = "autosnippet",
        }, {
            t({"|> head("}),
            i(1,""),
            t({")"}),
        }),
    },
})
-- }}}

-- ggplot text size{{{
ls.add_snippets(nil, {
    r = {
        s({
            trig = "ggfs",
            namr = "ggplot font size",
            snippetType = "autosnippet",
        }, {
            t({"theme(text = element_text(size = 20))"}),
        }),
    },
})
-- }}}
