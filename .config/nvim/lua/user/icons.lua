-- Extraido de: https://github.com/ChristianChiarulli/nvim/blob/master/lua/user/icons.lua
-- https://github.com/microsoft/vscode/blob/main/src/vs/base/common/codicons.ts
-- go to the above and then enter <c-v>u<unicode> and the symbold should appear
-- or go here and upload the font file:
-- https://mathew-kurian.github.io/CharacterMap/ find more here:
-- https://www.nerdfonts.com/cheat-sheet

vim.g.use_nerd_icons = false
if vim.fn.has "unix" == 1 or vim.g.use_nerd_icons then
    return {
        kind = {
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
        },
        type = {
            Array = "",
            Number = "",
            String = "",
            Boolean = "蘒",
            Object = "",
        },
        documents = {
            File = "",
            Files = "",
            Folder = "",
            OpenFolder = "",
        },
        git = {
            Add = "",
            AddOutline = "",
            Mod = "柳",
            ModOutline = "",
            Remove = "",
            RemoveOutline = "",
            Ignore = "",
            Rename = "",
            Diff = "",
            Repo = "",
            Octoface = "",
        },
        git_status = {
            Unstaged = "",
            Staged = "",
            -- Unmerged = "",
            Renamed = "",
            Untracked = "",
            Deleted = "",
            Ignored = "",
        },
        ui = {
            ArrowClosed = "",
            ArrowOpen = "",
            Lock = "",
            Circle = "",
            BigCircle = "",
            BigUnfilledCircle = "",
            Close = "",
            NewFile = "",
            Search = "",
            Lightbulb = "",
            Project = "",
            Dashboard = "",
            History = "",
            Comment = "",
            Bug = "",
            Code = "",
            Telescope = "",
            TelescopeCaret = "",
            Gear = "",
            Package = "",
            List = "",
            SignIn = "",
            SignOut = "",
            Check = "",
            Fire = "",
            Note = "",
            BookMark = "",
            Pencil = "",
            -- ChevronRight = "",
            ChevronRight = ">",
            Table = "",
            Calendar = "",
            CloudDownload = "",
        },
        diagnostics = {
            Error = "",
            ErrorOutline = "",
            Warning = "",
            WarningOutline = "",
            Information = "",
            InformationOutline = "",
            Hint = "",
            HintOutline = "",
        },
        misc = {
            Robot = "ﮧ",
            Squirrel = "",
            Tag = "",
            Watch = "",
            Smiley = "ﲃ",
            Package = "",
            CircuitBoard = "",
        },
    }
end
