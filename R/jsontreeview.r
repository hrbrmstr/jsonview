#' JSON & R list (virtually any object, really) tree viewer
#'
#' Pass in a plaintext JSON or an R \code{list} to see formatted JSON in a viewer.
#'
#' It uses the \code{jsonlite} package to deal with gnarly lists (h/t @@jennybryan).
#'
#' @param x plaintext JSON or an R \code{list}
#' @param auto_unbox passed to \code{fromJSON} (more on this when I have time for documentation)
#' @param scroll should the \code{<div>} holding the HTML/XML content scroll
#'        (\code{TRUE}) or take up the full viewer/browser window (\code{FALSE}).
#'        Default is \code{FALSE} (take up the full viewer/browser window). If
#'        this is set to \code{TRUE}, \code{height} should be set to a value
#'        other than \code{NULL}.
#' @param elementId element id
#' @param width widget width (best to keep it at 100\%)
#' @param height widget height (kinda only useful for knitting since this is
#'        meant to be an interactive tool).
#' @note While this function also works with virtually any R object, large
#'       data structures will render pretty slowly (web browsers weren't
#'       really meant to handle this much structured, visual data)
#' @export
#' @examples
#' library(jsonlite)
#'
#' # available styles
#' highlight_styles()
#'
#' # plain character
#' txt <- '{
#' "glossary": {
#' "title": "example glossary",
#' "GlossDiv": {
#' "title": "S",
#' "GlossList": {
#' "GlossEntry": {
#' "ID": "SGML",
#' "SortAs": "SGML",
#' "GlossTerm": "Standard Generalized Markup Language",
#' "Acronym": "SGML",
#' "Abbrev": "ISO 8879:1986",
#' "GlossDef": {
#' "para": "A meta-markup language, used to create markup languages such as DocBook.",
#' "GlossSeeAlso": ["GML", "XML"]
#' },
#' "GlossSee": "markup"
#' }
#' }
#' }
#' }
#' }'
#'
#' json_tree_view(txt)
#'
#' doc <- fromJSON(txt)
#' json_tree_view(doc)
#' \dontrun{
#' json_tree_view(readLines("https://collector.torproject.org/index.json",
#'                     warn=FALSE))
#'
#' json_tree_view(fromJSON("https://collector.torproject.org/index.json",
#'                    simplifyVector=FALSE))
#' }
json_tree_view <- function(x, auto_unbox=TRUE,
                           scroll=FALSE, elementId=NULL,
                           width="100%", height=NULL) {

json_doc_name <- "doc"

  if (!inherits(x, "character") &
      inherits(substitute(x), "name")) {
    json_doc_name <- deparse(substitute(x))
  }

  if (inherits(x, "character")) {
    x <- paste0(x, collapse="")
  } else if (inherits(x, "list")) {
    x <- jsonlite::toJSON(x, auto_unbox=auto_unbox)
  } else {
    x <- jsonlite::toJSON(x, auto_unbox=auto_unbox, force=TRUE)
  }

  x <- base64enc::base64encode(charToRaw(x))

  params <- list(
    jsonDoc = x,
    scroll=scroll,
    jsonDocName=json_doc_name
  )

  htmlwidgets::createWidget(
    name = 'jsontreeview',
    params,
    width = width,
    height = height,
    package = 'jsonview',
    elementId = elementId
  )

}

