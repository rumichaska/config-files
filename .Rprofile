
# Encondificación
options(encoding = "UTF-8")

# httpgd
try(httpgd::hgd(silent = TRUE), silent = TRUE)

# Función para ver dataframes en browser
view <- function(.data) {
    if (interactive()) {
        reactable::reactable(
            .data,
            resizable = TRUE,
            filterable = TRUE,
            searchable = TRUE,
            striped = TRUE,
            highlight = TRUE,
            compact = TRUE,
            # bordered = TRUE,
            height = 750,
            showPageSizeOptions = TRUE,
            defaultPageSize = 50,
            theme = reactable::reactableTheme(
                color = "hsl(233, 9%, 87%)",
                backgroundColor = "hsl(233, 9%, 19%)",
                borderColor = "hsl(233, 9%, 22%)",
                borderWidth = NULL,
                stripedColor = "hsl(233, 9%, 22%)",
                highlightColor = "hsl(233, 9%, 24%)",
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
                inputStyle = list(backgroundColor = "hsl(233, 9%, 25%)"),
                filterInputStyle = NULL,
                searchInputStyle = NULL,
                selectStyle = list(backgroundColor = "hsl(233, 9%, 25%)"),
                paginationStyle = NULL,
                pageButtonStyle = NULL,
                pageButtonHoverStyle = list(backgroundColor = "hsl(233, 9%, 25%)"),
                pageButtonActiveStyle = list(backgroundColor = "hsl(233, 9%, 28%)"),
                pageButtonCurrentStyle = NULL
            ),
            style = list(
                fontSize = "12px",
                fontFamily = "sans-serif"
            )
        )
    }
}
