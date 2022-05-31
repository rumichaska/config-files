
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
            bordered = TRUE,
            height = 750,
            showPageSizeOptions = TRUE,
            defaultPageSize = 50,
            style = list(fontSize = "12px"),
        )
    }
}
