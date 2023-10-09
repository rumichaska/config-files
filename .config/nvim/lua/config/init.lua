local M = {}

M.lazy_version = ">=9.1.0"

local defaults = {
    colorscheme = function()
        require("catppuccin").load()
    end,
    -- Load default settings (autocmds and keymaps)
    defaults = {
        autocmds = true, -- config.autocmds
        keymaps = true, -- config.keymaps
    },
    -- Icons used by other plugins
    icons = {
        misc = {
            dots = "󰇘",
        },
        dap = {
            Stopped = { "󰁕 ", "DiagnosticWarn", "DapStoppedLine" },
            Breakpoint = " ",
            BreakpointCondition = " ",
            BreakpointRejected = { " ", "DiagnosticError" },
            LogPoint = ".>",
        },
        diagnostics = {
            Error = " ",
            Warn = " ",
            Hint = " ",
            Info = " ",
        },
        git = {
            added = " ",
            modified = " ",
            removed = " ",
        },
        kinds = {
            Array = "󰅪 ",
            Boolean = " ",
            Class = "󰠱 ",
            Color = " ",
            Constant = "󰏿 ",
            Constructor = " ",
            Copilot = " ",
            Enum = " ",
            EnumMember = " ",
            Event = " ",
            Field = " ",
            File = "󰈙 ",
            Folder = " ",
            Function = "󰊕 ",
            Interface = " ",
            Key = "󰌋 ",
            Keyword = " ",
            Method = "󰆧 ",
            Module = " ",
            Namespace = "󰌗 ",
            Null = "󰟢 ",
            Number = " ",
            Object = "󰅩 ",
            Operator = " ",
            Package = " ",
            Property = "󰜢 ",
            Reference = " ",
            Snippet = " ",
            String = "󰀬 ",
            Struct = " ",
            Text = "󰉿 ",
            TypeParameter = "󰊄 ",
            Unit = " ",
            Value = "󰎠 ",
            Variable = "󰂡 ",
        },
    },
}

local options

function M.setup(opts)
    options = vim.tbl_deep_extend("force", defaults, opts or {})
    if not M.has() then
        require("lazy.core.util").error(
            "**Neovim package manager** needs **lazy.nvim** version "
                .. M.lazy_version
                .. " to work properly.\n"
                .. "Please upgrade **lazy.nvim**",
            { title = "Config" }
        )
        error("Exiting")
    end

    if vim.fn.argc(-1) == 0 then
        -- autocmds and keymaps can wait to load
        vim.api.nvim_create_autocmd("User", {
            group = vim.api.nvim_create_augroup("Config", { clear = true }),
            pattern = "VeryLazy",
            callback = function()
                M.load("autocmds")
                M.load("keymaps")
            end,
        })
    else
        -- load them now so they affect the opened buffers
        M.load("autocmds")
        M.load("keymaps")
    end

    require("lazy.core.util").try(function()
        if type(M.colorscheme) == "function" then
            M.colorscheme()
        else
            vim.cmd.colorscheme(M.colorscheme)
        end
    end, {
        msg = "Could not load your colorscheme",
        on_error = function(msg)
            require("lazy.core.util").error(msg)
            vim.cmd.colorscheme("habamax")
        end,
    })
end

function M.has(range)
    local Semver = require("lazy.manage.semver")
    return Semver.range(range or M.lazy_version):matches(require("lazy.core.config").version or "0.0.0")
end

function M.load(name)
    local Util = require("lazy.core.util")
    local function _load(mod)
        Util.try(function()
            require(mod)
        end, {
            msg = "Failed loading " .. mod,
            on_error = function(msg)
                local info = require("lazy.core.cache").find(mod)
                if info == nil or (type(info) == "table" and #info == 0) then
                    return
                end
                Util.error(msg)
            end,
        })
    end
    -- load user config files (autocmds, keymaps)
    if M.defaults[name] or name == "options" then
        _load("config." .. name)
    end
    if vim.bo.filetype == "lazy" then
        -- HACK: LazyVim may have overwritten options of the Lazy ui, so reset this here
        vim.cmd([[do VimResized]])
    end
    local pattern = "LazyVim" .. name:sub(1, 1):upper() .. name:sub(2)
    vim.api.nvim_exec_autocmds("User", { pattern = pattern, modeline = false })
end

M.did_init = false
function M.init()
    if not M.did_init then
        M.did_init = true
        -- delay notifications til vim.notify() was replaced after 500ms
        require("util").lazy_notify()

        -- load options
        require("config").load("options")
    end
end

-- Return table of defaults with keys if options == nil
setmetatable(M, {
    __index = function(_, key)
        if options == nil then
            return vim.deepcopy(defaults)[key]
        end
        return options[key]
    end,
})

return M
