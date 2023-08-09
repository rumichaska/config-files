-- Control de mensaje de errores por falta de cmp
local status_ok, cmp = pcall(require, "cmp")
if not status_ok then
    return
end

-- Control de mensaje de errores por falta de luasnip
local snip_status_ok, luasnip = pcall(require, "luasnip")
if not snip_status_ok then
    return
end

-- Relación de plugins de vscode para lua (*)
require("luasnip.loaders.from_vscode").lazy_load()
-- require("luasnip").filetype_extend("htmldjango", { "html" })

-- Importación de íconos
local icons = require("user.icons")

-- Asiganación de íconos cmp
local kind_icons = icons.cmp_kind

-- Configuración de cmp
cmp.setup({
    snippet = {
        -- Configuración para luasnip engine
        expand = function(args)
            luasnip.lsp_expand(args.body)
        end,
    },
    window = {
        completion = cmp.config.window.bordered(),
        documentation = cmp.config.window.bordered(),
    },
    mapping = {
        -- Mapeo para navegación entre las opciones de autocompletado
        ["<C-b>"] = cmp.mapping.scroll_docs(-4),
        ["<C-f>"] = cmp.mapping.scroll_docs(4),
        ["<C-Space>"] = cmp.mapping.complete(),
        -- Aceptar item seleccionado. Si ninguno está seleccionado, `select` primer item
        -- Seleccionar `select` a `false` para solo confirmar items seleccionados explícitamente
        ["<CR>"] = cmp.mapping.confirm {
            behavior = cmp.ConfirmBehavior.Replace,
            select = true,
        },
        -- Mapeo de navegación con super-tab
        ["<Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
                cmp.select_next_item()
            elseif luasnip.expand_or_jumpable() then
                luasnip.expand_or_jump()
            else
                fallback()
            end
        end, { "i", "s", }),
        ["<S-Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
                cmp.select_prev_item()
            elseif luasnip.jumpable(-1) then
                luasnip.jump(-1)
            else
                fallback()
            end
        end, { "i", "s", }),
    },
    formatting = {
        -- Configuración del formato del menú de autocompletado
        fields = { "abbr", "kind", "menu" }, -- Campos a mostrar en el menú
        format = function(entry, vim_item)
            -- Íconos (Kind icons)
            -- Concatenación de íconos con el nombre del `item kind`
            vim_item.kind = string.format("%s", kind_icons[vim_item.kind])
            vim_item.menu = ({
                -- source = [[name]] sintaxis*
                nvim_lsp = "[LSP]",
                luasnip = "[Snippet]",
                buffer = "[Buffer]",
                path = "[Path]",
                nvim_lua = "[Nvim_Lua]",
            })[entry.source.name]
            return vim_item
        end,
    },
    sources = {
        -- Orden* para las `source` de autocompletado
        { name = "nvim_lsp" },
        { name = "luasnip" },
        { name = "buffer" },
        {
            name = "path",
            option = {
                get_cwd = function()
                    return vim.fn.getcwd()
                end,
            },
        },
        { name = "nvim_lua" }
    },
    confirm_opts = {
        behavior = cmp.ConfirmBehavior.Replace,
        select = false,
    },
    -- Experimental, revisar documentación de cmp
    experimental = {
        ghost_text = true,
        native_menu = false,
    },
})
