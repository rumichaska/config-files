return {
  settings = {
    pyright = {
      disableOrganizeImports = true,
    },
    python = {
      venvPath = ".",
      venv = ".venv",
      analysis = {
        ignore = { "*" },
      },
    },
  },
}
