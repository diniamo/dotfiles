local cmp = require('cmp')
local luasnip = require('luasnip')
-- luasnip.snippets = require("luasnip-snippets").load_snippets()
require("luasnip.loaders.from_vscode").lazy_load()

local has_words_before = function()
    local line, col = unpack(vim.api.nvim_win_get_cursor(0))
    return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
end

local kind_icons = {
    Text = "",
    Method = "󰆧",
    Function = "󰊕",
    Constructor = "",
    Field = "󰇽",
    Variable = "󰂡",
    Class = "󰠱",
    Interface = "",
    Module = "",
    Property = "󰜢",
    Unit = "",
    Value = "󰎠",
    Enum = "",
    Keyword = "󰌋",
    Snippet = "",
    Color = "󰏘",
    File = "󰈙",
    Reference = "",
    Folder = "󰉋",
    EnumMember = "",
    Constant = "󰏿",
    Struct = "",
    Event = "",
    Operator = "󰆕",
    TypeParameter = "󰅲",
}

vim.opt.completeopt = { 'menu', 'menuone', 'noselect', 'noinsert' }
cmp.setup {
    preselect = cmp.PreselectMode.None,
    snippet = {
        expand = function(args)
            luasnip.lsp_expand(args.body)
        end
    },
    mapping = cmp.mapping.preset.insert({
        ['<C-b>'] = cmp.mapping.scroll_docs(-4),
        ['<C-f>'] = cmp.mapping.scroll_docs(4),
        ['<C-Space>'] = cmp.mapping.complete(),
        ["<C-e>"] = cmp.mapping { i = cmp.mapping.abort(), c = cmp.mapping.close() },
        ["<CR>"] = cmp.mapping(
            function(_)
                if not cmp.confirm({ select = false }) then
                    require("pairs.enter").type()
                end
            end
        ),
        ["<Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
                cmp.select_next_item()
            elseif luasnip.expand_or_locally_jumpable() then
                luasnip.expand_or_jump()
            elseif has_words_before() then
                cmp.complete()
            else
                fallback()
            end
        end, { "i", "s" }),
        ["<S-Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
                cmp.select_prev_item()
            elseif luasnip.locally_jumpable(-1) then
                luasnip.jump(-1)
            else
                fallback()
            end
        end, { "i", "s" }),
    }),
    sources = cmp.config.sources({
        { name = 'nvim_lsp_signature_help' },
        { name = 'nvim_lsp' },
        { name = 'nvim_lua' },
        { name = 'luasnip' },
        { name = 'buffer' },
        { name = 'async_path' },
    }),
    sorting = {
        priority_weight = 69,
        comparators = {
            cmp.config.compare.offset,
            cmp.config.compare.exact,
            cmp.config.compare.score,
            cmp.config.compare.recently_used,
            -- require("cmp-under-comparator").under,
            cmp.config.compare.kind,
        }
    },
    cmp.setup.cmdline(':', {
        mapping = cmp.mapping.preset.cmdline(),
        sources = cmp.config.sources(
            { { name = 'async_path' } },
            { { name = 'cmdline' } },
            { { name = 'cmdline_history' } }
        )
    }),
    window = {
        completion = cmp.config.window.bordered({
            winhighlight =
            "FloatBorder:FloatBorder,CmpItemAbbrMatchFuzzy:CmpItemAbbrMatch",
        }),
        documentation = cmp.config.window.bordered({
            winhighlight = "FloatBorder:FloatBorder",
        }),
    },
    formatting = {
        fields = { 'menu', 'abbr', 'kind' },
        format = function(_, item)
            item.menu = kind_icons[item.kind]

            return item
        end,
    },
}

local sign = function(opts)
    vim.fn.sign_define(opts.name, {
        texthl = opts.name,
        text = opts.text,
        numhl = ''
    })
end

sign({ name = 'DiagnosticSignError', text = '' })
sign({ name = 'DiagnosticSignWarn', text = '' })
sign({ name = 'DiagnosticSignHint', text = '' })
sign({ name = 'DiagnosticSignInfo', text = '' })

vim.diagnostic.config {
    virtual_text = false,
    signs = true,
    underline = true,
    update_in_insert = false,
    float = {
        border = 'rounded',
        source = 'always',
        header = '',
        prefix = ' ',
    },
}

local lsp_lines_toggle = true
vim.keymap.set('n', '<leader>l',
    function()
        lsp_lines_toggle = not lsp_lines_toggle

        if lsp_lines_toggle then
            vim.diagnostic.config({ virtual_lines = true })
        else
            vim.diagnostic.config({ virtual_lines = false })
        end
    end
)
vim.api.nvim_create_autocmd("ModeChanged", {
    callback = function()
        local current_mode = vim.fn.mode()

        if (current_mode == 'n' or current_mode == 't' or current_mode == 'c') and lsp_lines_toggle then
            -- This fixes the issue where it doesn't appear for some reason
            vim.defer_fn(function()
                vim.diagnostic.config({ virtual_lines = true })
            end, 0)
        else
            vim.diagnostic.config({ virtual_lines = false })
        end
    end
})

-- FIX: vim.lsp.buf.hover rounded border
-- vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, {
--     border = "rounded",
-- })

local navic = require('nvim-navic')
local navbuddy = require('nvim-navbuddy')
local on_attach = function(client, bufnr)
    navic.attach(client, bufnr)
    navbuddy.attach(client, bufnr)

    local bufopts = { noremap = true, silent = true, buffer = bufnr }
    vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, bufopts)
    vim.keymap.set('n', 'gd', vim.lsp.buf.definition, bufopts)
    vim.keymap.set('n', 'K', vim.lsp.buf.hover, bufopts)
    vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, bufopts)
    vim.keymap.set('n', '<C-h>', vim.lsp.buf.signature_help, bufopts)
    vim.keymap.set('n', '<Leader>td', vim.lsp.buf.type_definition, bufopts)
    vim.keymap.set('n', '<Leader>r', vim.lsp.buf.rename, bufopts)
    vim.keymap.set('n', '<Leader>a', vim.lsp.buf.code_action, bufopts)
    vim.keymap.set('n', 'gr', vim.lsp.buf.references, bufopts)
    vim.keymap.set('n', '<Leader>f', function() vim.lsp.buf.format { async = true } end, bufopts)

    -- We use lsp_lines instead
    -- vim.api.nvim_create_autocmd("CursorHold", {
    --     buffer = bufnr,
    --     callback = function()
    --         local opts = {
    --             focusable = false,
    --             close_events = { "BufLeave", "CursorMoved", "InsertEnter", "FocusLost" },
    --             border = 'rounded',
    --             source = 'always',
    --             prefix = ' ',
    --             scope = 'cursor',
    --         }
    --         vim.diagnostic.open_float(nil, opts)
    --     end
    -- })
end
local capabilities = require('cmp_nvim_lsp').default_capabilities()

local lspconfig = require('lspconfig')

lspconfig['lua_ls'].setup {
    on_attach = on_attach,
    capabilities = capabilities,

    settings = {
        Lua = {
            runtime = {
                version = 'LuaJIT',
            },
            diagnostics = {
                globals = { 'vim' },
            },
            workspace = {
                library = vim.api.nvim_get_runtime_file("", true),
            },
            telemetry = {
                enable = false,
            },
        }
    }
}

-- lspconfig['pyright'].setup {
--     on_attach = on_attach,
--     capabilities = capabilities
-- }

local rt = require('rust-tools')
rt.setup {
    server = {
        on_attach = function(client, bufnr)
            navic.attach(client, bufnr)
            navbuddy.attach(client, bufnr)

            local bufopts = { noremap = true, silent = true, buffer = bufnr }

            vim.keymap.set("n", "K", rt.hover_actions.hover_actions, bufopts)
            vim.keymap.set("n", "<Leader>a", rt.code_action_group.code_action_group, bufopts)

            vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, bufopts)
            vim.keymap.set('n', 'gd', vim.lsp.buf.definition, bufopts)
            vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, bufopts)
            vim.keymap.set('n', '<C-h>', vim.lsp.buf.signature_help, bufopts)
            vim.keymap.set('n', '<Leader>td', vim.lsp.buf.type_definition, bufopts)
            vim.keymap.set('n', '<Leader>r', vim.lsp.buf.rename, bufopts)
            vim.keymap.set('n', 'gr', vim.lsp.buf.references, bufopts)
            vim.keymap.set('n', '<Leader>f', function() vim.lsp.buf.format { async = true } end, bufopts)
        end
    }
}
