#' JSON viewer
#'
#' @export
json_view <- function(x, auto_unbox=TRUE,
                      style="xcode", scroll=FALSE,
                      elementId=NULL, width="100%", height=NULL) {

  json_doc_name <- "doc"

  if (!inherits(x, "character") &
      inherits(substitute(x), "name")) {
    json_doc_name <- deparse(substitute(x))
  }

  style <- trimws(tolower(style))

  if (!style %in% highlight_styles()) {
    style <- "default"
    warning(sprintf("Style '%s' not found, using 'default'", style))
  }

  if (inherits(x, "character")) {
    x <- paste0(x, collapse="")
  } else if (inherits(x, "list")) {
    x <- jsonlite::toJSON(x, pretty=TRUE, auto_unbox=auto_unbox)
  }

  params <- list(
    jsonDoc = x,
    styleSheet = style,
    scroll=scroll,
    jsonDocName=json_doc_name
  )

  htmlwidgets::createWidget(
    name = 'jsonview',
    params,
    width = width,
    height = height,
    package = 'jsonview',
    elementId = elementId
  )

}


#' List available styles
#'
#' Returns a character vector of available style sheets to use when displaying
#' an XML document.
#'
#' @references See \url{https://highlightjs.org/static/demo/} for a demo of all
#'             highlight.js styles
#' @export
#' @examples
#' highlight_styles()
highlight_styles <- function() {
  gsub("\\.css$", "",
       grep("\\.css$",
            list.files(system.file("htmlwidgets/lib/highlightjs/styles", package="jsonview")),
            value=TRUE))
}
