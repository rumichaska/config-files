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
require("luasnip/loaders/from_vscode").lazy_load()

-- Definiendo variable local para mejorar funcionamiento de super-tab
local check_backspace = function()
    local col = vim.fn.col "." - 1
    return col == 0 or vim.fn.getline("."):sub(col, col):match "%s"
end

--   פּ ﯟ   Íconos para el autocompletado
local kind_icons = {
  Text = "",
  Method = "m",
  Function = "",
  Constructor = "",
  Field = "",
  Variable = "",
  Class = "",
  Interface = "",
  Module = "",
  Property = "",
  Unit = "",
  Value = "",
  Enum = "",
  Keyword = "",
  Snippet = "",
  Color = "",
  File = "",
  Reference = "",
  Folder = "",
  EnumMember = "",
  Constant = "",
  Struct = "",
  Event = "",
  Operator = "",
  TypeParameter = "",
}
-- revisar mas información: https://www.nerdfotns.com/cheat-sheet

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
        documentation = cmp.config.window.bordered()
    },
    mapping = {
        -- Mapeo para navegación entre las opciones de autocompletado
        ["<C-k>"] = cmp.mapping.select_prev_item(),
		["<C-j>"] = cmp.mapping.select_next_item(),
        ["<C-b>"] = cmp.mapping(cmp.mapping.scroll_docs(-1), { "i", "c" }),
        ["<C-f>"] = cmp.mapping(cmp.mapping.scroll_docs(1), { "i", "c" }),
        ["<C-a>"] = cmp.mapping(cmp.mapping.complete(), { "i", "c" }),
        ["<C-y>"] = cmp.config.disable, -- Specify `cmp.config.disable` if you want to remove the default `<C-y>` mapping.
        ["<C-e>"] = cmp.mapping {
            i = cmp.mapping.abort(),
            c = cmp.mapping.close(),
        },
        -- Aceptar item seleccionado. Si ninguno está seleccionado, `select` primer item
        -- Seleccionar `select` a `false` para solo confirmar items seleccionados explícitamente
        ["<CR>"] = cmp.mapping.confirm { select = true },
        -- Mapeo de navegación con super-tab
        ["<Tab>"] = cmp.mapping(function(fallback)
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
            -- vim_item.kind = string.format('%s %s', kind_icons[vim_item.kind], vim_item.kind)
            vim_item.kind = string.format("%s", kind_icons[vim_item.kind])
            vim_item.menu = ({
                -- source = [[name]] sintaxis*
                nvim_lsp = "[LSP]",
                luasnip = "[Snippet]",
                buffer = "[Buffer]",
                path = "[Path]",
            })[entry.source.name]
            return vim_item
        end,
    },
    sources = {
        -- Orden* para las `source` de autocompletado
        { name = "nvim_lsp"},
        { name = "luasnip"},
        { name = "buffer"},
        { name = "path"},
    },
    confirm_opts = {
        behavior = cmp.ConfirmBehavior.Replace,
        select = false,
    },
    -- Documentación sobre la opción de autocompletado
    -- documentation = false, -- Para no mostrar documentación
    -- documentation = {
    --     -- border = { "╭", "─", "╮", "│", "╯", "─", "╰", "│" },
    --     border = "shadow",
    -- },
    -- Experimental, revisar documentación de cmp
    experimental = {
        ghost_text = true,
        native_menu = false,
    },
})
