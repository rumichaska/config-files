-- Control de mensaje de errores por falta de autopairs
local status_ok, npairs = pcall(require, "nvim-autopairs")
if not status_ok then
	return
end

-- Configuración de nvim-autopairs
npairs.setup({
    check_ts = true,
    ts_config = {
        lua = { "string", "source" },
        javascript = { "string", "template_string" },
        java = false,
    },
    disable_filetype = { "TelescopePrompt", "spectre_panel" },
    fast_wrap = {
        map = "<M-e>",
        chars = { "{", "[", "(", '"', "'" },
        pattern = string.gsub([[ [%'%"%)%>%]%)%}%,] ]], "%s+", ""),
        offset = -1, -- Offset from pattern match
        end_key = "$",
        keys = "qwertyuiopzxcvbnmasdfghjkl",
        check_comma = true,
        -- highlight = "PmenuSel",
        highlight = "Search",
        highlight_grey = "Comment",
    },
})

-- Definiendo variable local para control de corchetes con cmp
local cmp_autopairs = require("nvim-autopairs.completion.cmp")

-- Control de mensaje de errores por falta de cmp
local cmp_status_ok, cmp = pcall(require, "cmp")
if not cmp_status_ok then
    return
end

cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done { map_char = { tex = "" } })

