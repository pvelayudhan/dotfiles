local M = {
    "hrsh7th/nvim-cmp",
    event = "InsertEnter",
    commit = "b5311ab3ed9c846b585c0c15b7559be131ec4be9",
    dependencies = {
        {
            "hrsh7th/cmp-buffer",
            event = "InsertEnter",
            commit = "3022dbc9166796b644a841a02de8dd1cc1d311fa",
        },
        {
            "hrsh7th/cmp-path",
            event = "InsertEnter",
            commit = "91ff86cd9c29299a64f968ebb45846c485725f23",
        },
        {
            "saadparwaiz1/cmp_luasnip",
            event = "InsertEnter",
            commit = "05a9ab28b53f71d1aece421ef32fee2cb857a843",
        },
        {
            "neovim/nvim-lspconfig",
            event = "BufReadPre",
            dependencies = { "hrsh7th/cmp-nvim-lsp" },
        },
        {
            "L3MON4D3/LuaSnip",
            event = "InsertEnter",
            commit = "c1851d5c519611dfc451b6582961b2602e0af89b",
            config = function()
                require("luasnip.loaders.from_lua").load({ paths = "~/.config/nvim/lua/user/snippets" })
            end,
        },
    },
}

function M.config()
    local cmp = require "cmp"
    local luasnip = require "luasnip"
    require("luasnip/loaders/from_vscode").lazy_load({ paths = { "./lua/user/snippets"}})
    require("luasnip").filetype_extend("typescriptreact", { "html" })

    local check_backspace = function()
        local col = vim.fn.col "." - 1
        return col == 0 or vim.fn.getline("."):sub(col, col):match "%s"
    end

    local icons = require "user.icons"

    cmp.setup {
        snippet = {
            expand = function(args)
                luasnip.lsp_expand(args.body) -- For `luasnip` users.
            end,
        },
        mapping = cmp.mapping.preset.insert {
            -- Navigation of the cmp documentation
            ["<C-b>"] = cmp.mapping(cmp.mapping.scroll_docs(-1), { "i", "c" }),
            ["<C-f>"] = cmp.mapping(cmp.mapping.scroll_docs(1), { "i", "c" }),
            -- Ways to confirm a selection
            ["<CR>"] = cmp.mapping(cmp.mapping.confirm({ select = true })),
            ["<C-l>"] = cmp.mapping(cmp.mapping.confirm({ select = false })),
            ["<Right>"] = cmp.mapping(cmp.mapping.confirm({ select = false })),
            ["<C-Space>"] = cmp.mapping(cmp.mapping.confirm({ select = false })),
            -- Copilot
            ["<C-CR>"] = cmp.mapping(
                function(fallback)
                    local copilot_ok, copilot = pcall(require, "copilot.suggestion")

                    if copilot_ok and copilot.is_visible() then
                        copilot.accept()
                    elseif cmp.visible() then
                        cmp.confirm({ select = false })
                    else
                        fallback()
                    end
                end,
                { "i", "s" }
            ),
            -- Navigation of the cmp menu
            ["<Down>"] = cmp.mapping(cmp.mapping.select_next_item(), { "i", "c" }),
            ["<Up>"] = cmp.mapping(cmp.mapping.select_prev_item(), { "i", "c" }),
            ["<Tab>"] = cmp.mapping(
                function(fallback)
                    if cmp.visible() then
                        cmp.select_next_item()
                    elseif luasnip.expandable() then
                        luasnip.expand()
                    elseif luasnip.expand_or_jumpable() then
                        luasnip.expand_or_jump()
                    elseif check_backspace() then
                        fallback()
                    else
                        fallback()
                    end
                end, { "i", "s", }
            ),
            ["<S-Tab>"] = cmp.mapping(
                function(fallback)
                    if cmp.visible() then
                        cmp.select_prev_item()
                    elseif luasnip.jumpable(-1) then
                        luasnip.jump(-1)
                    else
                        fallback()
                    end
                end, { "i", "s", }
            ),
        },
        formatting = {
            fields = { "kind", "abbr", "menu" },
            format = function(entry, vim_item)
                vim_item.kind = icons.kind[vim_item.kind]
                vim_item.menu = ({
                    luasnip = "",
                    buffer = "",
                    path = "",
                })[entry.source.name]

                return vim_item
            end,
        },
        sources = {
            { name = "nvim_lsp"},
            { name = "luasnip" },
            { name = "buffer" },
            --{ name = "path" },
        },
        confirm_opts = {
            behavior = cmp.ConfirmBehavior.Replace,
            select = false,
        },
        window = {
            completion = {
                border = "rounded",
                winhighlight = "Normal:Pmenu,CursorLine:PmenuSel,FloatBorder:FloatBorder,Search:None",
                col_offset = -3,
                side_padding = 1,
                scrollbar = false,
                scrolloff = 8,
            },
            documentation = {
                border = "rounded",
                winhighlight = "Normal:Pmenu,FloatBorder:FloatBorder,Search:None",
            },
        },
        experimental = {
            ghost_text = false,
        },
    }

    pcall(function()
        local function on_confirm_done(...)
            require("nvim-autopairs.completion.cmp").on_confirm_done()(...)
        end
        require("cmp").event:off("confirm_done", on_confirm_done)
        require("cmp").event:on("confirm_done", on_confirm_done)
    end)
end

-- After exiting a snippet, cancel the session so that tabbing around later
--  doesn't jump backwards
-- https://github.com/L3MON4D3/LuaSnip/issues/258#issuecomment-1429989436
vim.api.nvim_create_autocmd('ModeChanged', {
    pattern = '*',
    callback = function()
        if ((vim.v.event.old_mode == 's' and vim.v.event.new_mode == 'n') or vim.v.event.old_mode == 'i')
            and require('luasnip').session.current_nodes[vim.api.nvim_get_current_buf()]
            and not require('luasnip').session.jump_active
        then
            require('luasnip').unlink_current()
        end
    end
})


return M
