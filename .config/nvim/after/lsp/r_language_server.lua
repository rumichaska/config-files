return {
  on_attach = function(client, _)
    client.server_capabilities.documentFormattingProvider = false
    client.server_capabilities.documentRangeFormattingProvider = false
  end,
  root_dir = function(bufnr, on_dir)
    on_dir(vim.fs.root(bufnr, { { ".Rprofile", ".Rproj", "DESCRIPTION", "NAMESPACE", ".Rbuildignore" }, { ".git" } }) or
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
