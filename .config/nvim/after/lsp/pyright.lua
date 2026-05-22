return {
  settings = {
    pyright = {
      disableOrganizeImports = true,
    },
    python = {
      pythonPath = ".venv/bin/python",
      analysis = {
        typeCheckingMode = "basic",
        autoSearchPaths = true,
        useLibraryCodeForTypes = true,
        diagnosticMode = "workspace",
        -- For pandas
        reportUnknownMemberType = false,
        reportUnknownVariableType = false,
        reportUnknownArgumentType = false,
        reportMissingTypeStubs = false,
      },
    },
  },
}
