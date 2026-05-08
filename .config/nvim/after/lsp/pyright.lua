return {
  settings = {
    pyright = {
      disableOrganizeImports = true,
    },
    python = {
      pythonPath = ".venv/bin/python",
      analysis = {
        autoSearchPaths = true,
        useLibraryCodeForTypes = true,
        diagnosticMode = "workspace",
        typeCheckingMode = "basic",
      },
    },
  },
}
