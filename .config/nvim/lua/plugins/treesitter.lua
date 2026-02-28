return {
  "nvim-treesitter/nvim-treesitter",
  branch = "main",
  lazy = false,
  build = ":TSUpdate",
  config = function()
    local ts = require("nvim-treesitter")
    local parsers = { "bash", "css", "html", "json", "kitty", "latex", "python", "r", "scss", "yaml" }
    local Util = require("util")

    -- Install parsers
    ts.install(parsers)

    -- Register parsers
    vim.treesitter.language.register("markdown", { "quarto", "rmd" })
    vim.treesitter.language.register("bash", "sh")

    -- Run treesitter features
    vim.api.nvim_create_autocmd("Filetype", {
      group = Util.augroup("treesitter"),
      desc = "Enable treesitter and features",
      callback = function(args)
        -- Enable syntax highlighting for the buffer
        local ok, _ = pcall(vim.treesitter.start, args.buf)
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
