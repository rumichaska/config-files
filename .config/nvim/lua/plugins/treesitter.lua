return {
  "nvim-treesitter/nvim-treesitter",
  branch = "main",
  lazy = false,
  build = ":TSUpdate",
  config = function()
    local ts = require("nvim-treesitter")
    local parsers = { "bash", "css", "html", "json", "python", "r", "scss" }
    local Util = require("util")

    -- Install parsers
    ts.install(parsers)

    -- Run treesitter features
    vim.api.nvim_create_autocmd("Filetype", {
      group = Util.augroup("treesitter"),
      desc = "Enable treesitter and features",
      callback = function(args)
        -- Language
        local lang = args.match == "sh" and "bash" or args.match

        -- Enable syntax highlighting for the buffer
        local ok, _ = pcall(vim.treesitter.start, args.buf, lang)
        if not ok then return end

        -- Enable folds in window-local
        vim.wo.foldexpr = "v:lua.vim.treesitter.foldexpr()"
        vim.wo.foldmethod = "expr"
        vim.wo.foldlevel = 99

        -- Enable indentation in buffer-local
        vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
      end,
    })
  end,
}
