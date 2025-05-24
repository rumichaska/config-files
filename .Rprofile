# Opciones globales
options(
    encoding = "UTF-8",
    max.print = 1000,
    setWidthOnResize = TRUE
)

# Entorno par funciones locales
.custom_fn <- new.env()

# Función para ver dataframes en browser
if (interactive()) {
    # Limpiar consola en terminal
    system2("clear")
    # Limpiar consola en RStudio
    cat("\014")
    # Bienvenida
    if ("cli" %in% utils::installed.packages()) {
        cli::cli_text(R.version.string)
        cli::cli_text("Running under {utils::osVersion}")
        cli::cli_text("System time is {Sys.time()}")
        cli::cli_text("Library paths set to")
        cli::cli_bullets(
            stats::setNames(
                .libPaths(),
                rep("*", length(.libPaths()))
            )
        )
    }
    # Revisar tablas
    if ("reactable" %in% utils::installed.packages()) {
        .custom_fn$view <- \(.data) {
            reactable::reactable(
                .data,
                resizable = TRUE,
                filterable = TRUE,
                searchable = TRUE,
                striped = TRUE,
                highlight = TRUE,
                compact = TRUE,
                height = 750,
                showPageSizeOptions = TRUE,
                defaultPageSize = 50,
                theme = reactable::reactableTheme(
                    color = "hsl(226, 64%, 88%)",
                    backgroundColor = "hsl(240, 23%, 9%)",
                    borderColor = "hsl(237, 16%, 23%)",
                    borderWidth = NULL,
                    stripedColor = "hsl(240, 21%, 12%)",
                    highlightColor = "hsl(237, 16%, 23%)",
                    cellPadding = NULL,
                    style = NULL,
                    tableStyle = NULL,
                    headerStyle = NULL,
                    groupHeaderStyle = NULL,
                    tableBodyStyle = NULL,
                    rowGroupStyle = NULL,
                    rowStyle = NULL,
                    rowStripedStyle = NULL,
                    rowHighlightStyle = NULL,
                    rowSelectedStyle = NULL,
                    cellStyle = NULL,
                    footerStyle = NULL,
                    inputStyle = list(backgroundColor = "hsl(237, 16%, 23%)"),
                    filterInputStyle = NULL,
                    searchInputStyle = NULL,
                    selectStyle = list(backgroundColor = "hsl(237, 16%, 23%)"),
                    paginationStyle = NULL,
                    pageButtonStyle = NULL,
                    pageButtonHoverStyle = list(backgroundColor = "hsl(237, 16%, 23%)"),
                    pageButtonActiveStyle = list(backgroundColor = "hsl(237, 16%, 23%)"),
                    pageButtonCurrentStyle = NULL
                ),
                style = list(
                    fontSize = "12px",
                    fontFamily = "sans-serif"
                )
            )
        }
    }
}

attach(.custom_fn)
