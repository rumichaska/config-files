# Opciones globales
options(
    encoding = "UTF-8",
    max.print = 1000,
    setWidthOnResize = TRUE
)

# Bienvenida
if (interactive()) {
    if (requireNamespace("cli", quietly = TRUE)) {
        system2("clear")
        # Bienvenida
        if ("cli" %in% .packages(all.available = TRUE)) {
            cli::cli_h1(cli::style_bold(cli::col_blue(R.version.string)))
            cat("\014")
            cli::cli_text("Running under {utils::osVersion}")
            cli::cli_text("System time is {Sys.time()}")
            cli::cli_text("Working directory:", cli::style_bold(cli::col_green(getwd())))
            cli::cli_text("Library paths set to:")
            cli::cli_ul(cli::style_bold(cli::col_cyan(paste(.libPaths()))))
        }
    }
}

# Consola
if (interactive() || isatty(stdout())) {
    # Consola
    if ("colorout" %in% .packages(all.available = TRUE)) {
        options(colorout.verbose = 0)
        if (require("colorout", quietly = TRUE)) {
            colorout::setOutputColors(
                index = "\x1b[38;2;116;199;236m", # Blue
                normal = "\x1b[38;2;205;214;244m", # Text
                number = "\x1b[38;2;180;190;254m", # Lavender
                negnum = "\x1b[38;2;245;194;178m", # Rosewater
                zero = "\x1b[38;2;205;214;244m", zero.limit = 0.01, # Flamingo
                infinite = "\x1b[38;2;250;179;135;1m", # Peach bold
                string = "\x1b[38;2;166;227;161m", # Green
                date = "\x1b[38;2;147;208;190m", # Teal
                const = "\x1b[38;2;250;179;135;1m", # Peach bold
                true = "\x1b[38;2;166;227;161m", # Green
                false = "\x1b[38;2;250;179;135m", # Peach
                warn = "\x1b[38;2;249;226;175m", # Yellow
                stderror = "\x1b[38;2;243;139;168m", error = "\x1b[38;2;243;139;168m", # Red
                verbose = FALSE
            )
        }
    }
}

# Configurar visor de plots
if (interactive()) {
    if (requireNamespace("httpgd", quietly = TRUE)) {
        options(device = \(...) {
            httpgd::hgd(silent = TRUE)
            plot_url <- httpgd::hgd_url(history = FALSE)
            message("httpgd running at: ", plot_url)
            if (Sys.info()["sysname"] == "Linux") {
                system2(c("firefox", "--new-window", plot_url), wait = FALSE)
            } else {
                httpgd::hgd_browse(history = FALSE)
            }
        })
    }
}

# Enterno de apoyo para funciones y variables
if (!exists(".custom_fn", envir = .GlobalEnv)) {
    .custom_fn <- new.env()
}
# Ver plots
assign(
    "plots",
    \(...) {
        if (interactive()) {
            if (requireNamespace("httpgd", quietly = TRUE)) {
                tryCatch(
                    {
                        server_active <- httpgd::hgd_state()$active
                    },
                    error = function(e) {
                        message("httpgd server state check failed (likely not active): ", e$message)
                    }
                )
                if (httpgd::hgd_state()$active) {
                    plot_url <- httpgd::hgd_url(history = FALSE)
                    if (Sys.info()["sysname"] == "Linux") {
                        system2(c("firefox", "--new-window", plot_url), wait = FALSE)
                    } else {
                        httpgd::hgd_browse(history = FALSE)
                    }
                }
            }
        }
    },
    envir = .custom_fn
)
# Ver tabla
assign(
    "view",
    \(x, ...) {
        if (interactive()) {
            if (requireNamespace("reactable", quietly = TRUE)) {
                if (is.data.frame(x) || is.matrix(x) || inherits(x, "tbl_df")) {
                    reactable::reactable(
                        data = x,
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
                } else {
                    utils::View(x)
                }
            } else {
                utils::View(x)
            }
        } else {
            print(x)
        }
    },
    envir = .custom_fn
)
attach(.custom_fn, name = "custom_fn", pos = 2)
