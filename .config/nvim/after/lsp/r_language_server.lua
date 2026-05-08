return {
  root_dir = function(bufnr, on_dir)
    on_dir(vim.fs.root(bufnr, { { ".Rprofile", ".Rproj", "DESCRIPTION", "NAMESPACE", ".Rbuildignore" }, {".git"} }) or
    vim.uv.os_homedir())
  end,
  settings = {
    r = {
      lsp = {
        diagnostic = true,
        rich_documentation = false,
      },
    },
  },
}
